#include <arm_sve.h>
#include <stdint.h>
#include <stddef.h>

/* Definitions from adler32.c: largest prime smaller than 65536 */
#define BASE 65521U
/* NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 */
#define NMAX 5552

/* Minimum of a and b. */
#define MIN(a, b) ((a) > (b) ? (b) : (a))

static const uint16_t weights[256] = {
    256,255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,
    240,239,238,237,236,235,234,233,232,231,230,229,228,227,226,225,
    224,223,222,221,220,219,218,217,216,215,214,213,212,211,210,209,
    208,207,206,205,204,203,202,201,200,199,198,197,196,195,194,193,
    192,191,190,189,188,187,186,185,184,183,182,181,180,179,178,177,
    176,175,174,173,172,171,170,169,168,167,166,165,164,163,162,161,
    160,159,158,157,156,155,154,153,152,151,150,149,148,147,146,145,
    144,143,142,141,140,139,138,137,136,135,134,133,132,131,130,129,
    128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,
    112,111,110,109,108,107,106,105,104,103,102,101,100, 99, 98, 97,
    96, 95, 94, 93, 92, 91, 90, 89, 88, 87, 86, 85, 84, 83, 82, 81,
    80, 79, 78, 77, 76, 75, 74, 73, 72, 71, 70, 69, 68, 67, 66, 65,
    64, 63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49,
    48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33,
    32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17,
    16, 15, 14, 13, 12, 11, 10,  9,  8,  7,  6,  5,  4,  3,  2,  1,
};

// gocc: adler32_sve2(in uint32, buf []byte) uint32
uint32_t adler32_sve(uint32_t adler, const uint8_t *data, size_t len, size_t cap) {
    if (data == NULL) {
        return 1L;
    }
    if (len == 0) {
        return adler;
    }

    uint32_t s1 = adler & 0xffff;
    uint32_t s2 = adler >> 16;

    size_t vec_len = svcntb();
    if (vec_len > 256) {
        vec_len = 256;
    }

    size_t index = 256 - vec_len;
    svbool_t pg = svptrue_b8();
    svbool_t p1 = svptrue_b16();

    // Load weights
    svuint16_t taps1 = svld1(p1, &weights[index]);
    svuint16_t taps2 = svld1(p1, &weights[index + (vec_len / sizeof(uint16_t))]);

    size_t offset = 0;

    while (len >= vec_len) {
        int iterations = MIN(len/vec_len, NMAX/vec_len);
        for (int i = 0; i < iterations; i++) {
            uint32_t s1_prev = s1;

            svuint8_t vec_data = svld1_u8(pg, &data[offset]);
            offset += vec_len;

            // Sum of bytes
            uint64_t sum_d = svaddv_u8(pg, vec_data);
            s1 += sum_d;

            svuint16_t vec1 = svunpklo_u16(vec_data);
            svuint16_t vec2 = svunpkhi_u16(vec_data);

            // Multiply with taps
            svuint16_t prod1 = svmul_u16_m(p1, vec1, taps1);
            svuint16_t prod2 = svmul_u16_m(p1, vec2, taps2);

            // Sum the products
            uint64_t sum_p1 = svaddv_u16(p1, prod1);
            uint64_t sum_p2 = svaddv_u16(p1, prod2);

            // Update s2
            s2 += s1_prev * vec_len + sum_p1 + sum_p2;
        }

        // Apply modulo
        s1 %= BASE;
        s2 %= BASE;

        len -= iterations * vec_len;
    }

    while (len > 0) {
        s1 += data[offset++];
        s2 += s1;

        s1 %= BASE;
        s2 %= BASE;

        len--;
    }

    return (s2 << 16) | s1;
}

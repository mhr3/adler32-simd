/*
 * Copyright 2017 The Chromium Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the Chromium source repository LICENSE file.
 */
#include <stddef.h>
#include <arm_neon.h>

/* Definitions from adler32.c: largest prime smaller than 65536 */
#define BASE 65521U
/* NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 */
#define NMAX 5552

static uint16_t mult_table[4][8] = {
    { 32, 31, 30, 29, 28, 27, 26, 25 },
    { 24, 23, 22, 21, 20, 19, 18, 17 },
    { 16, 15, 14, 13, 12, 11, 10,  9 },
    {  8,  7,  6,  5,  4,  3,  2,  1 }
};

// gocc: adler32_neon(in uint32, buf []byte) uint32
uint32_t adler32_neon(
    uint32_t adler,
    const unsigned char *buf,
    size_t buf_len, size_t buf_cap)
{
    /*
     * Split Adler-32 into component sums.
     */
    uint32_t s1 = adler & 0xffff;
    uint32_t s2 = adler >> 16;
    /*
     * Serially compute s1 & s2, until the data is 16-byte aligned.
     */
    if ((uintptr_t)buf & 15) {
        while ((uintptr_t)buf & 15) {
            s2 += (s1 += *buf++);
            --buf_len;
        }
        if (s1 >= BASE)
            s1 -= BASE;
        s2 %= BASE;
    }
    /*
     * Process the data in blocks.
     */
    const unsigned BLOCK_SIZE = 1 << 5;
    size_t blocks = buf_len / BLOCK_SIZE;
    buf_len -= blocks * BLOCK_SIZE;

    uint16x8x4_t mtab = vld1q_u16_x4(&mult_table[0][0]);

    while (blocks)
    {
        unsigned n = NMAX / BLOCK_SIZE;  /* The NMAX constraint. */
        if (n > blocks)
            n = blocks;
        blocks -= n;
        /*
         * Process n blocks of data. At most NMAX data bytes can be
         * processed before s2 must be reduced modulo BASE.
         */
        uint32x4_t v_s2 = (uint32x4_t) { 0, 0, 0, s1 * n };
        uint32x4_t v_s1 = (uint32x4_t) { 0, 0, 0, 0 };
        uint16x8_t v_column_sum_1 = vdupq_n_u16(0);
        uint16x8_t v_column_sum_2 = vdupq_n_u16(0);
        uint16x8_t v_column_sum_3 = vdupq_n_u16(0);
        uint16x8_t v_column_sum_4 = vdupq_n_u16(0);
        do {
            /*
             * Load 32 input bytes.
             */
            const uint8x16_t bytes1 = vld1q_u8((uint8_t*)(buf));
            const uint8x16_t bytes2 = vld1q_u8((uint8_t*)(buf + 16));
            /*
             * Add previous block byte sum to v_s2.
             */
            v_s2 = vaddq_u32(v_s2, v_s1);
            /*
             * Horizontally add the bytes for s1.
             */
            v_s1 = vpadalq_u16(v_s1, vpadalq_u8(vpaddlq_u8(bytes1), bytes2));
            /*
             * Vertically add the bytes for s2.
             */
            v_column_sum_1 = vaddw_u8(v_column_sum_1, vget_low_u8 (bytes1));
            v_column_sum_2 = vaddw_u8(v_column_sum_2, vget_high_u8(bytes1));
            v_column_sum_3 = vaddw_u8(v_column_sum_3, vget_low_u8 (bytes2));
            v_column_sum_4 = vaddw_u8(v_column_sum_4, vget_high_u8(bytes2));
            buf += BLOCK_SIZE;
        } while (--n);
        v_s2 = vshlq_n_u32(v_s2, 5);
        /*
         * Multiply-add bytes by [ 32, 31, 30, ... ] for s2.
         */
        v_s2 = vmlal_u16(v_s2, vget_low_u16 (v_column_sum_1), vget_low_u8 (mtab.val[0]));
        v_s2 = vmlal_u16(v_s2, vget_high_u16(v_column_sum_1), vget_high_u8(mtab.val[0]));
        v_s2 = vmlal_u16(v_s2, vget_low_u16 (v_column_sum_2), vget_low_u8 (mtab.val[1]));
        v_s2 = vmlal_u16(v_s2, vget_high_u16(v_column_sum_2), vget_high_u8(mtab.val[1]));
        v_s2 = vmlal_u16(v_s2, vget_low_u16 (v_column_sum_3), vget_low_u8 (mtab.val[2]));
        v_s2 = vmlal_u16(v_s2, vget_high_u16(v_column_sum_3), vget_high_u8(mtab.val[2]));
        v_s2 = vmlal_u16(v_s2, vget_low_u16 (v_column_sum_4), vget_low_u8 (mtab.val[3]));
        v_s2 = vmlal_u16(v_s2, vget_high_u16(v_column_sum_4), vget_high_u8(mtab.val[3]));
        /*
         * Sum epi32 ints v_s1(s2) and accumulate in s1(s2).
         */
        uint32x2_t sum1 = vpadd_u32(vget_low_u32(v_s1), vget_high_u32(v_s1));
        uint32x2_t sum2 = vpadd_u32(vget_low_u32(v_s2), vget_high_u32(v_s2));
        uint32x2_t s1s2 = vpadd_u32(sum1, sum2);
        s1 += vget_lane_u32(s1s2, 0);
        s2 += vget_lane_u32(s1s2, 1);
        /*
         * Reduce.
         */
        s1 %= BASE;
        s2 %= BASE;
    }
    /*
     * Handle leftover data.
     */
    if (buf_len) {
        if (buf_len >= 16) {
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            s2 += (s1 += *buf++);
            buf_len -= 16;
        }
        while (buf_len--) {
            s2 += (s1 += *buf++);
        }
        if (s1 >= BASE)
            s1 -= BASE;
        s2 %= BASE;
    }
    /*
     * Return the recombined sums.
     */
    return s1 | (s2 << 16);
}
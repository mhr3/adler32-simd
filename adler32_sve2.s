//go:build !noasm && arm64
// Code generated by gocc rev-1157562 -- DO NOT EDIT.
//
// Source file         : adler32_sve2.c
// Clang version       : Apple clang version 16.0.0 (clang-1600.0.26.3)
// Target architecture : arm64
// Compiler options    : -march=armv8.5-a+sve2

#include "textflag.h"

DATA weights<>+0x00(SB)/2, $0x0100
DATA weights<>+0x02(SB)/2, $0x00ff
DATA weights<>+0x04(SB)/2, $0x00fe
DATA weights<>+0x06(SB)/2, $0x00fd
DATA weights<>+0x08(SB)/2, $0x00fc
DATA weights<>+0x0a(SB)/2, $0x00fb
DATA weights<>+0x0c(SB)/2, $0x00fa
DATA weights<>+0x0e(SB)/2, $0x00f9
DATA weights<>+0x10(SB)/2, $0x00f8
DATA weights<>+0x12(SB)/2, $0x00f7
DATA weights<>+0x14(SB)/2, $0x00f6
DATA weights<>+0x16(SB)/2, $0x00f5
DATA weights<>+0x18(SB)/2, $0x00f4
DATA weights<>+0x1a(SB)/2, $0x00f3
DATA weights<>+0x1c(SB)/2, $0x00f2
DATA weights<>+0x1e(SB)/2, $0x00f1
DATA weights<>+0x20(SB)/2, $0x00f0
DATA weights<>+0x22(SB)/2, $0x00ef
DATA weights<>+0x24(SB)/2, $0x00ee
DATA weights<>+0x26(SB)/2, $0x00ed
DATA weights<>+0x28(SB)/2, $0x00ec
DATA weights<>+0x2a(SB)/2, $0x00eb
DATA weights<>+0x2c(SB)/2, $0x00ea
DATA weights<>+0x2e(SB)/2, $0x00e9
DATA weights<>+0x30(SB)/2, $0x00e8
DATA weights<>+0x32(SB)/2, $0x00e7
DATA weights<>+0x34(SB)/2, $0x00e6
DATA weights<>+0x36(SB)/2, $0x00e5
DATA weights<>+0x38(SB)/2, $0x00e4
DATA weights<>+0x3a(SB)/2, $0x00e3
DATA weights<>+0x3c(SB)/2, $0x00e2
DATA weights<>+0x3e(SB)/2, $0x00e1
DATA weights<>+0x40(SB)/2, $0x00e0
DATA weights<>+0x42(SB)/2, $0x00df
DATA weights<>+0x44(SB)/2, $0x00de
DATA weights<>+0x46(SB)/2, $0x00dd
DATA weights<>+0x48(SB)/2, $0x00dc
DATA weights<>+0x4a(SB)/2, $0x00db
DATA weights<>+0x4c(SB)/2, $0x00da
DATA weights<>+0x4e(SB)/2, $0x00d9
DATA weights<>+0x50(SB)/2, $0x00d8
DATA weights<>+0x52(SB)/2, $0x00d7
DATA weights<>+0x54(SB)/2, $0x00d6
DATA weights<>+0x56(SB)/2, $0x00d5
DATA weights<>+0x58(SB)/2, $0x00d4
DATA weights<>+0x5a(SB)/2, $0x00d3
DATA weights<>+0x5c(SB)/2, $0x00d2
DATA weights<>+0x5e(SB)/2, $0x00d1
DATA weights<>+0x60(SB)/2, $0x00d0
DATA weights<>+0x62(SB)/2, $0x00cf
DATA weights<>+0x64(SB)/2, $0x00ce
DATA weights<>+0x66(SB)/2, $0x00cd
DATA weights<>+0x68(SB)/2, $0x00cc
DATA weights<>+0x6a(SB)/2, $0x00cb
DATA weights<>+0x6c(SB)/2, $0x00ca
DATA weights<>+0x6e(SB)/2, $0x00c9
DATA weights<>+0x70(SB)/2, $0x00c8
DATA weights<>+0x72(SB)/2, $0x00c7
DATA weights<>+0x74(SB)/2, $0x00c6
DATA weights<>+0x76(SB)/2, $0x00c5
DATA weights<>+0x78(SB)/2, $0x00c4
DATA weights<>+0x7a(SB)/2, $0x00c3
DATA weights<>+0x7c(SB)/2, $0x00c2
DATA weights<>+0x7e(SB)/2, $0x00c1
DATA weights<>+0x80(SB)/2, $0x00c0
DATA weights<>+0x82(SB)/2, $0x00bf
DATA weights<>+0x84(SB)/2, $0x00be
DATA weights<>+0x86(SB)/2, $0x00bd
DATA weights<>+0x88(SB)/2, $0x00bc
DATA weights<>+0x8a(SB)/2, $0x00bb
DATA weights<>+0x8c(SB)/2, $0x00ba
DATA weights<>+0x8e(SB)/2, $0x00b9
DATA weights<>+0x90(SB)/2, $0x00b8
DATA weights<>+0x92(SB)/2, $0x00b7
DATA weights<>+0x94(SB)/2, $0x00b6
DATA weights<>+0x96(SB)/2, $0x00b5
DATA weights<>+0x98(SB)/2, $0x00b4
DATA weights<>+0x9a(SB)/2, $0x00b3
DATA weights<>+0x9c(SB)/2, $0x00b2
DATA weights<>+0x9e(SB)/2, $0x00b1
DATA weights<>+0xa0(SB)/2, $0x00b0
DATA weights<>+0xa2(SB)/2, $0x00af
DATA weights<>+0xa4(SB)/2, $0x00ae
DATA weights<>+0xa6(SB)/2, $0x00ad
DATA weights<>+0xa8(SB)/2, $0x00ac
DATA weights<>+0xaa(SB)/2, $0x00ab
DATA weights<>+0xac(SB)/2, $0x00aa
DATA weights<>+0xae(SB)/2, $0x00a9
DATA weights<>+0xb0(SB)/2, $0x00a8
DATA weights<>+0xb2(SB)/2, $0x00a7
DATA weights<>+0xb4(SB)/2, $0x00a6
DATA weights<>+0xb6(SB)/2, $0x00a5
DATA weights<>+0xb8(SB)/2, $0x00a4
DATA weights<>+0xba(SB)/2, $0x00a3
DATA weights<>+0xbc(SB)/2, $0x00a2
DATA weights<>+0xbe(SB)/2, $0x00a1
DATA weights<>+0xc0(SB)/2, $0x00a0
DATA weights<>+0xc2(SB)/2, $0x009f
DATA weights<>+0xc4(SB)/2, $0x009e
DATA weights<>+0xc6(SB)/2, $0x009d
DATA weights<>+0xc8(SB)/2, $0x009c
DATA weights<>+0xca(SB)/2, $0x009b
DATA weights<>+0xcc(SB)/2, $0x009a
DATA weights<>+0xce(SB)/2, $0x0099
DATA weights<>+0xd0(SB)/2, $0x0098
DATA weights<>+0xd2(SB)/2, $0x0097
DATA weights<>+0xd4(SB)/2, $0x0096
DATA weights<>+0xd6(SB)/2, $0x0095
DATA weights<>+0xd8(SB)/2, $0x0094
DATA weights<>+0xda(SB)/2, $0x0093
DATA weights<>+0xdc(SB)/2, $0x0092
DATA weights<>+0xde(SB)/2, $0x0091
DATA weights<>+0xe0(SB)/2, $0x0090
DATA weights<>+0xe2(SB)/2, $0x008f
DATA weights<>+0xe4(SB)/2, $0x008e
DATA weights<>+0xe6(SB)/2, $0x008d
DATA weights<>+0xe8(SB)/2, $0x008c
DATA weights<>+0xea(SB)/2, $0x008b
DATA weights<>+0xec(SB)/2, $0x008a
DATA weights<>+0xee(SB)/2, $0x0089
DATA weights<>+0xf0(SB)/2, $0x0088
DATA weights<>+0xf2(SB)/2, $0x0087
DATA weights<>+0xf4(SB)/2, $0x0086
DATA weights<>+0xf6(SB)/2, $0x0085
DATA weights<>+0xf8(SB)/2, $0x0084
DATA weights<>+0xfa(SB)/2, $0x0083
DATA weights<>+0xfc(SB)/2, $0x0082
DATA weights<>+0xfe(SB)/2, $0x0081
DATA weights<>+0x100(SB)/2, $0x0080
DATA weights<>+0x102(SB)/2, $0x007f
DATA weights<>+0x104(SB)/2, $0x007e
DATA weights<>+0x106(SB)/2, $0x007d
DATA weights<>+0x108(SB)/2, $0x007c
DATA weights<>+0x10a(SB)/2, $0x007b
DATA weights<>+0x10c(SB)/2, $0x007a
DATA weights<>+0x10e(SB)/2, $0x0079
DATA weights<>+0x110(SB)/2, $0x0078
DATA weights<>+0x112(SB)/2, $0x0077
DATA weights<>+0x114(SB)/2, $0x0076
DATA weights<>+0x116(SB)/2, $0x0075
DATA weights<>+0x118(SB)/2, $0x0074
DATA weights<>+0x11a(SB)/2, $0x0073
DATA weights<>+0x11c(SB)/2, $0x0072
DATA weights<>+0x11e(SB)/2, $0x0071
DATA weights<>+0x120(SB)/2, $0x0070
DATA weights<>+0x122(SB)/2, $0x006f
DATA weights<>+0x124(SB)/2, $0x006e
DATA weights<>+0x126(SB)/2, $0x006d
DATA weights<>+0x128(SB)/2, $0x006c
DATA weights<>+0x12a(SB)/2, $0x006b
DATA weights<>+0x12c(SB)/2, $0x006a
DATA weights<>+0x12e(SB)/2, $0x0069
DATA weights<>+0x130(SB)/2, $0x0068
DATA weights<>+0x132(SB)/2, $0x0067
DATA weights<>+0x134(SB)/2, $0x0066
DATA weights<>+0x136(SB)/2, $0x0065
DATA weights<>+0x138(SB)/2, $0x0064
DATA weights<>+0x13a(SB)/2, $0x0063
DATA weights<>+0x13c(SB)/2, $0x0062
DATA weights<>+0x13e(SB)/2, $0x0061
DATA weights<>+0x140(SB)/2, $0x0060
DATA weights<>+0x142(SB)/2, $0x005f
DATA weights<>+0x144(SB)/2, $0x005e
DATA weights<>+0x146(SB)/2, $0x005d
DATA weights<>+0x148(SB)/2, $0x005c
DATA weights<>+0x14a(SB)/2, $0x005b
DATA weights<>+0x14c(SB)/2, $0x005a
DATA weights<>+0x14e(SB)/2, $0x0059
DATA weights<>+0x150(SB)/2, $0x0058
DATA weights<>+0x152(SB)/2, $0x0057
DATA weights<>+0x154(SB)/2, $0x0056
DATA weights<>+0x156(SB)/2, $0x0055
DATA weights<>+0x158(SB)/2, $0x0054
DATA weights<>+0x15a(SB)/2, $0x0053
DATA weights<>+0x15c(SB)/2, $0x0052
DATA weights<>+0x15e(SB)/2, $0x0051
DATA weights<>+0x160(SB)/2, $0x0050
DATA weights<>+0x162(SB)/2, $0x004f
DATA weights<>+0x164(SB)/2, $0x004e
DATA weights<>+0x166(SB)/2, $0x004d
DATA weights<>+0x168(SB)/2, $0x004c
DATA weights<>+0x16a(SB)/2, $0x004b
DATA weights<>+0x16c(SB)/2, $0x004a
DATA weights<>+0x16e(SB)/2, $0x0049
DATA weights<>+0x170(SB)/2, $0x0048
DATA weights<>+0x172(SB)/2, $0x0047
DATA weights<>+0x174(SB)/2, $0x0046
DATA weights<>+0x176(SB)/2, $0x0045
DATA weights<>+0x178(SB)/2, $0x0044
DATA weights<>+0x17a(SB)/2, $0x0043
DATA weights<>+0x17c(SB)/2, $0x0042
DATA weights<>+0x17e(SB)/2, $0x0041
DATA weights<>+0x180(SB)/2, $0x0040
DATA weights<>+0x182(SB)/2, $0x003f
DATA weights<>+0x184(SB)/2, $0x003e
DATA weights<>+0x186(SB)/2, $0x003d
DATA weights<>+0x188(SB)/2, $0x003c
DATA weights<>+0x18a(SB)/2, $0x003b
DATA weights<>+0x18c(SB)/2, $0x003a
DATA weights<>+0x18e(SB)/2, $0x0039
DATA weights<>+0x190(SB)/2, $0x0038
DATA weights<>+0x192(SB)/2, $0x0037
DATA weights<>+0x194(SB)/2, $0x0036
DATA weights<>+0x196(SB)/2, $0x0035
DATA weights<>+0x198(SB)/2, $0x0034
DATA weights<>+0x19a(SB)/2, $0x0033
DATA weights<>+0x19c(SB)/2, $0x0032
DATA weights<>+0x19e(SB)/2, $0x0031
DATA weights<>+0x1a0(SB)/2, $0x0030
DATA weights<>+0x1a2(SB)/2, $0x002f
DATA weights<>+0x1a4(SB)/2, $0x002e
DATA weights<>+0x1a6(SB)/2, $0x002d
DATA weights<>+0x1a8(SB)/2, $0x002c
DATA weights<>+0x1aa(SB)/2, $0x002b
DATA weights<>+0x1ac(SB)/2, $0x002a
DATA weights<>+0x1ae(SB)/2, $0x0029
DATA weights<>+0x1b0(SB)/2, $0x0028
DATA weights<>+0x1b2(SB)/2, $0x0027
DATA weights<>+0x1b4(SB)/2, $0x0026
DATA weights<>+0x1b6(SB)/2, $0x0025
DATA weights<>+0x1b8(SB)/2, $0x0024
DATA weights<>+0x1ba(SB)/2, $0x0023
DATA weights<>+0x1bc(SB)/2, $0x0022
DATA weights<>+0x1be(SB)/2, $0x0021
DATA weights<>+0x1c0(SB)/2, $0x0020
DATA weights<>+0x1c2(SB)/2, $0x001f
DATA weights<>+0x1c4(SB)/2, $0x001e
DATA weights<>+0x1c6(SB)/2, $0x001d
DATA weights<>+0x1c8(SB)/2, $0x001c
DATA weights<>+0x1ca(SB)/2, $0x001b
DATA weights<>+0x1cc(SB)/2, $0x001a
DATA weights<>+0x1ce(SB)/2, $0x0019
DATA weights<>+0x1d0(SB)/2, $0x0018
DATA weights<>+0x1d2(SB)/2, $0x0017
DATA weights<>+0x1d4(SB)/2, $0x0016
DATA weights<>+0x1d6(SB)/2, $0x0015
DATA weights<>+0x1d8(SB)/2, $0x0014
DATA weights<>+0x1da(SB)/2, $0x0013
DATA weights<>+0x1dc(SB)/2, $0x0012
DATA weights<>+0x1de(SB)/2, $0x0011
DATA weights<>+0x1e0(SB)/2, $0x0010
DATA weights<>+0x1e2(SB)/2, $0x000f
DATA weights<>+0x1e4(SB)/2, $0x000e
DATA weights<>+0x1e6(SB)/2, $0x000d
DATA weights<>+0x1e8(SB)/2, $0x000c
DATA weights<>+0x1ea(SB)/2, $0x000b
DATA weights<>+0x1ec(SB)/2, $0x000a
DATA weights<>+0x1ee(SB)/2, $0x0009
DATA weights<>+0x1f0(SB)/2, $0x0008
DATA weights<>+0x1f2(SB)/2, $0x0007
DATA weights<>+0x1f4(SB)/2, $0x0006
DATA weights<>+0x1f6(SB)/2, $0x0005
DATA weights<>+0x1f8(SB)/2, $0x0004
DATA weights<>+0x1fa(SB)/2, $0x0003
DATA weights<>+0x1fc(SB)/2, $0x0002
DATA weights<>+0x1fe(SB)/2, $0x0001
GLOBL weights<>(SB), (RODATA|NOPTR), $512

TEXT ·adler32_sve2(SB), NOSPLIT, $0-36
	MOVW adler+0(FP), R0
	MOVD data+8(FP), R1
	MOVD len+16(FP), R2
	MOVD cap+24(FP), R3
	CBZ  R1, LBB0_4        // <--                                  // cbz	x1, .LBB0_4
	CBZ  R2, LBB0_13       // <--                                  // cbz	x2, .LBB0_13
	NOP                    // (skipped)                            // stp	x29, x30, [sp, #-16]!
	WORD $0x04bf502a       // ?                                    // rdvl	x10, #1
	MOVW $256, R11         // <--                                  // mov	w11, #256
	CMP  $256, R10         // <--                                  // cmp	x10, #256
	ANDW $65535, R0, R8    // <--                                  // and	w8, w0, #0xffff
	LSRW $16, R0, R9       // <--                                  // lsr	w9, w0, #16
	CSEL LO, R10, R11, R11 // <--                                  // csel	x11, x10, x11, lo
	CMP  R2, R11           // <--                                  // cmp	x11, x2
	NOP                    // (skipped)                            // mov	x29, sp
	BLS  LBB0_5            // <--                                  // b.ls	.LBB0_5
	MOVD ZR, R10           // <--                                  // mov	x10, xzr
	JMP  LBB0_10           // <--                                  // b	.LBB0_10

LBB0_4:
	MOVW $1, R0         // <--                                  // mov	w0, #1
	MOVW R0, ret+32(FP) // <--
	RET                 // <--                                  // ret

LBB0_5:
	LSR   $1, R11, R12        // <--                                  // lsr	x12, x11, #1
	MOVW  $5552, R14          // <--                                  // mov	w14, #5552
	SUB   R11, R12, R15       // <--                                  // sub	x15, x12, x11
	MOVD  $weights<>(SB), R13 // <--                                  // adrp	x13, weights
	ADD   $0, R13, R13        // <--                                  // add	x13, x13, :lo12:weights
	UDIVW R11, R14, R12       // <--                                  // udiv	w12, w14, w11
	SUB   R11<<1, R13, R16    // <--                                  // sub	x16, x13, x11, lsl #1
	ADD   R15<<1, R13, R13    // <--                                  // add	x13, x13, x15, lsl #1
	MOVD  $256, R14           // <--                                  // mov	x14, #256
	WORD  $0x2558e3e0         // ?                                    // ptrue	p0.h
	MOVD  ZR, R10             // <--                                  // mov	x10, xzr
	WORD  $0xa4ae4200         // ?                                    // ld1h	{ z0.h }, p0/z, [x16, x14, lsl #1]
	WORD  $0xa4ae41a1         // ?                                    // ld1h	{ z1.h }, p0/z, [x13, x14, lsl #1]
	MOVW  $32881, R13         // <--                                  // mov	w13, #32881
	MOVW  $65521, R14         // <--                                  // mov	w14, #65521
	MOVKW $(32775<<16), R13   // <--                                  // movk	w13, #32775, lsl #16
	WORD  $0x2518e3e0         // ?                                    // ptrue	p0.b
	JMP   LBB0_7              // <--                                  // b	.LBB0_7

LBB0_6:
	UMULL R13, R8, R16     // <--                                  // umull	x16, w8, w13
	UMULL R13, R9, R17     // <--                                  // umull	x17, w9, w13
	LSR   $47, R16, R16    // <--                                  // lsr	x16, x16, #47
	MSUB  R11, R2, R15, R2 // <--                                  // msub	x2, x15, x11, x2
	LSR   $47, R17, R17    // <--                                  // lsr	x17, x17, #47
	MSUBW R14, R8, R16, R8 // <--                                  // msub	w8, w16, w14, w8
	CMP   R11, R2          // <--                                  // cmp	x2, x11
	MSUBW R14, R9, R17, R9 // <--                                  // msub	w9, w17, w14, w9
	BCC   LBB0_9           // <--                                  // b.lo	.LBB0_9

LBB0_7:
	UDIV R11, R2, R15      // <--                                  // udiv	x15, x2, x11
	CMP  R12, R15          // <--                                  // cmp	x15, x12
	CSEL LO, R15, R12, R15 // <--                                  // csel	x15, x15, x12, lo
	MOVW R15, R16          // <--                                  // mov	w16, w15
	CBZW R15, LBB0_6       // <--                                  // cbz	w15, .LBB0_6

LBB0_8:
	WORD  $0xa40a4022     // ?                                    // ld1b	{ z2.b }, p0/z, [x1, x10]
	ADD   R11, R10, R10   // <--                                  // add	x10, x10, x11
	SUBSW $1, R16, R16    // <--                                  // subs	w16, w16, #1
	WORD  $0x04012043     // ?                                    // uaddv	d3, p0, z2.b
	WORD  $0x05723844     // ?                                    // uunpklo	z4.h, z2.b
	FMOVD F3, R17         // <--                                  // fmov	x17, d3
	WORD  $0x04606083     // ?                                    // mul	z3.h, z4.h, z0.h
	WORD  $0x04412063     // ?                                    // uaddv	d3, p0, z3.h
	WORD  $0x05733842     // ?                                    // uunpkhi	z2.h, z2.b
	FMOVD F3, R0          // <--                                  // fmov	x0, d3
	WORD  $0x04616042     // ?                                    // mul	z2.h, z2.h, z1.h
	WORD  $0x04412042     // ?                                    // uaddv	d2, p0, z2.h
	MADDW R8, R0, R11, R0 // <--                                  // madd	w0, w11, w8, w0
	ADDW  R17, R8, R8     // <--                                  // add	w8, w8, w17
	FMOVD F2, R17         // <--                                  // fmov	x17, d2
	ADDW  R17, R9, R9     // <--                                  // add	w9, w9, w17
	ADDW  R0, R9, R9      // <--                                  // add	w9, w9, w0
	BNE   LBB0_8          // <--                                  // b.ne	.LBB0_8
	JMP   LBB0_6          // <--                                  // b	.LBB0_6

LBB0_9:
	CBZ R2, LBB0_12 // <--                                  // cbz	x2, .LBB0_12

LBB0_10:
	MOVW  $32881, R11       // <--                                  // mov	w11, #32881
	ADD   R10, R1, R10      // <--                                  // add	x10, x1, x10
	MOVKW $(32775<<16), R11 // <--                                  // movk	w11, #32775, lsl #16
	MOVW  $65521, R12       // <--                                  // mov	w12, #65521

LBB0_11:
	WORD  $0x3840154d      // MOVBU.P 1(R10), R13                  // ldrb	w13, [x10], #1
	SUBS  $1, R2, R2       // <--                                  // subs	x2, x2, #1
	ADDW  R13, R8, R8      // <--                                  // add	w8, w8, w13
	ADDW  R9, R8, R9       // <--                                  // add	w9, w8, w9
	UMULL R11, R8, R13     // <--                                  // umull	x13, w8, w11
	UMULL R11, R9, R14     // <--                                  // umull	x14, w9, w11
	LSR   $47, R13, R13    // <--                                  // lsr	x13, x13, #47
	LSR   $47, R14, R14    // <--                                  // lsr	x14, x14, #47
	MSUBW R12, R8, R13, R8 // <--                                  // msub	w8, w13, w12, w8
	MSUBW R12, R9, R14, R9 // <--                                  // msub	w9, w14, w12, w9
	BNE   LBB0_11          // <--                                  // b.ne	.LBB0_11

LBB0_12:
	ORRW R9<<16, R8, R0 // <--                                  // orr	w0, w8, w9, lsl #16
	NOP                 // (skipped)                            // ldp	x29, x30, [sp], #16

LBB0_13:
	MOVW R0, ret+32(FP) // <--
	RET                 // <--                                  // ret

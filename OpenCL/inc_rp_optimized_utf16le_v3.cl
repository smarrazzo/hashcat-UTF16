/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

#include "inc_vendor.h"
#include "inc_types.h"
#include "inc_platform.h"
#include "inc_common.h"
#include "inc_rp_optimized_utf16le_v3.h"

#include "inc_rp_common.cl"

#ifndef MAYBE_UNUSED
#define MAYBE_UNUSED
#endif

DECLSPEC void generate_acmask_optimized_utf16le (PRIVATE_AS const u32 *buf0, PRIVATE_AS u32 *cmask) // OK - Perte de perf dans le lmask
{ 
  const u32 a = 0x00050005u;
  const u32 c = 0x001f001fu;
  const u32 l = 0x00400040u;
  const u32 h = 0x00800080u;

  cmask[0 ] = ((buf0[0 ] & l) >> 1u) & ~((buf0[0 ] & h) >> 2u) & ~((buf0[0 ] & c) + a) & ((buf0[0 ] & c) + c); 
  cmask[1 ] = ((buf0[1 ] & l) >> 1u) & ~((buf0[1 ] & h) >> 2u) & ~((buf0[1 ] & c) + a) & ((buf0[1 ] & c) + c); 
  cmask[2 ] = ((buf0[2 ] & l) >> 1u) & ~((buf0[2 ] & h) >> 2u) & ~((buf0[2 ] & c) + a) & ((buf0[2 ] & c) + c); 
  cmask[3 ] = ((buf0[3 ] & l) >> 1u) & ~((buf0[3 ] & h) >> 2u) & ~((buf0[3 ] & c) + a) & ((buf0[3 ] & c) + c); 
  cmask[4 ] = ((buf0[4 ] & l) >> 1u) & ~((buf0[4 ] & h) >> 2u) & ~((buf0[4 ] & c) + a) & ((buf0[4 ] & c) + c); 
  cmask[5 ] = ((buf0[5 ] & l) >> 1u) & ~((buf0[5 ] & h) >> 2u) & ~((buf0[5 ] & c) + a) & ((buf0[5 ] & c) + c); 
  cmask[6 ] = ((buf0[6 ] & l) >> 1u) & ~((buf0[6 ] & h) >> 2u) & ~((buf0[6 ] & c) + a) & ((buf0[6 ] & c) + c); 
  cmask[7 ] = ((buf0[7 ] & l) >> 1u) & ~((buf0[7 ] & h) >> 2u) & ~((buf0[7 ] & c) + a) & ((buf0[7 ] & c) + c);
  cmask[8 ] = ((buf0[8 ] & l) >> 1u) & ~((buf0[8 ] & h) >> 2u) & ~((buf0[8 ] & c) + a) & ((buf0[8 ] & c) + c); 
  cmask[9 ] = ((buf0[9 ] & l) >> 1u) & ~((buf0[9 ] & h) >> 2u) & ~((buf0[9 ] & c) + a) & ((buf0[9 ] & c) + c); 
  cmask[10] = ((buf0[10] & l) >> 1u) & ~((buf0[10] & h) >> 2u) & ~((buf0[10] & c) + a) & ((buf0[10] & c) + c); 
  cmask[11] = ((buf0[11] & l) >> 1u) & ~((buf0[11] & h) >> 2u) & ~((buf0[11] & c) + a) & ((buf0[11] & c) + c); 
  cmask[12] = ((buf0[12] & l) >> 1u) & ~((buf0[12] & h) >> 2u) & ~((buf0[12] & c) + a) & ((buf0[12] & c) + c); 
  cmask[13] = ((buf0[13] & l) >> 1u) & ~((buf0[13] & h) >> 2u) & ~((buf0[13] & c) + a) & ((buf0[13] & c) + c); 
  cmask[14] = ((buf0[14] & l) >> 1u) & ~((buf0[14] & h) >> 2u) & ~((buf0[14] & c) + a) & ((buf0[14] & c) + c); 
  cmask[15] = ((buf0[15] & l) >> 1u) & ~((buf0[15] & h) >> 2u) & ~((buf0[15] & c) + a) & ((buf0[15] & c) + c);

}

DECLSPEC void truncate_right_optimized_utf16le (PRIVATE_AS u32 *buf0, const u32 offset)
{
  const u32 m = (1u << ((offset & 2u) * 8u)) - 1u;
  const int pos = offset / 4;

  u32 t[16];
  
  t[0 ] = (pos == 0 )? m : (pos < 0 )? 0xffffffffffffffffu : 0u ;
  t[1 ] = (pos == 1 )? m : (pos < 1 )? 0xffffffffffffffffu : 0u ;
  t[2 ] = (pos == 2 )? m : (pos < 2 )? 0xffffffffffffffffu : 0u ;
  t[3 ] = (pos == 3 )? m : (pos < 3 )? 0xffffffffffffffffu : 0u ;
  t[4 ] = (pos == 4 )? m : (pos < 4 )? 0xffffffffffffffffu : 0u ;
  t[5 ] = (pos == 5 )? m : (pos < 5 )? 0xffffffffffffffffu : 0u ;
  t[6 ] = (pos == 6 )? m : (pos < 6 )? 0xffffffffffffffffu : 0u ;
  t[7 ] = (pos == 7 )? m : (pos < 7 )? 0xffffffffffffffffu : 0u ;
  t[8 ] = (pos == 8 )? m : (pos < 8 )? 0xffffffffffffffffu : 0u ;
  t[9 ] = (pos == 9 )? m : (pos < 9 )? 0xffffffffffffffffu : 0u ;
  t[10] = (pos == 10)? m : (pos < 10)? 0xffffffffffffffffu : 0u ;
  t[11] = (pos == 11)? m : (pos < 11)? 0xffffffffffffffffu : 0u ;
  t[12] = (pos == 12)? m : (pos < 12)? 0xffffffffffffffffu : 0u ;
  t[13] = (pos == 13)? m : (pos < 13)? 0xffffffffffffffffu : 0u ;
  t[14] = (pos == 14)? m : (pos < 14)? 0xffffffffffffffffu : 0u ;
  t[15] = (pos == 15)? m : (pos < 15)? 0xffffffffffffffffu : 0u ;

  buf0[0 ] &= t[0 ];
  buf0[1 ] &= t[1 ];
  buf0[2 ] &= t[2 ];
  buf0[3 ] &= t[3 ];
  buf0[4 ] &= t[4 ];
  buf0[5 ] &= t[5 ];
  buf0[6 ] &= t[6 ];
  buf0[7 ] &= t[7 ];
  buf0[8 ] &= t[8 ];
  buf0[9 ] &= t[9 ];
  buf0[10] &= t[10];
  buf0[11] &= t[11];
  buf0[12] &= t[12];
  buf0[13] &= t[13];
  buf0[14] &= t[14];
  buf0[15] &= t[15];
}

DECLSPEC void truncate_left_optimized_utf16le (PRIVATE_AS u32 *buf0, const u32 offset) 
{
  const u32 m = (1u << ((offset & 2u) * 8u)) - 1u;
  const int pos = offset / 4;

  u32 t[16];
  
  t[0 ] = (pos == 0 )? m : (pos > 0 )? 0xffffffffffffffffu : 0u ;
  t[1 ] = (pos == 1 )? m : (pos > 1 )? 0xffffffffffffffffu : 0u ;
  t[2 ] = (pos == 2 )? m : (pos > 2 )? 0xffffffffffffffffu : 0u ;
  t[3 ] = (pos == 3 )? m : (pos > 3 )? 0xffffffffffffffffu : 0u ;
  t[4 ] = (pos == 4 )? m : (pos > 4 )? 0xffffffffffffffffu : 0u ;
  t[5 ] = (pos == 5 )? m : (pos > 5 )? 0xffffffffffffffffu : 0u ;
  t[6 ] = (pos == 6 )? m : (pos > 6 )? 0xffffffffffffffffu : 0u ;
  t[7 ] = (pos == 7 )? m : (pos > 7 )? 0xffffffffffffffffu : 0u ;
  t[8 ] = (pos == 8 )? m : (pos > 8 )? 0xffffffffffffffffu : 0u ;
  t[9 ] = (pos == 9 )? m : (pos > 9 )? 0xffffffffffffffffu : 0u ;
  t[10] = (pos == 10)? m : (pos > 10)? 0xffffffffffffffffu : 0u ;
  t[11] = (pos == 11)? m : (pos > 11)? 0xffffffffffffffffu : 0u ;
  t[12] = (pos == 12)? m : (pos > 12)? 0xffffffffffffffffu : 0u ;
  t[13] = (pos == 13)? m : (pos > 13)? 0xffffffffffffffffu : 0u ;
  t[14] = (pos == 14)? m : (pos > 14)? 0xffffffffffffffffu : 0u ;
  t[15] = (pos == 15)? m : (pos > 15)? 0xffffffffffffffffu : 0u ;

  buf0[0 ] &= t[0 ];
  buf0[1 ] &= t[1 ];
  buf0[2 ] &= t[2 ];
  buf0[3 ] &= t[3 ];
  buf0[4 ] &= t[4 ];
  buf0[5 ] &= t[5 ];
  buf0[6 ] &= t[6 ];
  buf0[7 ] &= t[7 ];
  buf0[8 ] &= t[8 ];
  buf0[9 ] &= t[9 ];
  buf0[10] &= t[10];
  buf0[11] &= t[11];
  buf0[12] &= t[12];
  buf0[13] &= t[13];
  buf0[14] &= t[14];
  buf0[15] &= t[15];
}

DECLSPEC void lshift_block_optimized_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0)
{
  out0[0 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
  out0[1 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
  out0[2 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
  out0[3 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
  out0[4 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
  out0[5 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
  out0[6 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
  out0[7 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
  out0[8 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
  out0[9 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
  out0[10] = hc_2bytesalign_S (in0[10], in0[11], 2);
  out0[11] = hc_2bytesalign_S (in0[11], in0[12], 2);
  out0[12] = hc_2bytesalign_S (in0[12], in0[13], 2);
  out0[13] = hc_2bytesalign_S (in0[13], in0[14], 2);
  out0[14] = hc_2bytesalign_S (in0[14], in0[15], 2);
  out0[15] = hc_2bytesalign_S (in0[15],      0 , 2);
}

DECLSPEC void rshift_block_optimized_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0)
{
  out0[15] = hc_2bytesalign_S (in0[15], in0[15], 2);
  out0[14] = hc_2bytesalign_S (in0[14], in0[14], 2);
  out0[13] = hc_2bytesalign_S (in0[13], in0[13], 2);
  out0[12] = hc_2bytesalign_S (in0[12], in0[12], 2);
  out0[11] = hc_2bytesalign_S (in0[11], in0[11], 2);
  out0[10] = hc_2bytesalign_S (in0[10], in0[10], 2);
  out0[9 ] = hc_2bytesalign_S (in0[9 ], in0[9 ], 2);
  out0[8 ] = hc_2bytesalign_S (in0[8 ], in0[8 ], 2);
  out0[7 ] = hc_2bytesalign_S (in0[7 ], in0[7 ], 2);
  out0[6 ] = hc_2bytesalign_S (in0[6 ], in0[6 ], 2);
  out0[5 ] = hc_2bytesalign_S (in0[5 ], in0[5 ], 2);
  out0[4 ] = hc_2bytesalign_S (in0[4 ], in0[4 ], 2);
  out0[3 ] = hc_2bytesalign_S (in0[3 ], in0[3 ], 2);
  out0[2 ] = hc_2bytesalign_S (in0[2 ], in0[2 ], 2);
  out0[1 ] = hc_2bytesalign_S (in0[1 ], in0[1 ], 2);
  out0[0 ] = hc_2bytesalign_S (     0 , in0[0 ], 2);
}

DECLSPEC void lshift_block_optimized_N_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0, const u32 num)
{
  switch (num)
  {
    case  0:  out0[0 ] = in0[0 ];
              out0[1 ] = in0[1 ];
              out0[2 ] = in0[2 ];
              out0[3 ] = in0[3 ];
              out0[4 ] = in0[4 ];
              out0[5 ] = in0[5 ];
              out0[6 ] = in0[6 ];
              out0[7 ] = in0[7 ];
              out0[8 ] = in0[8 ];
              out0[9 ] = in0[9 ];
              out0[10] = in0[10];
              out0[11] = in0[11];
              out0[12] = in0[12];
              out0[13] = in0[13];
              out0[14] = in0[14];
              out0[15] = in0[15];
              break;
    case  2:  out0[0 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[10] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[11] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[12] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[13] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[14] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[15] = hc_2bytesalign_S (in0[15],      0, 2);
              break;
    case  4:  out0[0 ] = in0[1 ];
              out0[1 ] = in0[2 ];
              out0[2 ] = in0[3 ];
              out0[3 ] = in0[4 ];
              out0[4 ] = in0[5 ];
              out0[5 ] = in0[6 ];
              out0[6 ] = in0[7 ];
              out0[7 ] = in0[8 ];
              out0[8 ] = in0[9 ];
              out0[9 ] = in0[10];
              out0[10] = in0[11];
              out0[11] = in0[12];
              out0[12] = in0[13];
              out0[13] = in0[14];
              out0[14] = in0[15];
              out0[15] = 0;
              break;
    case  6:  out0[0 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[9 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[10] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[11] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[12] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[13] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[14] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[15] = 0;
              break;
    case  8:  out0[0 ] = in0[2 ];
              out0[1 ] = in0[3 ];
              out0[2 ] = in0[4 ];
              out0[3 ] = in0[5 ];
              out0[4 ] = in0[6 ];
              out0[5 ] = in0[7 ];
              out0[6 ] = in0[8 ];
              out0[7 ] = in0[9 ];
              out0[8 ] = in0[10];
              out0[9 ] = in0[11];
              out0[10] = in0[12];
              out0[11] = in0[13];
              out0[12] = in0[14];
              out0[13] = in0[15];
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  10: out0[0 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[8 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[9 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[10] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[11] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[12] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[13] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  12: out0[0 ] = in0[3 ];
              out0[1 ] = in0[4 ];
              out0[2 ] = in0[5 ];
              out0[3 ] = in0[6 ];
              out0[4 ] = in0[7 ];
              out0[5 ] = in0[8 ];
              out0[6 ] = in0[9 ];
              out0[7 ] = in0[10];
              out0[8 ] = in0[11];
              out0[9 ] = in0[12];
              out0[10] = in0[13];
              out0[11] = in0[14];
              out0[12] = in0[15];
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  14: out0[0 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[7 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[8 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[9 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[10] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[11] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[12] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  16: out0[0 ] = in0[4 ];
              out0[1 ] = in0[5 ];
              out0[2 ] = in0[6 ];
              out0[3 ] = in0[7 ];
              out0[4 ] = in0[8 ];
              out0[5 ] = in0[9 ];
              out0[6 ] = in0[10];
              out0[7 ] = in0[11];
              out0[8 ] = in0[12];
              out0[9 ] = in0[13];
              out0[10] = in0[14];
              out0[11] = in0[15];
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  18: out0[0 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[6 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[7 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[8 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[9 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[10] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[11] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 20:  out0[0 ] = in0[5 ];
              out0[1 ] = in0[6 ];
              out0[2 ] = in0[7 ];
              out0[3 ] = in0[8 ];
              out0[4 ] = in0[9 ];
              out0[5 ] = in0[10];
              out0[6 ] = in0[11];
              out0[7 ] = in0[12];
              out0[8 ] = in0[13];
              out0[9 ] = in0[14];
              out0[10] = in0[15];
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 22:  out0[0 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[5 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[6 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[7 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[8 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[9 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[10] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 24:  out0[0 ] = in0[6 ];
              out0[1 ] = in0[7 ];
              out0[2 ] = in0[8 ];
              out0[3 ] = in0[9 ];
              out0[4 ] = in0[10];
              out0[5 ] = in0[11];
              out0[6 ] = in0[12];
              out0[7 ] = in0[13];
              out0[8 ] = in0[14];
              out0[9 ] = in0[15];
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 26:  out0[0 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[4 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[5 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[6 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[7 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[8 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[9 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 28:  out0[0 ] = in0[7 ];
              out0[1 ] = in0[8 ];
              out0[2 ] = in0[9 ];
              out0[3 ] = in0[10];
              out0[4 ] = in0[11];
              out0[5 ] = in0[12];
              out0[6 ] = in0[13];
              out0[7 ] = in0[14];
              out0[8 ] = in0[15];
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 30:  out0[0 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[3 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[4 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[5 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[6 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[7 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[8 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  32: out0[0 ] = in0[8 ];
              out0[1 ] = in0[9 ];
              out0[2 ] = in0[10];
              out0[3 ] = in0[11];
              out0[4 ] = in0[12];
              out0[5 ] = in0[13];
              out0[6 ] = in0[14];
              out0[7 ] = in0[15];
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  34: out0[0 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[2 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[3 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[4 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[5 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[6 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[7 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  36: out0[0 ] = in0[9 ];
              out0[1 ] = in0[10];
              out0[2 ] = in0[11];
              out0[3 ] = in0[12];
              out0[4 ] = in0[13];
              out0[5 ] = in0[14];
              out0[6 ] = in0[15];
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  38: out0[0 ] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[1 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[2 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[3 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[4 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[5 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[6 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  40: out0[0 ] = in0[10];
              out0[1 ] = in0[11];
              out0[2 ] = in0[12];
              out0[3 ] = in0[13];
              out0[4 ] = in0[14];
              out0[5 ] = in0[15];
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  42: out0[0 ] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[1 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[2 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[3 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[4 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[5 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  44: out0[0 ] = in0[11];
              out0[1 ] = in0[12];
              out0[2 ] = in0[13];
              out0[3 ] = in0[14];
              out0[4 ] = in0[15];
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  46: out0[0 ] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[1 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[2 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[3 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[4 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  48: out0[0 ] = in0[12];
              out0[1 ] = in0[13];
              out0[2 ] = in0[14];
              out0[3 ] = in0[15];
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case  50: out0[0 ] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[1 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[2 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[3 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 52:  out0[0 ] = in0[13];
              out0[1 ] = in0[14];
              out0[2 ] = in0[15];
              out0[3 ] = 0;
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 54:  out0[0 ] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[1 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[2 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[3 ] = 0;
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 56:  out0[0 ] = in0[14];
              out0[1 ] = in0[15];
              out0[2 ] = 0;
              out0[3 ] = 0;
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 58:  out0[0 ] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[1 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[2 ] = 0;
              out0[3 ] = 0;
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 60:  out0[0 ] = in0[15];
              out0[1 ] = 0;
              out0[2 ] = 0;
              out0[3 ] = 0;
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
    case 62:  out0[0 ] = hc_2bytesalign_S (in0[15],      0, 2);
              out0[1 ] = 0;
              out0[2 ] = 0;
              out0[3 ] = 0;
              out0[4 ] = 0;
              out0[5 ] = 0;
              out0[6 ] = 0;
              out0[7 ] = 0;
              out0[8 ] = 0;
              out0[9 ] = 0;
              out0[10] = 0;
              out0[11] = 0;
              out0[12] = 0;
              out0[13] = 0;
              out0[14] = 0;
              out0[15] = 0;
              break;
  }
}

DECLSPEC void rshift_block_optimized_N_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0, const u32 num)
{
  switch (num)
  {
    case  0:  out0[15] = in0[15];
              out0[14] = in0[14];
              out0[13] = in0[13];
              out0[12] = in0[12];
              out0[11] = in0[11];
              out0[10] = in0[10];
              out0[9 ] = in0[9 ];
              out0[8 ] = in0[8 ];
              out0[7 ] = in0[7 ];
              out0[6 ] = in0[6 ];
              out0[5 ] = in0[5 ];
              out0[4 ] = in0[4 ];
              out0[3 ] = in0[3 ];
              out0[2 ] = in0[2 ];
              out0[1 ] = in0[1 ];
              out0[0 ] = in0[0 ];
              break;
    case  2:  out0[15] = hc_2bytesalign_S (in0[14], in0[15], 2);
              out0[14] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[13] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[12] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[11] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[10] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[9 ] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[1 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[0 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              break;
    case  4:  out0[15] = in0[14];
              out0[14] = in0[13];
              out0[13] = in0[12];
              out0[12] = in0[11];
              out0[11] = in0[10];
              out0[10] = in0[9 ];
              out0[9 ] = in0[8 ];
              out0[8 ] = in0[7 ];
              out0[7 ] = in0[6 ];
              out0[6 ] = in0[5 ];
              out0[5 ] = in0[4 ];
              out0[4 ] = in0[3 ];
              out0[3 ] = in0[2 ];
              out0[2 ] = in0[1 ];
              out0[1 ] = in0[0 ];
              out0[0 ] = 0;
              break;
    case  6:  out0[15] = hc_2bytesalign_S (in0[13], in0[14], 2);
              out0[14] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[13] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[12] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[11] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[10] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[2 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[1 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[0 ] = 0;
              break;
    case  8:  out0[15] = in0[13];
              out0[14] = in0[12];
              out0[13] = in0[11];
              out0[12] = in0[10];
              out0[11] = in0[9 ];
              out0[10] = in0[8 ];
              out0[9 ] = in0[7 ];
              out0[8 ] = in0[6 ];
              out0[7 ] = in0[5 ];
              out0[6 ] = in0[4 ];
              out0[5 ] = in0[3 ];
              out0[4 ] = in0[2 ];
              out0[3 ] = in0[1 ];
              out0[2 ] = in0[0 ];
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case  10: out0[15] = hc_2bytesalign_S (in0[12], in0[13], 2);
              out0[14] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[13] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[12] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[11] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[10] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[3 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[2 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case  12:  out0[15] = in0[12];
              out0[14] = in0[11];
              out0[13] = in0[10];
              out0[12] = in0[9 ];
              out0[11] = in0[8 ];
              out0[10] = in0[7 ];
              out0[9 ] = in0[6 ];
              out0[8 ] = in0[5 ];
              out0[7 ] = in0[4 ];
              out0[6 ] = in0[3 ];
              out0[5 ] = in0[2 ];
              out0[4 ] = in0[1 ];
              out0[3 ] = in0[0 ];
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case  14: out0[15] = hc_2bytesalign_S (in0[11], in0[12], 2);
              out0[14] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[13] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[12] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[11] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[10] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[4 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[3 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case  16: out0[15] = in0[11];
              out0[14] = in0[10];
              out0[13] = in0[9 ];
              out0[12] = in0[8 ];
              out0[11] = in0[7 ];
              out0[10] = in0[6 ];
              out0[9 ] = in0[5 ];
              out0[8 ] = in0[4 ];
              out0[7 ] = in0[3 ];
              out0[6 ] = in0[2 ];
              out0[5 ] = in0[1 ];
              out0[4 ] = in0[0 ];
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case  18: out0[15] = hc_2bytesalign_S (in0[10], in0[11], 2);
              out0[14] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[13] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[12] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[11] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[10] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[5 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[4 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 20:  out0[15] = in0[10];
              out0[14] = in0[9 ];
              out0[13] = in0[8 ];
              out0[12] = in0[7 ];
              out0[11] = in0[6 ];
              out0[10] = in0[5 ];
              out0[9 ] = in0[4 ];
              out0[8 ] = in0[3 ];
              out0[7 ] = in0[2 ];
              out0[6 ] = in0[1 ];
              out0[5 ] = in0[0 ];
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 22:  out0[15] = hc_2bytesalign_S (in0[9 ], in0[10], 2);
              out0[14] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[13] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[12] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[11] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[10] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[6 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[5 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 24:  out0[15] = in0[9 ];
              out0[14] = in0[8 ];
              out0[13] = in0[7 ];
              out0[12] = in0[6 ];
              out0[11] = in0[5 ];
              out0[10] = in0[4 ];
              out0[9 ] = in0[3 ];
              out0[8 ] = in0[2 ];
              out0[7 ] = in0[1 ];
              out0[6 ] = in0[0 ];
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 26:  out0[15] = hc_2bytesalign_S (in0[8 ], in0[9 ], 2);
              out0[14] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[13] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[12] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[11] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[10] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[7 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[6 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 28:  out0[15] = in0[8 ];
              out0[14] = in0[7 ];
              out0[13] = in0[6 ];
              out0[12] = in0[5 ];
              out0[11] = in0[4 ];
              out0[10] = in0[3 ];
              out0[9 ] = in0[2 ];
              out0[8 ] = in0[1 ];
              out0[7 ] = in0[0 ];
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 30:  out0[15] = hc_2bytesalign_S (in0[7 ], in0[8 ], 2);
              out0[14] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[13] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[12] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[11] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[10] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[8 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[7 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
    case 32:  out0[15] = in0[7 ];
              out0[14] = in0[6 ];
              out0[13] = in0[5 ];
              out0[12] = in0[4 ];
              out0[11] = in0[3 ];
              out0[10] = in0[2 ];
              out0[9 ] = in0[1 ];
              out0[8 ] = in0[0 ];
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 34:    out0[15] = hc_2bytesalign_S (in0[6 ], in0[7 ], 2);
              out0[14] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[13] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[12] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[11] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[10] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[9 ] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[8 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 36:    out0[15] = in0[6 ];
              out0[14] = in0[5 ];
              out0[13] = in0[4 ];
              out0[12] = in0[3 ];
              out0[11] = in0[2 ];
              out0[10] = in0[1 ];
              out0[9 ] = in0[0 ];
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 38:    out0[15] = hc_2bytesalign_S (in0[5 ], in0[6 ], 2);
              out0[14] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[13] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[12] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[11] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[10] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[9 ] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 40:    out0[15] = in0[5 ];
              out0[14] = in0[4 ];
              out0[13] = in0[3 ];
              out0[12] = in0[2 ];
              out0[11] = in0[1 ];
              out0[10] = in0[0 ];
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 42:    out0[15] = hc_2bytesalign_S (in0[4 ], in0[5 ], 2);
              out0[14] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[13] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[12] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[11] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[10] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 44:    out0[15] = in0[4 ];
              out0[14] = in0[3 ];
              out0[13] = in0[2 ];
              out0[12] = in0[1 ];
              out0[11] = in0[0 ];
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 46:    out0[15] = hc_2bytesalign_S (in0[3 ], in0[4 ], 2);
              out0[14] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[13] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[12] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[11] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 48:    out0[15] = in0[3 ];
              out0[14] = in0[2 ];
              out0[13] = in0[1 ];
              out0[12] = in0[0 ];
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
 case 50:     out0[15] = hc_2bytesalign_S (in0[2 ], in0[3 ], 2);
              out0[14] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[13] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[12] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 52:    out0[15] = in0[2 ];
              out0[14] = in0[1 ];
              out0[13] = in0[0 ];
              out0[12] = 0;
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 54:    out0[15] = hc_2bytesalign_S (in0[1 ], in0[2 ], 2);
              out0[14] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[13] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[12] = 0;
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 56:    out0[15] = in0[1 ];
              out0[14] = in0[0 ];
              out0[13] = 0;
              out0[12] = 0;
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
 case 58:     out0[15] = hc_2bytesalign_S (in0[0 ], in0[1 ], 2);
              out0[14] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[13] = 0;
              out0[12] = 0;
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 60:    out0[15] = in0[0 ];
              out0[14] = 0;
              out0[13] = 0;
              out0[12] = 0;
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  case 62:    out0[15] = hc_2bytesalign_S (     0, in0[0 ], 2);
              out0[14] = 0;
              out0[13] = 0;
              out0[12] = 0;
              out0[11] = 0;
              out0[10] = 0;
              out0[9 ] = 0;
              out0[8 ] = 0;
              out0[7 ] = 0;
              out0[6 ] = 0;
              out0[5 ] = 0;
              out0[4 ] = 0;
              out0[3 ] = 0;
              out0[2 ] = 0;
              out0[1 ] = 0;
              out0[0 ] = 0;
              break;
  }
}

DECLSPEC void append_block1_optimized_utf16le (const u32 offset, PRIVATE_AS u32 *buf0, const u32 src_r0)
{
  // this version works with 2 bytes append only
  const u32 value = src_r0 & 0xffff;

  const u32 tmp = value <<  0
                | value <<  16;

  u32 v[16];

  set_mark_1x16_S_16 (v, offset); 

  const u32 offset8 = offset / 16;
  append_helper_1x16_S (buf0, tmp, v);
}

DECLSPEC void append_block8_optimized_utf16le (const u32 offset, PRIVATE_AS u32 *buf0, PRIVATE_AS const u32 *src_l0, PRIVATE_AS const u32 *src_r0)  // TODO
{
  u32 s0 = 0;
  u32 s1 = 0;
  u32 s2 = 0;
  u32 s3 = 0;
  u32 s4 = 0;
  u32 s5 = 0;
  u32 s6 = 0;
  u32 s7 = 0;
  u32 s8 = 0;
  u32 s9 = 0;
  u32 s10 = 0;
  u32 s11 = 0;
  u32 s12 = 0;
  u32 s13 = 0;
  u32 s14 = 0;
  u32 s15 = 0;

  const int offset_switch = offset / 2;

  const u32 src_r00 = src_r0[0];
  const u32 src_r01 = src_r0[1];
  const u32 src_r02 = src_r0[2];
  const u32 src_r03 = src_r0[3];
  const u32 src_r10 = src_r1[0];
  const u32 src_r11 = src_r1[1];
  const u32 src_r12 = src_r1[2];
  const u32 src_r13 = src_r1[3];
  const u32 src_r20 = src_r2[0];
  const u32 src_r21 = src_r2[1];
  const u32 src_r22 = src_r2[2];
  const u32 src_r23 = src_r2[3];
  const u32 src_r30 = src_r3[0];
  const u32 src_r31 = src_r3[1];
  const u32 src_r32 = src_r3[2];
  const u32 src_r33 = src_r3[3];

  switch (offset_switch)
  {
    case 0:
      s15 = hc_2bytesalign_S (src_r32, src_r33, selector);
      s14 = hc_2bytesalign_S (src_r31, src_r32, selector);
      s13 = hc_2bytesalign_S (src_r30, src_r31, selector);
      s12 = hc_2bytesalign_S (src_r23, src_r30, selector);
      s11 = hc_2bytesalign_S (src_r22, src_r23, selector);
      s10 = hc_2bytesalign_S (src_r21, src_r22, selector);
      s9 =  hc_2bytesalign_S (src_r20, src_r21, selector);
      s8 =  hc_2bytesalign_S (src_r13, src_r20, selector);
      s7 =  hc_2bytesalign_S (src_r12, src_r13, selector);
      s6 =  hc_2bytesalign_S (src_r11, src_r12, selector);
      s5 =  hc_2bytesalign_S (src_r10, src_r11, selector);
      s4 =  hc_2bytesalign_S (src_r03, src_r10, selector);
      s3 =  hc_2bytesalign_S (src_r02, src_r03, selector);
      s2 =  hc_2bytesalign_S (src_r01, src_r02, selector);
      s1 =  hc_2bytesalign_S (src_r00, src_r01, selector);
      s0 =  hc_2bytesalign_S (      0, src_r00, selector);
      break;

    case 1:
      s15 = hc_2bytesalign_S (src_r31, src_r32, selector);
      s14 = hc_2bytesalign_S (src_r30, src_r31, selector);
      s13 = hc_2bytesalign_S (src_r23, src_r30, selector);
      s12 = hc_2bytesalign_S (src_r22, src_r23, selector);
      s11 = hc_2bytesalign_S (src_r21, src_r22, selector);
      s10 = hc_2bytesalign_S (src_r20, src_r21, selector);
      s9 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s8 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s7 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s6 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s5 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s4 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s3 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s2 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s1 = hc_2bytesalign_S (      0, src_r00, selector);
      s0 = 0;
      break;

    case 2:
      s15 = hc_2bytesalign_S (src_r30, src_r31, selector);
      s14 = hc_2bytesalign_S (src_r23, src_r30, selector);
      s13 = hc_2bytesalign_S (src_r22, src_r23, selector);
      s12 = hc_2bytesalign_S (src_r21, src_r22, selector);
      s11 = hc_2bytesalign_S (src_r20, src_r21, selector);
      s10 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s9 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s8 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s7 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s6 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s5 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s4 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s3 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s2 = hc_2bytesalign_S (      0, src_r00, selector);
      s1 = 0;
      s0 = 0;
      break;

    case 3:
      s15 = hc_2bytesalign_S (src_r23, src_r30, selector);
      s14 = hc_2bytesalign_S (src_r22, src_r23, selector);
      s13 = hc_2bytesalign_S (src_r21, src_r22, selector);
      s12 = hc_2bytesalign_S (src_r20, src_r21, selector);
      s11 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s10 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s9 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s8 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s7 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s6 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s5 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s4 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s3 = hc_2bytesalign_S (      0, src_r00, selector);
      s2 = 0;
      s1 = 0;
      s0 = 0;

      break;

    case 4:
      s15 = hc_2bytesalign_S (src_r22, src_r23, selector);
      s14 = hc_2bytesalign_S (src_r21, src_r22, selector);
      s13 = hc_2bytesalign_S (src_r20, src_r21, selector);
      s12 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s11 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s10 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s9 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s8 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s7 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s6 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s5 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s4 = hc_2bytesalign_S (      0, src_r00, selector);
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 5:
      s15 = hc_2bytesalign_S (src_r21, src_r22, selector);
      s14 = hc_2bytesalign_S (src_r20, src_r21, selector);
      s13 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s12 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s11 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s10 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s9 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s8 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s7 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s6 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s5 = hc_2bytesalign_S (      0, src_r00, selector);
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 6:
      s15 = hc_2bytesalign_S (src_r20, src_r21, selector);
      s14 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s13 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s12 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s11 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s10 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s9 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s8 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s7 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s6 = hc_2bytesalign_S (      0, src_r00, selector);
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 7:
      s15 = hc_2bytesalign_S (src_r13, src_r20, selector);
      s14 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s13 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s12 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s11 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s10 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s9 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s8 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s7 = hc_2bytesalign_S (      0, src_r00, selector);
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 8:
      s15 = hc_2bytesalign_S (src_r12, src_r13, selector);
      s14 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s13 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s12 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s11 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s10 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s9 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s8 = hc_2bytesalign_S (      0, src_r00, selector);
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 9:
      s15 = hc_2bytesalign_S (src_r11, src_r12, selector);
      s14 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s13 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s12 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s11 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s10 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s9 = hc_2bytesalign_S (      0, src_r00, selector);
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 10:
      s15 = hc_2bytesalign_S (src_r10, src_r11, selector);
      s14 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s13 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s12 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s11 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s10 = hc_2bytesalign_S (      0, src_r00, selector);
      s9 = 0;
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 11:
      s15 = hc_2bytesalign_S (src_r03, src_r10, selector);
      s14 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s13 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s12 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s11 = hc_2bytesalign_S (      0, src_r00, selector);
      s10 = 0;
      s9 = 0;
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 12:
      s15 = hc_2bytesalign_S (src_r02, src_r03, selector);
      s14 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s13 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s12 = hc_2bytesalign_S (      0, src_r00, selector);
      s11 = 0;
      s10 = 0;
      s9 = 0;
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 13:
      s15 = hc_2bytesalign_S (src_r01, src_r02, selector);
      s14 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s13 = hc_2bytesalign_S (      0, src_r00, selector);
      s12 = 0;
      s11 = 0;
      s10 = 0;
      s9 = 0;
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 14:
      s15 = hc_2bytesalign_S (src_r00, src_r01, selector);
      s14 = hc_2bytesalign_S (      0, src_r00, selector);
      s13 = 0;
      s12 = 0;
      s11 = 0;
      s10 = 0;
      s9 = 0;
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 15:
      s15 = hc_2bytesalign_S (      0, src_r00, selector);
      s14 = 0;
      s13 = 0;
      s12 = 0;
      s11 = 0;
      s10 = 0;
      s9 = 0;
      s8 = 0;
      s7 = 0;
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;
  }

  buf0[0 ] = src_l0[0 ] | s0;
  buf0[1 ] = src_l0[1 ] | s1;
  buf0[2 ] = src_l0[2 ] | s2;
  buf0[3 ] = src_l0[3 ] | s3;
  buf0[4 ] = src_l0[4 ] | s4;
  buf0[5 ] = src_l0[5 ] | s5;
  buf0[6 ] = src_l0[6 ] | s6;
  buf0[7 ] = src_l0[7 ] | s7;
  buf0[8 ] = src_l0[8 ] | s8;
  buf0[9 ] = src_l0[9 ] | s9;
  buf0[10] = src_l0[10] | s10;
  buf0[11] = src_l0[11] | s11;
  buf0[12] = src_l0[12] | s12;
  buf0[13] = src_l0[13] | s13;
  buf0[14] = src_l0[14] | s14;
  buf0[15] = src_l0[15] | s15;
}

DECLSPEC void reverse_block_optimized_utf16le (PRIVATE_AS u32 *in0, PRIVATE_AS u32 *out0, const u32 len)
{
  rshift_block_optimized_N_utf16le (in0, out0, 64 - len);

  u32 tib0[16];

  tib0[0 ] = out0[15];
  tib0[1 ] = out0[14];
  tib0[2 ] = out0[13];
  tib0[3 ] = out0[12];
  tib0[4 ] = out0[11];
  tib0[5 ] = out0[10];
  tib0[6 ] = out0[9 ];
  tib0[7 ] = out0[8 ];
  tib0[8 ] = out0[7 ];
  tib0[9 ] = out0[6 ];
  tib0[10] = out0[5 ];
  tib0[11] = out0[4 ];
  tib0[12] = out0[3 ];
  tib0[13] = out0[2 ];
  tib0[14] = out0[1 ];
  tib0[15] = out0[0 ];

  out0[0 ] = hc_2bytesalign_S (tib0[0 ],tib0[0 ],2);
  out0[1 ] = hc_2bytesalign_S (tib0[1 ],tib0[1 ],2);
  out0[2 ] = hc_2bytesalign_S (tib0[2 ],tib0[2 ],2);
  out0[3 ] = hc_2bytesalign_S (tib0[3 ],tib0[3 ],2);
  out0[4 ] = hc_2bytesalign_S (tib0[4 ],tib0[4 ],2);
  out0[5 ] = hc_2bytesalign_S (tib0[5 ],tib0[5 ],2);
  out0[6 ] = hc_2bytesalign_S (tib0[6 ],tib0[6 ],2);
  out0[7 ] = hc_2bytesalign_S (tib0[7 ],tib0[7 ],2);  
  out0[8 ] = hc_2bytesalign_S (tib0[8 ],tib0[8 ],2); 
  out0[9 ] = hc_2bytesalign_S (tib0[9 ],tib0[9 ],2);
  out0[10] = hc_2bytesalign_S (tib0[10],tib0[10],2);
  out0[11] = hc_2bytesalign_S (tib0[11],tib0[11],2);
  out0[12] = hc_2bytesalign_S (tib0[12],tib0[12],2);
  out0[13] = hc_2bytesalign_S (tib0[13],tib0[13],2);
  out0[14] = hc_2bytesalign_S (tib0[14],tib0[14],2);
  out0[15] = hc_2bytesalign_S (tib0[15],tib0[15],2);  

}

DECLSPEC void exchange_byte_optimized_utf16le (PRIVATE_AS u32 *buf, const int off_src, const int off_dst)
{
  PRIVATE_AS u16 *ptr = (PRIVATE_AS u16 *) buf; 

  const u16 tmp = ptr[off_src];

  ptr[off_src] = ptr[off_dst];
  ptr[off_dst] = tmp;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 mask[16] = { 0 };

  generate_acmask_optimized_utf16le(buf0,mask);

  buf0[0 ] |= mask[0 ];
  buf0[1 ] |= mask[1 ];
  buf0[2 ] |= mask[2 ];
  buf0[3 ] |= mask[3 ];
  buf0[4 ] |= mask[4 ];
  buf0[5 ] |= mask[5 ];
  buf0[6 ] |= mask[6 ];
  buf0[7 ] |= mask[7 ];
  buf0[8 ] |= mask[8 ];
  buf0[9 ] |= mask[9 ];
  buf0[10] |= mask[10];
  buf0[11] |= mask[11];
  buf0[12] |= mask[12];
  buf0[13] |= mask[13];
  buf0[14] |= mask[14];
  buf0[15] |= mask[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 mask[16] = { 0 };

  generate_acmask_optimized_utf16le(buf0,mask);

  buf0[0 ] &= ~mask[0 ];
  buf0[1 ] &= ~mask[1 ];
  buf0[2 ] &= ~mask[2 ];
  buf0[3 ] &= ~mask[3 ];
  buf0[4 ] &= ~mask[4 ];
  buf0[5 ] &= ~mask[5 ];
  buf0[6 ] &= ~mask[6 ];
  buf0[7 ] &= ~mask[7 ];
  buf0[8 ] &= ~mask[8 ];
  buf0[9 ] &= ~mask[9 ];
  buf0[10] &= ~mask[10];
  buf0[11] &= ~mask[11];
  buf0[12] &= ~mask[12];
  buf0[13] &= ~mask[13];
  buf0[14] &= ~mask[14];
  buf0[15] &= ~mask[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_ufirst_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 mask[16] = { 0 };

  generate_acmask_optimized_utf16le(buf0,mask);

  buf0[0 ] |= mask[0 ];
  buf0[1 ] |= mask[1 ];
  buf0[2 ] |= mask[2 ];
  buf0[3 ] |= mask[3 ];
  buf0[4 ] |= mask[4 ];
  buf0[5 ] |= mask[5 ];
  buf0[6 ] |= mask[6 ];
  buf0[7 ] |= mask[7 ];
  buf0[8 ] |= mask[8 ];
  buf0[9 ] |= mask[9 ];
  buf0[10] |= mask[10];
  buf0[11] |= mask[11];
  buf0[12] |= mask[12];
  buf0[13] |= mask[13];
  buf0[14] |= mask[14];
  buf0[15] |= mask[15];

  buf0[0 ] &= ~(0x00000020u & mask[0]);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_lfirst_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 mask[16] = { 0 };

  generate_acmask_optimized_utf16le(buf0,mask);

  buf0[0 ] &= ~mask[0 ];
  buf0[1 ] &= ~mask[1 ];
  buf0[2 ] &= ~mask[2 ];
  buf0[3 ] &= ~mask[3 ];
  buf0[4 ] &= ~mask[4 ];
  buf0[5 ] &= ~mask[5 ];
  buf0[6 ] &= ~mask[6 ];
  buf0[7 ] &= ~mask[7 ];
  buf0[8 ] &= ~mask[8 ];
  buf0[9 ] &= ~mask[9 ];
  buf0[10] &= ~mask[10];
  buf0[11] &= ~mask[11];
  buf0[12] &= ~mask[12];
  buf0[13] &= ~mask[13];
  buf0[14] &= ~mask[14];
  buf0[15] &= ~mask[15];

  buf0[0 ] |= (0x00000020u & mask[0]);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_trest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 mask[16] = { 0 };

  generate_acmask_optimized_utf16le(buf0,mask);

  buf0[0 ] ^= mask[0 ];
  buf0[1 ] ^= mask[1 ];
  buf0[2 ] ^= mask[2 ];
  buf0[3 ] ^= mask[3 ];
  buf0[4 ] ^= mask[4 ];
  buf0[5 ] ^= mask[5 ];
  buf0[6 ] ^= mask[6 ];
  buf0[7 ] ^= mask[7 ];
  buf0[8 ] ^= mask[8 ];
  buf0[9 ] ^= mask[9 ];
  buf0[10] ^= mask[10];
  buf0[11] ^= mask[11];
  buf0[12] ^= mask[12];
  buf0[13] ^= mask[13];
  buf0[14] ^= mask[14];
  buf0[15] ^= mask[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_shift_case_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO 
{
  u32 t;

  t = buf0[0]; buf0[0] = t ^ generate_cshift_mask (t);
  t = buf0[1]; buf0[1] = t ^ generate_cshift_mask (t);
  t = buf0[2]; buf0[2] = t ^ generate_cshift_mask (t);
  t = buf0[3]; buf0[3] = t ^ generate_cshift_mask (t);
  t = buf1[0]; buf1[0] = t ^ generate_cshift_mask (t);
  t = buf1[1]; buf1[1] = t ^ generate_cshift_mask (t);
  t = buf1[2]; buf1[2] = t ^ generate_cshift_mask (t);
  t = buf1[3]; buf1[3] = t ^ generate_cshift_mask (t);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  if (p0 >= in_len) return in_len;

  u32 t[16], mask[16] = { 0 };
  u32 pos = p0 / 4;

  const u32 m = 0x0020u << ((p0 & 3u) * 16u);

  generate_acmask_optimized_utf16le(buf0,mask);

  t[0 ] = (pos == 0 )? m : 0u;
  t[1 ] = (pos == 1 )? m : 0u;
  t[2 ] = (pos == 2 )? m : 0u;
  t[3 ] = (pos == 3 )? m : 0u;
  t[4 ] = (pos == 4 )? m : 0u;
  t[5 ] = (pos == 5 )? m : 0u;
  t[6 ] = (pos == 6 )? m : 0u;
  t[7 ] = (pos == 7 )? m : 0u;
  t[8 ] = (pos == 8 )? m : 0u;
  t[9 ] = (pos == 9 )? m : 0u;
  t[10] = (pos == 10)? m : 0u;
  t[11] = (pos == 11)? m : 0u;
  t[12] = (pos == 12)? m : 0u;
  t[13] = (pos == 13)? m : 0u;
  t[14] = (pos == 14)? m : 0u;
  t[15] = (pos == 15)? m : 0u;
  
  buf0[0 ] ^= t[0 ] &  mask[0 ];
  buf0[1 ] ^= t[1 ] &  mask[1 ];
  buf0[2 ] ^= t[2 ] &  mask[2 ];
  buf0[3 ] ^= t[3 ] &  mask[3 ];
  buf0[4 ] ^= t[4 ] &  mask[4 ];
  buf0[5 ] ^= t[5 ] &  mask[5 ];
  buf0[6 ] ^= t[6 ] &  mask[6 ];
  buf0[7 ] ^= t[7 ] &  mask[7 ];
  buf0[8 ] ^= t[8 ] &  mask[8 ];
  buf0[9 ] ^= t[9 ] &  mask[9 ];
  buf0[10] ^= t[10] &  mask[10];
  buf0[11] ^= t[11] &  mask[11];
  buf0[12] ^= t[12] &  mask[12];
  buf0[13] ^= t[13] &  mask[13];
  buf0[14] ^= t[14] &  mask[14];
  buf0[15] ^= t[15] &  mask[15];

  return (in_len);
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_sep_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  if (in_len == 0) return in_len;

  u32 r0  = search_on_register_utf16le (buf0[0 ], p1);
  u32 r1  = search_on_register_utf16le (buf0[1 ], p1);
  u32 r2  = search_on_register_utf16le (buf0[2 ], p1);
  u32 r3  = search_on_register_utf16le (buf0[3 ], p1);
  u32 r4  = search_on_register_utf16le (buf0[4 ], p1);
  u32 r5  = search_on_register_utf16le (buf0[5 ], p1);
  u32 r6  = search_on_register_utf16le (buf0[6 ], p1);
  u32 r7  = search_on_register_utf16le (buf0[7 ], p1);
  u32 r8  = search_on_register_utf16le (buf0[8 ], p1);
  u32 r9  = search_on_register_utf16le (buf0[9 ], p1);
  u32 r10 = search_on_register_utf16le (buf0[10], p1);
  u32 r11 = search_on_register_utf16le (buf0[11], p1);
  u32 r12 = search_on_register_utf16le (buf0[12], p1);
  u32 r13 = search_on_register_utf16le (buf0[13], p1);
  u32 r14 = search_on_register_utf16le (buf0[14], p1);
  u32 r15 = search_on_register_utf16le (buf0[15], p1);

  const u32 rn = (r0 <<  0 )
               | (r1 <<  2 )
               | (r2 <<  4 )
               | (r3 <<  6 )
               | (r4 <<  8 )
               | (r5 <<  10)
               | (r6 <<  12)
               | (r7 <<  14)
               | (r8 <<  16)
               | (r9 <<  18)
               | (r10 << 20)    
               | (r11 << 22)
               | (r12 << 24)
               | (r13 << 26)
               | (r14 << 28)
               | (r15 << 30);

  if (rn == 0) return in_len;
  u32 occurence = 0;

  u32 ro = 0;

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 32; i++)
  {
    if ((rn >> i) & 1)
    {
      if (occurence == (p0/2))
      {
        ro = 1 << i;

        #ifdef IS_METAL

        i = 32;

        continue;

        #else

        break; // bug on Apple Intel/Silicon with Metal

        #endif
      }
      occurence++;
    }
  }

  r0 = (ro >>  0) & 0x0F;
  r1 = (ro >>  2) & 0x0F;
  r2 = (ro >>  4) & 0x0F;
  r3 = (ro >>  6) & 0x0F;
  r4 = (ro >>  8) & 0x0F;
  r5 = (ro >>  10) & 0x0F;
  r6 = (ro >>  12) & 0x0F;
  r7 = (ro >>  14) & 0x0F;
  r8 = (ro >>  16) & 0x0F;
  r9 = (ro >>  18) & 0x0F;
  r10 = (ro >> 20) & 0x0F;
  r11 = (ro >> 22) & 0x0F;
  r12 = (ro >> 24) & 0x0F;
  r13 = (ro >> 26) & 0x0F;
  r14 = (ro >> 28) & 0x0F;
  r15 = (ro >> 30) & 0x0F;

  r0 <<= 1;
  r1 <<= 1; r1 |= r0 >> 2;
  r2 <<= 1; r2 |= r1 >> 2;
  r3 <<= 1; r3 |= r2 >> 2;
  r4 <<= 1; r4 |= r3 >> 2;
  r5 <<= 1; r5 |= r4 >> 2;
  r6 <<= 1; r6 |= r5 >> 2;
  r7 <<= 1; r7 |= r6 >> 2;
  r8 <<= 1; r8 |= r7 >> 2;
  r9 <<= 1; r9 |= r8 >> 2;
  r10 <<= 1; r10 |= r9 >> 2;
  r11 <<= 1; r11 |= r10 >> 2;
  r12 <<= 1; r12 |= r11 >> 2;
  r13 <<= 1; r13 |= r12 >> 2;
  r14 <<= 1; r14 |= r13 >> 2;
  r15 <<= 1; r15 |= r14 >> 2;

  buf0[0 ] = toggle_on_register_utf16le (buf0[0 ], r0);
  buf0[1 ] = toggle_on_register_utf16le (buf0[1 ], r1);
  buf0[2 ] = toggle_on_register_utf16le (buf0[2 ], r2);
  buf0[3 ] = toggle_on_register_utf16le (buf0[3 ], r3);
  buf0[4 ] = toggle_on_register_utf16le (buf0[4 ], r4);
  buf0[5 ] = toggle_on_register_utf16le (buf0[5 ], r5);
  buf0[6 ] = toggle_on_register_utf16le (buf0[6 ], r6);
  buf0[7 ] = toggle_on_register_utf16le (buf0[7 ], r7);
  buf0[8 ] = toggle_on_register_utf16le (buf0[8 ], r8);
  buf0[9 ] = toggle_on_register_utf16le (buf0[9 ], r9);
  buf0[10] = toggle_on_register_utf16le (buf0[10], r10);
  buf0[11] = toggle_on_register_utf16le (buf0[11], r11);
  buf0[12] = toggle_on_register_utf16le (buf0[12], r12);
  buf0[13] = toggle_on_register_utf16le (buf0[13], r13);
  buf0[14] = toggle_on_register_utf16le (buf0[14], r14);
  buf0[15] = toggle_on_register_utf16le (buf0[15], r15);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reverse_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  reverse_block_optimized_utf16le (buf0, buf0, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;
  append_block8_optimized_utf16le (out_len, buf0, buf0, buf0);

  out_len += in_len;
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_times_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 p0_2 = p0/2u;

  if (((in_len * p0_2) + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib0[16];

  tib0[0 ] = buf0[0 ];
  tib0[1 ] = buf0[1 ];
  tib0[2 ] = buf0[2 ];
  tib0[3 ] = buf0[3 ];
  tib0[4 ] = buf0[4 ];
  tib0[5 ] = buf0[5 ];
  tib0[6 ] = buf0[6 ];
  tib0[7 ] = buf0[7 ];
  tib0[8 ] = buf0[8 ];
  tib0[9 ] = buf0[9 ];
  tib0[10] = buf0[10];
  tib0[11] = buf0[11];
  tib0[12] = buf0[12];
  tib0[13] = buf0[13];
  tib0[14] = buf0[14];
  tib0[15] = buf0[15];

  for (u32 i = 0; i < p0_2; i++)
  {
    append_block8_optimized_utf16le (out_len, buf0,buf0, tib0);

    out_len += in_len;
  }

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reflect_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len)
{
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib0[16] = { 0 };

  reverse_block_optimized_utf16le (buf0, tib0, out_len);

  append_block8_optimized_utf16le (out_len, buf0, buf0, tib0);

  out_len += in_len;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_to_hex_lower_utf16le  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 out_len = in_len * 2;

  if (out_len >= 32) return in_len;

  for (int pos = in_len - 1; pos >= 0; pos--)
  {
    const u8 c = in[pos];

    const u8 tbl[0x10] =
    {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      'a', 'b', 'c', 'd', 'e', 'f',
    };

    in[pos * 2 + 1] = tbl[c >>  0 & 15];
    in[pos * 2] = tbl[c >>  4 & 15];
  }

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_to_hex_upper_utf16le  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  //TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  const int out_len = in_len * 2;

  if (out_len >= 32) return in_len;

  for (int pos = in_len - 1; pos >= 0; pos--)
  {
    const u8 c = in[pos];

    const u8 tbl[0x10] =
    {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      'A', 'B', 'C', 'D', 'E', 'F',
    };

    in[pos * 2 + 1] = tbl[c >>  0 & 15];
    in[pos * 2] = tbl[c >>  4 & 15];
  }

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_append_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len) 
{
  if ((in_len + 2) >= 64) return in_len;

  u32 out_len = in_len;

  append_block1_optimized_utf16le (out_len, buf0, p0);

  out_len += 2;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_prepend_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if ((in_len + 2) >= 32) return in_len;

  u32 out_len = in_len;

  rshift_block_optimized_utf16le (buf0, buf0);

  buf0[0 ] = buf0[0 ] | p0;

  out_len += 2;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_left_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 tmp = buf0[0 ];

  lshift_block_optimized_utf16le (buf0, buf0);

  append_block1_optimized_utf16le (in_len1, buf0, tmp);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_right_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 sh = (in_len1 & 2) * 8;

  u32 tmp = 0;

  u32 v[16];

  set_mark_1x16_S_16 (v, in_len1);


  tmp |= buf0[0 ] & v[0 ];
  tmp |= buf0[1 ] & v[1 ];
  tmp |= buf0[2 ] & v[2 ];
  tmp |= buf0[3 ] & v[3 ];
  tmp |= buf0[4 ] & v[4 ];
  tmp |= buf0[5 ] & v[5 ];
  tmp |= buf0[6 ] & v[6 ];
  tmp |= buf0[7 ] & v[7 ];
  tmp |= buf0[8 ] & v[8 ];
  tmp |= buf0[9 ] & v[9 ];
  tmp |= buf0[10] & v[10];
  tmp |= buf0[11] & v[11];
  tmp |= buf0[12] & v[12];
  tmp |= buf0[13] & v[13];
  tmp |= buf0[14] & v[14];
  tmp |= buf0[15] & v[15];

  tmp = (tmp >> sh) & 0xffff;

  rshift_block_optimized_utf16le (buf0, buf0);

  buf0[0 ] |= tmp;

  truncate_right_optimized_utf16le (buf0,in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  lshift_block_optimized_utf16le (buf0, buf0);

  return in_len1;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 mask = (1 << ((in_len1 & 2) * 8)) - 1;
  buf0[0 ] &=                      (in_len1 <  4)  ? mask : 0xffffffff;
  buf0[1 ] &= ((in_len1 >=  4 ) && (in_len1 <  8)) ? mask : 0xffffffff;
  buf0[2 ] &= ((in_len1 >=  8 ) && (in_len1 < 12)) ? mask : 0xffffffff;
  buf0[3 ] &= ((in_len1 >=  12) && (in_len1 < 16)) ? mask : 0xffffffff;
  buf0[4 ] &= ((in_len1 >=  16) && (in_len1 < 20)) ? mask : 0xffffffff;
  buf0[5 ] &= ((in_len1 >=  20) && (in_len1 < 24)) ? mask : 0xffffffff;
  buf0[6 ] &= ((in_len1 >=  24) && (in_len1 < 28)) ? mask : 0xffffffff;
  buf0[7 ] &= ((in_len1 >=  28) && (in_len1 < 32)) ? mask : 0xffffffff;
  buf0[8 ] &= ((in_len1 >=  32) && (in_len1 < 36)) ? mask : 0xffffffff;
  buf0[9 ] &= ((in_len1 >=  36) && (in_len1 < 40)) ? mask : 0xffffffff;
  buf0[10] &= ((in_len1 >=  40) && (in_len1 < 44)) ? mask : 0xffffffff;
  buf0[11] &= ((in_len1 >=  44) && (in_len1 < 48)) ? mask : 0xffffffff;
  buf0[12] &= ((in_len1 >=  48) && (in_len1 < 52)) ? mask : 0xffffffff;
  buf0[13] &= ((in_len1 >=  52) && (in_len1 < 56)) ? mask : 0xffffffff;
  buf0[14] &= ((in_len1 >=  56) && (in_len1 < 60)) ? mask : 0xffffffff;
  buf0[15] &=  (in_len1 >=  60)                    ? mask : 0xffffffff;

  return in_len1;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;
  u32 out_len = in_len;

  u32 tib0[16];

  lshift_block_optimized_utf16le (buf0, tib0);

  const u32 m =(1u << ((p0 & 2u) * 8u)) - 1u;
  const int pos = p0 / 4;

  u64 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] = (t[0 ] & buf0[0 ]) | (~t[0 ] & tib0[0 ]) ;
  buf0[1 ] = (t[1 ] & buf0[1 ]) | (~t[1 ] & tib0[1 ]) ;
  buf0[2 ] = (t[2 ] & buf0[2 ]) | (~t[2 ] & tib0[2 ]) ;
  buf0[3 ] = (t[3 ] & buf0[3 ]) | (~t[3 ] & tib0[3 ]) ;
  buf0[4 ] = (t[4 ] & buf0[4 ]) | (~t[4 ] & tib0[4 ]) ;
  buf0[5 ] = (t[5 ] & buf0[5 ]) | (~t[5 ] & tib0[5 ]) ;
  buf0[6 ] = (t[6 ] & buf0[6 ]) | (~t[6 ] & tib0[6 ]) ;
  buf0[7 ] = (t[7 ] & buf0[7 ]) | (~t[7 ] & tib0[7 ]) ;
  buf0[8 ] = (t[8 ] & buf0[8 ]) | (~t[8 ] & tib0[8 ]) ;
  buf0[9 ] = (t[9 ] & buf0[9 ]) | (~t[9 ] & tib0[9 ]) ;
  buf0[10] = (t[10] & buf0[10]) | (~t[10] & tib0[10]) ;
  buf0[11] = (t[11] & buf0[11]) | (~t[11] & tib0[11]) ;
  buf0[12] = (t[12] & buf0[12]) | (~t[12] & tib0[12]) ;
  buf0[13] = (t[13] & buf0[13]) | (~t[13] & tib0[13]) ;
  buf0[14] = (t[14] & buf0[14]) | (~t[14] & tib0[14]) ;
  buf0[15] = (t[15] & buf0[15]) | (~t[15] & tib0[15]) ;

  out_len -= 2;
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_extract_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  if ((p0 + p1) > in_len) return in_len;

  u32 out_len = p1;
  lshift_block_optimized_N_utf16le (buf0, buf0, p0);  
  truncate_right_optimized_utf16le (buf0, out_len);
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_omit_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  if ((p0 + p1) > in_len) return in_len;

  u32 out_len = in_len;

  u32 tib0[16] = { 0 };

  lshift_block_optimized_N_utf16le (buf0, tib0, p1);

  const u32 ml = (1 << ((p0 & 2u) * 8u)) - 1;
  const u32 mr = ~ml;
 const int pos = p0 / 4;

  u64 t[16];

  t[0 ] = (pos == 0 )? ml : (pos < 0 )? 0xffffffffffffffffu : 0u;
  t[1 ] = (pos == 1 )? ml : (pos < 1 )? 0xffffffffffffffffu : 0u;
  t[2 ] = (pos == 2 )? ml : (pos < 2 )? 0xffffffffffffffffu : 0u;
  t[3 ] = (pos == 3 )? ml : (pos < 3 )? 0xffffffffffffffffu : 0u;
  t[4 ] = (pos == 4 )? ml : (pos < 4 )? 0xffffffffffffffffu : 0u;
  t[5 ] = (pos == 5 )? ml : (pos < 5 )? 0xffffffffffffffffu : 0u;
  t[6 ] = (pos == 6 )? ml : (pos < 6 )? 0xffffffffffffffffu : 0u;
  t[7 ] = (pos == 7 )? ml : (pos < 7 )? 0xffffffffffffffffu : 0u;
  t[8 ] = (pos == 8 )? ml : (pos < 8 )? 0xffffffffffffffffu : 0u;
  t[9 ] = (pos == 9 )? ml : (pos < 9 )? 0xffffffffffffffffu : 0u;
  t[10] = (pos == 10)? ml : (pos < 10)? 0xffffffffffffffffu : 0u;
  t[11] = (pos == 11)? ml : (pos < 11)? 0xffffffffffffffffu : 0u;
  t[12] = (pos == 12)? ml : (pos < 12)? 0xffffffffffffffffu : 0u;
  t[13] = (pos == 13)? ml : (pos < 13)? 0xffffffffffffffffu : 0u;
  t[14] = (pos == 14)? ml : (pos < 14)? 0xffffffffffffffffu : 0u;
  t[15] = (pos == 15)? ml : (pos < 15)? 0xffffffffffffffffu : 0u;

  buf0[0 ] =  ( buf0[0 ] & t[0 ] ) | ( tib0[0 ] & ~t[0 ] );
  buf0[1 ] =  ( buf0[1 ] & t[1 ] ) | ( tib0[1 ] & ~t[1 ] );
  buf0[2 ] =  ( buf0[2 ] & t[2 ] ) | ( tib0[2 ] & ~t[2 ] );
  buf0[3 ] =  ( buf0[3 ] & t[3 ] ) | ( tib0[3 ] & ~t[3 ] );
  buf0[4 ] =  ( buf0[4 ] & t[4 ] ) | ( tib0[4 ] & ~t[4 ] );
  buf0[5 ] =  ( buf0[5 ] & t[5 ] ) | ( tib0[5 ] & ~t[5 ] );
  buf0[6 ] =  ( buf0[6 ] & t[6 ] ) | ( tib0[6 ] & ~t[6 ] );
  buf0[7 ] =  ( buf0[7 ] & t[7 ] ) | ( tib0[7 ] & ~t[7 ] );
  buf0[8 ] =  ( buf0[8 ] & t[8 ] ) | ( tib0[8 ] & ~t[8 ] );
  buf0[9 ] =  ( buf0[9 ] & t[9 ] ) | ( tib0[9 ] & ~t[9 ] );
  buf0[10] =  ( buf0[10] & t[10] ) | ( tib0[10] & ~t[10] );
  buf0[11] =  ( buf0[11] & t[11] ) | ( tib0[11] & ~t[11] );
  buf0[12] =  ( buf0[12] & t[12] ) | ( tib0[12] & ~t[12] );
  buf0[13] =  ( buf0[13] & t[13] ) | ( tib0[13] & ~t[13] );
  buf0[14] =  ( buf0[14] & t[14] ) | ( tib0[14] & ~t[14] );
  buf0[15] =  ( buf0[15] & t[15] ) | ( tib0[15] & ~t[15] );

  out_len -= p1;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_every_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  //TODO
{
  if (p0 > in_len) return in_len;

  if (p0 == 0) return in_len;

  const u32 out_len = in_len + (in_len / p0);

  if (out_len >= 32) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  for (u32 src = in_len, dest = out_len; src > 0; src--, dest--) {
    if ((src % p0) == 0) { in[dest-1] = p1; dest--; }
    in[dest-1] = in[src-1];
  }

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 > in_len) return in_len;

  if ((in_len + 2) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib0[16];

  rshift_block_optimized_utf16le (buf0, tib0);

  const u32 p1n = p1 << ((p0 & 2) * 8);

  const u32 ml = (1 << ((p0 & 2) * 8)) - 1;

  const u32 mr = 0xffff0000 << ((p0 & 2) * 8);

  const int pos = p0 / 4;

  u64 tl[16],tr[16];

  tl[0 ] = (pos == 0 )? ml : 0xffffffffffffffffu;
  tl[1 ] = (pos == 1 )? ml : 0xffffffffffffffffu;
  tl[2 ] = (pos == 2 )? ml : 0xffffffffffffffffu;
  tl[3 ] = (pos == 3 )? ml : 0xffffffffffffffffu;
  tl[4 ] = (pos == 4 )? ml : 0xffffffffffffffffu;
  tl[5 ] = (pos == 5 )? ml : 0xffffffffffffffffu;
  tl[6 ] = (pos == 6 )? ml : 0xffffffffffffffffu;
  tl[7 ] = (pos == 7 )? ml : 0xffffffffffffffffu;
  tl[8 ] = (pos == 8 )? ml : 0xffffffffffffffffu;
  tl[9 ] = (pos == 9 )? ml : 0xffffffffffffffffu;
  tl[10] = (pos == 10)? ml : 0xffffffffffffffffu;
  tl[11] = (pos == 11)? ml : 0xffffffffffffffffu;
  tl[12] = (pos == 12)? ml : 0xffffffffffffffffu;
  tl[13] = (pos == 13)? ml : 0xffffffffffffffffu;
  tl[14] = (pos == 14)? ml : 0xffffffffffffffffu;
  tl[15] = (pos == 15)? ml : 0xffffffffffffffffu;

  tr[0 ] = (pos == 0 )? mr : 0u;
  tr[1 ] = (pos == 1 )? mr : 0u;
  tr[2 ] = (pos == 2 )? mr : 0u;
  tr[3 ] = (pos == 3 )? mr : 0u;
  tr[4 ] = (pos == 4 )? mr : 0u;
  tr[5 ] = (pos == 5 )? mr : 0u;
  tr[6 ] = (pos == 6 )? mr : 0u;
  tr[7 ] = (pos == 7 )? mr : 0u;
  tr[8 ] = (pos == 8 )? mr : 0u;
  tr[9 ] = (pos == 9 )? mr : 0u;
  tr[10] = (pos == 10)? mr : 0u;
  tr[11] = (pos == 11)? mr : 0u;
  tr[12] = (pos == 12)? mr : 0u;
  tr[13] = (pos == 13)? mr : 0u;
  tr[14] = (pos == 14)? mr : 0u;
  tr[15] = (pos == 15)? mr : 0u;

  buf0[0 ] =  (buf0[0 ] & tl[0 ] ) | p1n | ( tib0[0 ] & tr[0 ] );
  buf0[1 ] =  (buf0[1 ] & tl[1 ] ) | p1n | ( tib0[1 ] & tr[1 ] );
  buf0[2 ] =  (buf0[2 ] & tl[2 ] ) | p1n | ( tib0[2 ] & tr[2 ] );
  buf0[3 ] =  (buf0[3 ] & tl[3 ] ) | p1n | ( tib0[3 ] & tr[3 ] );
  buf0[4 ] =  (buf0[4 ] & tl[4 ] ) | p1n | ( tib0[4 ] & tr[4 ] );
  buf0[5 ] =  (buf0[5 ] & tl[5 ] ) | p1n | ( tib0[5 ] & tr[5 ] );
  buf0[6 ] =  (buf0[6 ] & tl[6 ] ) | p1n | ( tib0[6 ] & tr[6 ] );
  buf0[7 ] =  (buf0[7 ] & tl[7 ] ) | p1n | ( tib0[7 ] & tr[7 ] );
  buf0[8 ] =  (buf0[8 ] & tl[8 ] ) | p1n | ( tib0[8 ] & tr[8 ] );
  buf0[9 ] =  (buf0[9 ] & tl[9 ] ) | p1n | ( tib0[9 ] & tr[9 ] );
  buf0[10] =  (buf0[10] & tl[10] ) | p1n | ( tib0[10] & tr[10] );
  buf0[11] =  (buf0[11] & tl[11] ) | p1n | ( tib0[11] & tr[11] );
  buf0[12] =  (buf0[12] & tl[12] ) | p1n | ( tib0[12] & tr[12] );
  buf0[13] =  (buf0[13] & tl[13] ) | p1n | ( tib0[13] & tr[13] );
  buf0[14] =  (buf0[14] & tl[14] ) | p1n | ( tib0[14] & tr[14] );
  buf0[15] =  (buf0[15] & tl[15] ) | p1n | ( tib0[15] & tr[15] );

  out_len += 2;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_overstrike_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 p1n = p1 << ((p0 & 2) * 8);

  const u32 m = ~(0xffffu << ((p0 & 2) * 8));

  const u32 pos = p0/4u;

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] = (t[0 ] & buf0[0 ]) | (~t[0 ] & p1n) ;
  buf0[1 ] = (t[1 ] & buf0[1 ]) | (~t[1 ] & p1n) ;
  buf0[2 ] = (t[2 ] & buf0[2 ]) | (~t[2 ] & p1n) ;
  buf0[3 ] = (t[3 ] & buf0[3 ]) | (~t[3 ] & p1n) ;
  buf0[4 ] = (t[4 ] & buf0[4 ]) | (~t[4 ] & p1n) ;
  buf0[5 ] = (t[5 ] & buf0[5 ]) | (~t[5 ] & p1n) ;
  buf0[6 ] = (t[6 ] & buf0[6 ]) | (~t[6 ] & p1n) ;
  buf0[7 ] = (t[7 ] & buf0[7 ]) | (~t[7 ] & p1n) ;
  buf0[8 ] = (t[8 ] & buf0[8 ]) | (~t[8 ] & p1n) ;
  buf0[9 ] = (t[9 ] & buf0[9 ]) | (~t[9 ] & p1n) ;
  buf0[10] = (t[10] & buf0[10]) | (~t[10] & p1n) ;
  buf0[11] = (t[11] & buf0[11]) | (~t[11] & p1n) ;
  buf0[12] = (t[12] & buf0[12]) | (~t[12] & p1n) ;
  buf0[13] = (t[13] & buf0[13]) | (~t[13] & p1n) ;
  buf0[14] = (t[14] & buf0[14]) | (~t[14] & p1n) ;
  buf0[15] = (t[15] & buf0[15]) | (~t[15] & p1n) ;

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_truncate_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  truncate_right_optimized_utf16le (buf0, p0);

  return p0;
}

DECLSPEC u32 search_on_register_utf16le (const u32 in, const u32 p0) 
{
  u32 r = 0;

  r |= (hc_bfe_S (in,    0, 16) == p0)? 1:0;
  r |= (hc_bfe_S (in,   16, 16) == p0)? 2:0;

  return r;
}

DECLSPEC u32 replace_on_register_utf16le (const u32 in, const u32 r, const u32 p1) 
{
  u32 out = in;

  if (r & 1) out = (out & 0xffff0000) | (p1 <<  0);
  if (r & 2) out = (out & 0x0000ffff) | (p1 <<  16);

  return out;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  const u32 r0  = search_on_register_utf16le (buf0[0 ], p0);
  const u32 r1  = search_on_register_utf16le (buf0[1 ], p0);
  const u32 r2  = search_on_register_utf16le (buf0[2 ], p0);
  const u32 r3  = search_on_register_utf16le (buf0[3 ], p0);
  const u32 r4  = search_on_register_utf16le (buf0[4 ], p0);
  const u32 r5  = search_on_register_utf16le (buf0[5 ], p0);
  const u32 r6  = search_on_register_utf16le (buf0[6 ], p0);
  const u32 r7  = search_on_register_utf16le (buf0[7 ], p0);
  const u32 r8  = search_on_register_utf16le (buf0[8 ], p0);
  const u32 r9  = search_on_register_utf16le (buf0[9 ], p0);
  const u32 r10 = search_on_register_utf16le (buf0[10], p0);
  const u32 r11 = search_on_register_utf16le (buf0[11], p0);
  const u32 r12 = search_on_register_utf16le (buf0[12], p0);
  const u32 r13 = search_on_register_utf16le (buf0[13], p0);
  const u32 r14 = search_on_register_utf16le (buf0[14], p0);
  const u32 r15 = search_on_register_utf16le (buf0[15], p0);

  const u32 rn = r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 ;

  if (rn == 0) return in_len;

  buf0[0 ] = replace_on_register_utf16le (buf0[0 ], r0, p1);
  buf0[1 ] = replace_on_register_utf16le (buf0[1 ], r1, p1);
  buf0[2 ] = replace_on_register_utf16le (buf0[2 ], r2, p1);
  buf0[3 ] = replace_on_register_utf16le (buf0[3 ], r3, p1);
  buf0[4 ] = replace_on_register_utf16le (buf0[4 ], r4, p1);
  buf0[5 ] = replace_on_register_utf16le (buf0[5 ], r5, p1);
  buf0[6 ] = replace_on_register_utf16le (buf0[6 ], r6, p1);
  buf0[7 ] = replace_on_register_utf16le (buf0[7 ], r7, p1);
  buf0[8 ] = replace_on_register_utf16le (buf0[8 ], r8, p1);
  buf0[9 ] = replace_on_register_utf16le (buf0[9 ], r9, p1);
  buf0[10] = replace_on_register_utf16le (buf0[10], r10, p1);
  buf0[11] = replace_on_register_utf16le (buf0[11], r11, p1);
  buf0[12] = replace_on_register_utf16le (buf0[12], r12, p1);
  buf0[13] = replace_on_register_utf16le (buf0[13], r13, p1);
  buf0[14] = replace_on_register_utf16le (buf0[14], r14, p1);
  buf0[15] = replace_on_register_utf16le (buf0[15], r15, p1);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_l_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 rn = 0;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (!is_l (in[pos])) continue;

    in[pos] = (u8)p1;

    rn++;
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_u_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  // TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 rn = 0;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (!is_u (in[pos])) continue;

    in[pos] = (u8)p1;

    rn++;
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_d_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  //TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 rn = 0;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (!is_d (in[pos])) continue;

    in[pos] = (u8)p1;

    rn++;
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_lh_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  //TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 rn = 0;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (!is_lh (in[pos])) continue;

    in[pos] = (u8)p1;

    rn++;
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_uh_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  // TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 rn = 0;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (!is_uh (in[pos])) continue;

    in[pos] = (u8)p1;

    rn++;
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_s_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  // TODO
{
  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  PRIVATE_AS u8 *in = (PRIVATE_AS u8 *) buf_in;

  u32 rn = 0;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (!is_s (in[pos])) continue;

    in[pos] = (u8)p1;

    rn++;
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
       if ((u8)p0 == 'l') return rule_op_mangle_replace_class_l_utf16le  (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_replace_class_u_utf16le  (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_replace_class_d_utf16le  (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_replace_class_lh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_replace_class_uh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_replace_class_s_utf16le  (p0, p1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  const u32 r0  = search_on_register_utf16le (buf0[0 ], p0);
  const u32 r1  = search_on_register_utf16le (buf0[1 ], p0);
  const u32 r2  = search_on_register_utf16le (buf0[2 ], p0);
  const u32 r3  = search_on_register_utf16le (buf0[3 ], p0);
  const u32 r4  = search_on_register_utf16le (buf0[4 ], p0);
  const u32 r5  = search_on_register_utf16le (buf0[5 ], p0);
  const u32 r6  = search_on_register_utf16le (buf0[6 ], p0);
  const u32 r7  = search_on_register_utf16le (buf0[7 ], p0);
  const u32 r8  = search_on_register_utf16le (buf0[8 ], p0);
  const u32 r9  = search_on_register_utf16le (buf0[9 ], p0);
  const u32 r10 = search_on_register_utf16le (buf0[10], p0);
  const u32 r11 = search_on_register_utf16le (buf0[11], p0);
  const u32 r12 = search_on_register_utf16le (buf0[12], p0);
  const u32 r13 = search_on_register_utf16le (buf0[13], p0);
  const u32 r14 = search_on_register_utf16le (buf0[14], p0);
  const u32 r15 = search_on_register_utf16le (buf0[15], p0);

  const u32 rn = r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 ;

  if (rn == 0) return in_len;

  u32 out_len = 0;

  u32 buf_out[16] = { 0 };

  PRIVATE_AS u16 *in  = (PRIVATE_AS u16 *) buf0;
  PRIVATE_AS u16 *out = (PRIVATE_AS u16 *) buf_out;

  for (u32 pos = 0; pos < in_len/2; pos++)
  {
    if (in[pos] == (u16) p0) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  out_len*=2;
  
  buf0[0 ] = buf_out[0 ];
  buf0[1 ] = buf_out[1 ];
  buf0[2 ] = buf_out[2 ];
  buf0[3 ] = buf_out[3 ];
  buf0[4 ] = buf_out[4 ];
  buf0[5 ] = buf_out[5 ];
  buf0[6 ] = buf_out[6 ];
  buf0[7 ] = buf_out[7 ];
  buf0[8 ] = buf_out[8 ];
  buf0[9 ] = buf_out[9 ];
  buf0[10] = buf_out[10];
  buf0[11] = buf_out[11];
  buf0[12] = buf_out[12];
  buf0[13] = buf_out[13];
  buf0[14] = buf_out[14];
  buf0[15] = buf_out[15];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_l_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  u32 out_len = 0;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 buf_out[8] = { 0 };

  PRIVATE_AS u8 *in  = (PRIVATE_AS u8 *) buf_in;
  PRIVATE_AS u8 *out = (PRIVATE_AS u8 *) buf_out;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (is_l (in[pos])) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  buf0[0] = buf_out[0];
  buf0[1] = buf_out[1];
  buf0[2] = buf_out[2];
  buf0[3] = buf_out[3];
  buf1[0] = buf_out[4];
  buf1[1] = buf_out[5];
  buf1[2] = buf_out[6];
  buf1[3] = buf_out[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_u_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  u32 out_len = 0;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 buf_out[8] = { 0 };

  PRIVATE_AS u8 *in  = (PRIVATE_AS u8 *) buf_in;
  PRIVATE_AS u8 *out = (PRIVATE_AS u8 *) buf_out;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (is_u (in[pos])) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  buf0[0] = buf_out[0];
  buf0[1] = buf_out[1];
  buf0[2] = buf_out[2];
  buf0[3] = buf_out[3];
  buf1[0] = buf_out[4];
  buf1[1] = buf_out[5];
  buf1[2] = buf_out[6];
  buf1[3] = buf_out[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_d_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  u32 out_len = 0;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 buf_out[8] = { 0 };

  PRIVATE_AS u8 *in  = (PRIVATE_AS u8 *) buf_in;
  PRIVATE_AS u8 *out = (PRIVATE_AS u8 *) buf_out;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (is_d (in[pos])) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  buf0[0] = buf_out[0];
  buf0[1] = buf_out[1];
  buf0[2] = buf_out[2];
  buf0[3] = buf_out[3];
  buf1[0] = buf_out[4];
  buf1[1] = buf_out[5];
  buf1[2] = buf_out[6];
  buf1[3] = buf_out[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_lh_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  u32 out_len = 0;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 buf_out[8] = { 0 };

  PRIVATE_AS u8 *in  = (PRIVATE_AS u8 *) buf_in;
  PRIVATE_AS u8 *out = (PRIVATE_AS u8 *) buf_out;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (is_lh (in[pos])) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  buf0[0] = buf_out[0];
  buf0[1] = buf_out[1];
  buf0[2] = buf_out[2];
  buf0[3] = buf_out[3];
  buf1[0] = buf_out[4];
  buf1[1] = buf_out[5];
  buf1[2] = buf_out[6];
  buf1[3] = buf_out[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_uh_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  u32 out_len = 0;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 buf_out[8] = { 0 };

  PRIVATE_AS u8 *in  = (PRIVATE_AS u8 *) buf_in;
  PRIVATE_AS u8 *out = (PRIVATE_AS u8 *) buf_out;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (is_uh (in[pos])) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  buf0[0] = buf_out[0];
  buf0[1] = buf_out[1];
  buf0[2] = buf_out[2];
  buf0[3] = buf_out[3];
  buf1[0] = buf_out[4];
  buf1[1] = buf_out[5];
  buf1[2] = buf_out[6];
  buf1[3] = buf_out[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_s_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  u32 out_len = 0;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 buf_out[8] = { 0 };

  PRIVATE_AS u8 *in  = (PRIVATE_AS u8 *) buf_in;
  PRIVATE_AS u8 *out = (PRIVATE_AS u8 *) buf_out;

  for (u32 pos = 0; pos < in_len; pos++)
  {
    if (is_s (in[pos])) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  buf0[0] = buf_out[0];
  buf0[1] = buf_out[1];
  buf0[2] = buf_out[2];
  buf0[3] = buf_out[3];
  buf1[0] = buf_out[4];
  buf1[1] = buf_out[5];
  buf1[2] = buf_out[6];
  buf1[3] = buf_out[7];

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_utf16le  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  else if ((u8)p0 == 'u') return rule_op_mangle_purgechar_class_u_utf16le (p0, p1, buf0, buf1, in_len);
       if ((u8)p0 == 'l') return rule_op_mangle_purgechar_class_l_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_purgechar_class_d_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_purgechar_class_lh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_purgechar_class_uh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_purgechar_class_s_utf16le (p0, p1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if ( in_len       ==  0) return in_len;
  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  const u32 tmp = buf0[0] & 0xFFFF;

  const u32 tmp32 = tmp <<  0
                  | tmp <<  16;

  rshift_block_optimized_N_utf16le (buf0, buf0, p0); 

  u32 t[16] = { tmp32, tmp32, tmp32, tmp32, tmp32, tmp32, tmp32, tmp32,tmp32, tmp32, tmp32, tmp32,tmp32, tmp32, tmp32, tmp32 };

  truncate_right_optimized_utf16le (t, p0);

  buf0[0 ] |= t[0 ];
  buf0[1 ] |= t[1 ];
  buf0[2 ] |= t[2 ];
  buf0[3 ] |= t[3 ];
  buf0[4 ] |= t[4 ];
  buf0[5 ] |= t[5 ];
  buf0[6 ] |= t[6 ];
  buf0[7 ] |= t[7 ];
  buf0[8 ] |= t[8 ];
  buf0[9 ] |= t[9 ];
  buf0[10] |= t[10];
  buf0[11] |= t[11];
  buf0[12] |= t[12];
  buf0[13] |= t[13];
  buf0[14] |= t[14];
  buf0[15] |= t[15];

  out_len += p0;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if ( in_len       ==  0) return in_len;
  if ((in_len + p0) >= 64) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 sh = (in_len1 & 2) * 8;

  u32 tmp = 0;

  u32 v[16];

  set_mark_1x16_S_16 (v, in_len1); 
  
  tmp |= buf0[0 ] & v[0 ];
  tmp |= buf0[1 ] & v[1 ];
  tmp |= buf0[2 ] & v[2 ];
  tmp |= buf0[3 ] & v[3 ];
  tmp |= buf0[4 ] & v[4 ];
  tmp |= buf0[5 ] & v[5 ];
  tmp |= buf0[6 ] & v[6 ];
  tmp |= buf0[7 ] & v[7 ];
  tmp |= buf0[8 ] & v[8 ];
  tmp |= buf0[9 ] & v[9 ];
  tmp |= buf0[10] & v[10];
  tmp |= buf0[11] & v[11];
  tmp |= buf0[12] & v[12];
  tmp |= buf0[13] & v[13];
  tmp |= buf0[14] & v[14];
  tmp |= buf0[15] & v[15];

  tmp = (tmp >> sh) & 0xffff;

  u32 out_len = in_len;

  for (u32 i = 0; i < p0/2; i++)
  {
    append_block1_optimized_utf16le (out_len, buf0, tmp); 

    out_len+=2;
  }

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_all_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len)  
{
  if ( in_len           ==  0) return in_len;
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib0[16];

  tib0[0 ] = ((buf0[0 ] & 0x0000FFFF) <<  0) | ((buf0[0 ] & 0x0000FFFF) <<  16);
  tib0[1 ] = ((buf0[0 ] & 0xFFFF0000) >> 16) | ((buf0[0 ] & 0xFFFF0000) >>  0 );
  tib0[2 ] = ((buf0[1 ] & 0x0000FFFF) <<  0) | ((buf0[1 ] & 0x0000FFFF) <<  16);
  tib0[3 ] = ((buf0[1 ] & 0xFFFF0000) >> 16) | ((buf0[1 ] & 0xFFFF0000) >>  0 );
  tib0[4 ] = ((buf0[2 ] & 0x0000FFFF) <<  0) | ((buf0[2 ] & 0x0000FFFF) <<  16);
  tib0[5 ] = ((buf0[2 ] & 0xFFFF0000) >> 16) | ((buf0[2 ] & 0xFFFF0000) >>  0 );
  tib0[6 ] = ((buf0[3 ] & 0x0000FFFF) <<  0) | ((buf0[3 ] & 0x0000FFFF) <<  16);
  tib0[7 ] = ((buf0[3 ] & 0xFFFF0000) >> 16) | ((buf0[3 ] & 0xFFFF0000) >>  0 );
  tib0[8 ] = ((buf0[4] & 0x0000FFFF) <<  0) | ((buf0[4] & 0x0000FFFF) <<  16);
  tib0[9 ] = ((buf0[4] & 0xFFFF0000) >> 16) | ((buf0[4] & 0xFFFF0000) >>  0 );
  tib0[10] = ((buf0[5] & 0x0000FFFF) <<  0) | ((buf0[5] & 0x0000FFFF) <<  16);
  tib0[11] = ((buf0[5] & 0xFFFF0000) >> 16) | ((buf0[5] & 0xFFFF0000) >>  0 );
  tib0[12] = ((buf0[6] & 0x0000FFFF) <<  0) | ((buf0[6] & 0x0000FFFF) <<  16);
  tib0[13] = ((buf0[6] & 0xFFFF0000) >> 16) | ((buf0[6] & 0xFFFF0000) >>  0 );
  tib0[14] = ((buf0[7] & 0x0000FFFF) <<  0) | ((buf0[7] & 0x0000FFFF) <<  16);
  tib0[15] = ((buf0[7] & 0xFFFF0000) >> 16) | ((buf0[7] & 0xFFFF0000) >>  0 );

  buf0[0 ] = tib0[0 ]; 
  buf0[1 ] = tib0[1 ];
  buf0[2 ] = tib0[2 ];
  buf0[3 ] = tib0[3 ];
  buf0[4 ] = tib0[4 ];
  buf0[5 ] = tib0[5 ];
  buf0[6 ] = tib0[6 ];
  buf0[7 ] = tib0[7 ];
  buf0[8 ] = tib0[8 ]; 
  buf0[9 ] = tib0[9 ];
  buf0[10] = tib0[10];
  buf0[11] = tib0[11];
  buf0[12] = tib0[12];
  buf0[13] = tib0[13];
  buf0[14] = tib0[14];
  buf0[15] = tib0[15];
  out_len = out_len + out_len;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (in_len < 4 ) return in_len;

  buf0[0 ] = ((buf0[0 ] & 0x0000FFFFu) << 16) | ((buf0[0 ] & 0xFFFF0000u) >> 16);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len)  
{
  if (in_len < 4) return in_len;

  u32 t[16];

  t[0 ] = buf0[0 ];
  t[1 ] = buf0[1 ];
  t[2 ] = buf0[2 ];
  t[3 ] = buf0[3 ];
  t[4 ] = buf0[4 ];
  t[5 ] = buf0[5 ];
  t[6 ] = buf0[6 ];
  t[7 ] = buf0[7 ];
  t[8 ] = buf0[8 ];
  t[9 ] = buf0[9 ];
  t[10] = buf0[10];
  t[11] = buf0[11];
  t[12] = buf0[12];
  t[13] = buf0[13];
  t[14] = buf0[14];
  t[15] = buf0[15];

  exchange_byte_optimized_utf16le (t, (in_len/2) - 2, (in_len/2) - 1);  

  buf0[0 ] = t[0 ];
  buf0[1 ] = t[1 ];
  buf0[2 ] = t[2 ];
  buf0[3 ] = t[3 ];
  buf0[4 ] = t[4 ];
  buf0[5 ] = t[5 ];
  buf0[6 ] = t[6 ];
  buf0[7 ] = t[7 ];
  buf0[8 ] = t[8 ];
  buf0[9 ] = t[9 ];
  buf0[10] = t[10];
  buf0[11] = t[11];
  buf0[12] = t[12];
  buf0[13] = t[13];
  buf0[14] = t[14];
  buf0[15] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;
  if (p1 >= in_len) return in_len;

  u32 t[16];

  t[0 ] = buf0[0 ];
  t[1 ] = buf0[1 ];
  t[2 ] = buf0[2 ];
  t[3 ] = buf0[3 ];
  t[4 ] = buf0[4 ];
  t[5 ] = buf0[5 ];
  t[6 ] = buf0[6 ];
  t[7 ] = buf0[7 ];
  t[8 ] = buf0[8 ];
  t[9 ] = buf0[9 ];
  t[10] = buf0[10];
  t[11] = buf0[11];
  t[12] = buf0[12];
  t[13] = buf0[13];
  t[14] = buf0[14];
  t[15] = buf0[15];

  exchange_byte_optimized_utf16le (t, p0/2, p1/2);

  buf0[0 ] = t[0 ];
  buf0[1 ] = t[1 ];
  buf0[2 ] = t[2 ];
  buf0[3 ] = t[3 ];
  buf0[4 ] = t[4 ];
  buf0[5 ] = t[5 ];
  buf0[6 ] = t[6 ];
  buf0[7 ] = t[7 ];
  buf0[8 ] = t[8 ];
  buf0[9 ] = t[9 ];
  buf0[10] = t[10];
  buf0[11] = t[11];
  buf0[12] = t[12];
  buf0[13] = t[13];
  buf0[14] = t[14];
  buf0[15] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftl_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 m = ~(0xffffu << ((p0 & 2u) * 8u));
  const u32 pos = p0 /4u;

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] =  ( t[0 ] & buf0[0 ] ) | ( ~t[0 ] & ( buf0[0 ] << 1u )) ;
  buf0[1 ] =  ( t[1 ] & buf0[1 ] ) | ( ~t[1 ] & ( buf0[1 ] << 1u )) ;
  buf0[2 ] =  ( t[2 ] & buf0[2 ] ) | ( ~t[2 ] & ( buf0[2 ] << 1u )) ;
  buf0[3 ] =  ( t[3 ] & buf0[3 ] ) | ( ~t[3 ] & ( buf0[3 ] << 1u )) ;
  buf0[4 ] =  ( t[4 ] & buf0[4 ] ) | ( ~t[4 ] & ( buf0[4 ] << 1u )) ;
  buf0[5 ] =  ( t[5 ] & buf0[5 ] ) | ( ~t[5 ] & ( buf0[5 ] << 1u )) ;
  buf0[6 ] =  ( t[6 ] & buf0[6 ] ) | ( ~t[6 ] & ( buf0[6 ] << 1u )) ;
  buf0[7 ] =  ( t[7 ] & buf0[7 ] ) | ( ~t[7 ] & ( buf0[7 ] << 1u )) ;
  buf0[8 ] =  ( t[8 ] & buf0[8 ] ) | ( ~t[8 ] & ( buf0[8 ] << 1u )) ;
  buf0[9 ] =  ( t[9 ] & buf0[9 ] ) | ( ~t[9 ] & ( buf0[9 ] << 1u )) ;
  buf0[10] =  ( t[10] & buf0[10] ) | ( ~t[10] & ( buf0[10] << 1u )) ;
  buf0[11] =  ( t[11] & buf0[11] ) | ( ~t[11] & ( buf0[11] << 1u )) ;
  buf0[12] =  ( t[12] & buf0[12] ) | ( ~t[12] & ( buf0[12] << 1u )) ;
  buf0[13] =  ( t[13] & buf0[13] ) | ( ~t[13] & ( buf0[13] << 1u )) ;
  buf0[14] =  ( t[14] & buf0[14] ) | ( ~t[14] & ( buf0[14] << 1u )) ;
  buf0[15] =  ( t[15] & buf0[15] ) | ( ~t[15] & ( buf0[15] << 1u )) ;
  
  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 m = ~(0xffffu << ((p0 & 2u) * 8u));
  const u32 pos = p0 /4u;

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] =  ( t[0 ] & buf0[0 ] ) | ( ~t[0 ] & ( buf0[0 ] >> 1u )) ;
  buf0[1 ] =  ( t[1 ] & buf0[1 ] ) | ( ~t[1 ] & ( buf0[1 ] >> 1u )) ;
  buf0[2 ] =  ( t[2 ] & buf0[2 ] ) | ( ~t[2 ] & ( buf0[2 ] >> 1u )) ;
  buf0[3 ] =  ( t[3 ] & buf0[3 ] ) | ( ~t[3 ] & ( buf0[3 ] >> 1u )) ;
  buf0[4 ] =  ( t[4 ] & buf0[4 ] ) | ( ~t[4 ] & ( buf0[4 ] >> 1u )) ;
  buf0[5 ] =  ( t[5 ] & buf0[5 ] ) | ( ~t[5 ] & ( buf0[5 ] >> 1u )) ;
  buf0[6 ] =  ( t[6 ] & buf0[6 ] ) | ( ~t[6 ] & ( buf0[6 ] >> 1u )) ;
  buf0[7 ] =  ( t[7 ] & buf0[7 ] ) | ( ~t[7 ] & ( buf0[7 ] >> 1u )) ;
  buf0[8 ] =  ( t[8 ] & buf0[8 ] ) | ( ~t[8 ] & ( buf0[8 ] >> 1u )) ;
  buf0[9 ] =  ( t[9 ] & buf0[9 ] ) | ( ~t[9 ] & ( buf0[9 ] >> 1u )) ;
  buf0[10] =  ( t[10] & buf0[10] ) | ( ~t[10] & ( buf0[10] >> 1u )) ;
  buf0[11] =  ( t[11] & buf0[11] ) | ( ~t[11] & ( buf0[11] >> 1u )) ;
  buf0[12] =  ( t[12] & buf0[12] ) | ( ~t[12] & ( buf0[12] >> 1u )) ;
  buf0[13] =  ( t[13] & buf0[13] ) | ( ~t[13] & ( buf0[13] >> 1u )) ;
  buf0[14] =  ( t[14] & buf0[14] ) | ( ~t[14] & ( buf0[14] >> 1u )) ;
  buf0[15] =  ( t[15] & buf0[15] ) | ( ~t[15] & ( buf0[15] >> 1u )) ;
  
  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_incr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 m = ~(0xffffu << ((p0 & 2u) * 8u));
  const u32 pos = p0/4u;

  const u32 n = 0x00010001u; 

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] =  ( t[0 ] & buf0[0 ] ) | ( ~t[0 ] & ( buf0[0 ] + n )) ;
  buf0[1 ] =  ( t[1 ] & buf0[1 ] ) | ( ~t[1 ] & ( buf0[1 ] + n )) ;
  buf0[2 ] =  ( t[2 ] & buf0[2 ] ) | ( ~t[2 ] & ( buf0[2 ] + n )) ;
  buf0[3 ] =  ( t[3 ] & buf0[3 ] ) | ( ~t[3 ] & ( buf0[3 ] + n )) ;
  buf0[4 ] =  ( t[4 ] & buf0[4 ] ) | ( ~t[4 ] & ( buf0[4 ] + n )) ;
  buf0[5 ] =  ( t[5 ] & buf0[5 ] ) | ( ~t[5 ] & ( buf0[5 ] + n )) ;
  buf0[6 ] =  ( t[6 ] & buf0[6 ] ) | ( ~t[6 ] & ( buf0[6 ] + n )) ;
  buf0[7 ] =  ( t[7 ] & buf0[7 ] ) | ( ~t[7 ] & ( buf0[7 ] + n )) ;
  buf0[8 ] =  ( t[8 ] & buf0[8 ] ) | ( ~t[8 ] & ( buf0[8 ] + n )) ;
  buf0[9 ] =  ( t[9 ] & buf0[9 ] ) | ( ~t[9 ] & ( buf0[9 ] + n )) ;
  buf0[10] =  ( t[10] & buf0[10] ) | ( ~t[10] & ( buf0[10] + n )) ;
  buf0[11] =  ( t[11] & buf0[11] ) | ( ~t[11] & ( buf0[11] + n )) ;
  buf0[12] =  ( t[12] & buf0[12] ) | ( ~t[12] & ( buf0[12] + n )) ;
  buf0[13] =  ( t[13] & buf0[13] ) | ( ~t[13] & ( buf0[13] + n )) ;
  buf0[14] =  ( t[14] & buf0[14] ) | ( ~t[14] & ( buf0[14] + n )) ;
  buf0[15] =  ( t[15] & buf0[15] ) | ( ~t[15] & ( buf0[15] + n )) ;

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_decr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 m = ~(0xffffu << ((p0 & 2u) * 8u));
  const u32 pos = p0/4u;

  const u32 n = 0x00010001u; 

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] =  ( t[0 ] & buf0[0 ] ) | ( ~t[0 ] & ( buf0[0 ] - n )) ;
  buf0[1 ] =  ( t[1 ] & buf0[1 ] ) | ( ~t[1 ] & ( buf0[1 ] - n )) ;
  buf0[2 ] =  ( t[2 ] & buf0[2 ] ) | ( ~t[2 ] & ( buf0[2 ] - n )) ;
  buf0[3 ] =  ( t[3 ] & buf0[3 ] ) | ( ~t[3 ] & ( buf0[3 ] - n )) ;
  buf0[4 ] =  ( t[4 ] & buf0[4 ] ) | ( ~t[4 ] & ( buf0[4 ] - n )) ;
  buf0[5 ] =  ( t[5 ] & buf0[5 ] ) | ( ~t[5 ] & ( buf0[5 ] - n )) ;
  buf0[6 ] =  ( t[6 ] & buf0[6 ] ) | ( ~t[6 ] & ( buf0[6 ] - n )) ;
  buf0[7 ] =  ( t[7 ] & buf0[7 ] ) | ( ~t[7 ] & ( buf0[7 ] - n )) ;
  buf0[8 ] =  ( t[8 ] & buf0[8 ] ) | ( ~t[8 ] & ( buf0[8 ] - n )) ;
  buf0[9 ] =  ( t[9 ] & buf0[9 ] ) | ( ~t[9 ] & ( buf0[9 ] - n )) ;
  buf0[10] =  ( t[10] & buf0[10] ) | ( ~t[10] & ( buf0[10] - n )) ;
  buf0[11] =  ( t[11] & buf0[11] ) | ( ~t[11] & ( buf0[11] - n )) ;
  buf0[12] =  ( t[12] & buf0[12] ) | ( ~t[12] & ( buf0[12] - n )) ;
  buf0[13] =  ( t[13] & buf0[13] ) | ( ~t[13] & ( buf0[13] - n )) ;
  buf0[14] =  ( t[14] & buf0[14] ) | ( ~t[14] & ( buf0[14] - n )) ;
  buf0[15] =  ( t[15] & buf0[15] ) | ( ~t[15] & ( buf0[15] - n )) ;
  
  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_np1_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if ((p0 + 2) >= in_len) return in_len;

  u32 tib0[16];

  lshift_block_optimized_utf16le (buf0, tib0);

  const u32 m = ~(0xffffu << ((p0 & 2u) * 8u));
  const u32 pos = p0 / 4u;

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] = ( t[0 ] & buf0[0 ] ) | ( ~t[0 ] & tib0[0 ] );
  buf0[1 ] = ( t[1 ] & buf0[1 ] ) | ( ~t[1 ] & tib0[1 ] );
  buf0[2 ] = ( t[2 ] & buf0[2 ] ) | ( ~t[2 ] & tib0[2 ] );
  buf0[3 ] = ( t[3 ] & buf0[3 ] ) | ( ~t[3 ] & tib0[3 ] );
  buf0[4 ] = ( t[4 ] & buf0[4 ] ) | ( ~t[4 ] & tib0[4 ] );
  buf0[5 ] = ( t[5 ] & buf0[5 ] ) | ( ~t[5 ] & tib0[5 ] );
  buf0[6 ] = ( t[6 ] & buf0[6 ] ) | ( ~t[6 ] & tib0[6 ] );
  buf0[7 ] = ( t[7 ] & buf0[7 ] ) | ( ~t[7 ] & tib0[7 ] );
  buf0[8 ] = ( t[8 ] & buf0[8 ] ) | ( ~t[8 ] & tib0[8 ] );
  buf0[9 ] = ( t[9 ] & buf0[9 ] ) | ( ~t[9 ] & tib0[9 ] );
  buf0[10] = ( t[10] & buf0[10] ) | ( ~t[10] & tib0[10] );
  buf0[11] = ( t[11] & buf0[11] ) | ( ~t[11] & tib0[11] );
  buf0[12] = ( t[12] & buf0[12] ) | ( ~t[12] & tib0[12] );
  buf0[13] = ( t[13] & buf0[13] ) | ( ~t[13] & tib0[13] );
  buf0[14] = ( t[14] & buf0[14] ) | ( ~t[14] & tib0[14] );
  buf0[15] = ( t[15] & buf0[15] ) | ( ~t[15] & tib0[15] );

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_nm1_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 == 0) return in_len;

  if (p0 >= in_len) return in_len;

  u32 tib0[16];

  rshift_block_optimized_utf16le (buf0, tib0);

  const u32 m = ~(0xffffu << ((p0 & 2u) * 8u));
  const u32 pos = p0 / 4u;

  u32 t[16];

  t[0 ] = (pos == 0 )? m : 0xffffffffffffffffu;
  t[1 ] = (pos == 1 )? m : 0xffffffffffffffffu;
  t[2 ] = (pos == 2 )? m : 0xffffffffffffffffu;
  t[3 ] = (pos == 3 )? m : 0xffffffffffffffffu;
  t[4 ] = (pos == 4 )? m : 0xffffffffffffffffu;
  t[5 ] = (pos == 5 )? m : 0xffffffffffffffffu;
  t[6 ] = (pos == 6 )? m : 0xffffffffffffffffu;
  t[7 ] = (pos == 7 )? m : 0xffffffffffffffffu;
  t[8 ] = (pos == 8 )? m : 0xffffffffffffffffu;
  t[9 ] = (pos == 9 )? m : 0xffffffffffffffffu;
  t[10] = (pos == 10)? m : 0xffffffffffffffffu;
  t[11] = (pos == 11)? m : 0xffffffffffffffffu;
  t[12] = (pos == 12)? m : 0xffffffffffffffffu;
  t[13] = (pos == 13)? m : 0xffffffffffffffffu;
  t[14] = (pos == 14)? m : 0xffffffffffffffffu;
  t[15] = (pos == 15)? m : 0xffffffffffffffffu;

  buf0[0 ] = ( t[0 ] & buf0[0 ] ) | ( ~t[0 ] & tib0[0 ] );
  buf0[1 ] = ( t[1 ] & buf0[1 ] ) | ( ~t[1 ] & tib0[1 ] );
  buf0[2 ] = ( t[2 ] & buf0[2 ] ) | ( ~t[2 ] & tib0[2 ] );
  buf0[3 ] = ( t[3 ] & buf0[3 ] ) | ( ~t[3 ] & tib0[3 ] );
  buf0[4 ] = ( t[4 ] & buf0[4 ] ) | ( ~t[4 ] & tib0[4 ] );
  buf0[5 ] = ( t[5 ] & buf0[5 ] ) | ( ~t[5 ] & tib0[5 ] );
  buf0[6 ] = ( t[6 ] & buf0[6 ] ) | ( ~t[6 ] & tib0[6 ] );
  buf0[7 ] = ( t[7 ] & buf0[7 ] ) | ( ~t[7 ] & tib0[7 ] );
  buf0[8 ] = ( t[8 ] & buf0[8 ] ) | ( ~t[8 ] & tib0[8 ] );
  buf0[9 ] = ( t[9 ] & buf0[9 ] ) | ( ~t[9 ] & tib0[9 ] );
  buf0[10] = ( t[10] & buf0[10] ) | ( ~t[10] & tib0[10] );
  buf0[11] = ( t[11] & buf0[11] ) | ( ~t[11] & tib0[11] );
  buf0[12] = ( t[12] & buf0[12] ) | ( ~t[12] & tib0[12] );
  buf0[13] = ( t[13] & buf0[13] ) | ( ~t[13] & tib0[13] );
  buf0[14] = ( t[14] & buf0[14] ) | ( ~t[14] & tib0[14] );
  buf0[15] = ( t[15] & buf0[15] ) | ( ~t[15] & tib0[15] );

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 > in_len) return in_len;

  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib0[4];

  tib0[0 ] = buf0[0 ];
  tib0[1 ] = buf0[1 ];
  tib0[2 ] = buf0[2 ];
  tib0[3 ] = buf0[3 ];
  tib0[4 ] = buf0[4 ];
  tib0[5 ] = buf0[5 ];
  tib0[6 ] = buf0[6 ];
  tib0[7 ] = buf0[7 ];
  tib0[8 ] = buf0[8 ];
  tib0[9 ] = buf0[9 ];
  tib0[10] = buf0[10];
  tib0[11] = buf0[11];
  tib0[12] = buf0[12];
  tib0[13] = buf0[13];
  tib0[14] = buf0[14];
  tib0[15] = buf0[15];

  truncate_right_optimized_utf16le (tib0, p0);

  rshift_block_optimized_N_utf16le (buf0, buf0, p0);

  buf0[0 ] |= tib0[0 ];
  buf0[1 ] |= tib0[1 ];
  buf0[2 ] |= tib0[2 ];
  buf0[3 ] |= tib0[3 ];
  buf0[4 ] |= tib0[4 ];
  buf0[5 ] |= tib0[5 ];
  buf0[6 ] |= tib0[6 ];
  buf0[7 ] |= tib0[7 ];
  buf0[8 ] |= tib0[8 ];
  buf0[9 ] |= tib0[9 ];
  buf0[10] |= tib0[10];
  buf0[11] |= tib0[11];
  buf0[12] |= tib0[12];
  buf0[13] |= tib0[13];
  buf0[14] |= tib0[14];
  buf0[15] |= tib0[15];

  out_len += p0;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (p0 > in_len) return in_len;

  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib0[16];

  rshift_block_optimized_N_utf16le (buf0, tib0, p0);

  truncate_left_optimized_utf16le (tib0, out_len);

  buf0[0 ] |= tib0[0 ];
  buf0[1 ] |= tib0[1 ];
  buf0[2 ] |= tib0[2 ];
  buf0[3 ] |= tib0[3 ];
  buf0[4 ] |= tib0[4 ];
  buf0[5 ] |= tib0[5 ];
  buf0[6 ] |= tib0[6 ];
  buf0[7 ] |= tib0[7 ];
  buf0[8 ] |= tib0[8 ];
  buf0[9 ] |= tib0[9 ];
  buf0[10] |= tib0[10];
  buf0[11] |= tib0[11];
  buf0[12] |= tib0[12];
  buf0[13] |= tib0[13];
  buf0[14] |= tib0[14];
  buf0[15] |= tib0[15];

  out_len += p0;

  return out_len;
}

DECLSPEC u32 toggle_on_register_utf16le (const u32 in, const u32 r) 
{
  u32 out = in;

  const u32 cmask = generate_cmask_optimized_utf16le(out);

  if (r & 1) out = out ^ (0x00000020 & cmask);
  if (r & 2) out = out ^ (0x00200000 & cmask);

  return out;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0,  const u32 in_len) 
{
  if (in_len == 0) return in_len;

  u32 r0  = search_on_register_utf16le (buf0[0 ], p0);
  u32 r1  = search_on_register_utf16le (buf0[1 ], p0);
  u32 r2  = search_on_register_utf16le (buf0[2 ], p0);
  u32 r3  = search_on_register_utf16le (buf0[3 ], p0);
  u32 r4  = search_on_register_utf16le (buf0[4 ], p0);
  u32 r5  = search_on_register_utf16le (buf0[5 ], p0);
  u32 r6  = search_on_register_utf16le (buf0[6 ], p0);
  u32 r7  = search_on_register_utf16le (buf0[7 ], p0);
  u32 r8  = search_on_register_utf16le (buf0[8 ], p0);
  u32 r9  = search_on_register_utf16le (buf0[9 ], p0);
  u32 r10 = search_on_register_utf16le (buf0[10], p0);
  u32 r11 = search_on_register_utf16le (buf0[11], p0);
  u32 r12 = search_on_register_utf16le (buf0[12], p0);
  u32 r13 = search_on_register_utf16le (buf0[13], p0);
  u32 r14 = search_on_register_utf16le (buf0[14], p0);
  u32 r15 = search_on_register_utf16le (buf0[15], p0);

  rule_op_mangle_lrest_ufirst_utf16le (p0, p1, buf0, in_len);

  const u32 rn = r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15;
  if (rn == 0) return in_len;

  r0 <<= 1;
  r1 <<= 1; r1 |= r0 >> 2;
  r2 <<= 1; r2 |= r1 >> 2;
  r3 <<= 1; r3 |= r2 >> 2;
  r4 <<= 1; r4 |= r3 >> 2;
  r5 <<= 1; r5 |= r4 >> 2;
  r6 <<= 1; r6 |= r5 >> 2;
  r7 <<= 1; r7 |= r6 >> 2;
  r8 <<= 1; r8 |= r7 >> 2;
  r9 <<= 1; r9 |= r8 >> 2;
  r10 <<= 1; r10 |= r9 >> 2;
  r11 <<= 1; r11 |= r10 >> 2;
  r12 <<= 1; r12 |= r11 >> 2;
  r13 <<= 1; r13 |= r12 >> 2;
  r14 <<= 1; r14 |= r13 >> 2;
  r15 <<= 1; r15 |= r14 >> 2;

  buf0[0 ] = toggle_on_register_utf16le (buf0[0 ], r0 );
  buf0[1 ] = toggle_on_register_utf16le (buf0[1 ], r1 );
  buf0[2 ] = toggle_on_register_utf16le (buf0[2 ], r2 );
  buf0[3 ] = toggle_on_register_utf16le (buf0[3 ], r3 );
  buf0[4 ] = toggle_on_register_utf16le (buf0[4 ], r4 );
  buf0[5 ] = toggle_on_register_utf16le (buf0[5 ], r5 );
  buf0[6 ] = toggle_on_register_utf16le (buf0[6 ], r6 );
  buf0[7 ] = toggle_on_register_utf16le (buf0[7 ], r7 );
  buf0[8 ] = toggle_on_register_utf16le (buf0[8 ], r8 );
  buf0[9 ] = toggle_on_register_utf16le (buf0[9 ], r9 );
  buf0[10] = toggle_on_register_utf16le (buf0[10], r10);
  buf0[11] = toggle_on_register_utf16le (buf0[11], r11);
  buf0[12] = toggle_on_register_utf16le (buf0[12], r12);
  buf0[13] = toggle_on_register_utf16le (buf0[13], r13);
  buf0[14] = toggle_on_register_utf16le (buf0[14], r14);
  buf0[15] = toggle_on_register_utf16le (buf0[15], r15);
  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_l_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  if (in_len == 0) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 rem = 0xff;

  u32 rn = 0;

  for (u32 i = 0, idx = 0; i < in_len; i += 4, idx += 1)
  {
    const u32 t = buf_in[idx];

    buf_in[idx] = t | generate_cmask_utf16le (t);

    u32 out = rem;

    rem = 0;

    if (is_l ((t >>  0) & 0xff)) { rn++; out |= 0x0000ff00; }
    if (is_l ((t >>  8) & 0xff)) { rn++; out |= 0x00ff0000; }
    if (is_l ((t >> 16) & 0xff)) { rn++; out |= 0xff000000; }
    if (is_l ((t >> 24) & 0xff)) { rn++; rem |= 0x000000ff; }

    buf_in[idx] &= ~(generate_cmask_utf16le (buf_in[idx]) & out);
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_u_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  if (in_len == 0) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 rem = 0xff;

  u32 rn = 0;

  for (u32 i = 0, idx = 0; i < in_len; i += 4, idx += 1)
  {
    const u32 t = buf_in[idx];

    buf_in[idx] = t | generate_cmask_utf16le (t);

    u32 out = rem;

    rem = 0;

    if (is_u ((t >>  0) & 0xff)) { rn++; out |= 0x0000ff00; }
    if (is_u ((t >>  8) & 0xff)) { rn++; out |= 0x00ff0000; }
    if (is_u ((t >> 16) & 0xff)) { rn++; out |= 0xff000000; }
    if (is_u ((t >> 24) & 0xff)) { rn++; rem |= 0x000000ff; }

    buf_in[idx] &= ~(generate_cmask_utf16le (buf_in[idx]) & out);
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_d_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  if (in_len == 0) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 rem = 0xff;

  u32 rn = 0;

  for (u32 i = 0, idx = 0; i < in_len; i += 4, idx += 1)
  {
    const u32 t = buf_in[idx];

    buf_in[idx] = t | generate_cmask_utf16le (t);

    u32 out = rem;

    rem = 0;

    if (is_d ((t >>  0) & 0xff)) { rn++; out |= 0x0000ff00; }
    if (is_d ((t >>  8) & 0xff)) { rn++; out |= 0x00ff0000; }
    if (is_d ((t >> 16) & 0xff)) { rn++; out |= 0xff000000; }
    if (is_d ((t >> 24) & 0xff)) { rn++; rem |= 0x000000ff; }

    buf_in[idx] &= ~(generate_cmask_utf16le (buf_in[idx]) & out);
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_lh_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  if (in_len == 0) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 rem = 0xff;

  u32 rn = 0;

  for (u32 i = 0, idx = 0; i < in_len; i += 4, idx += 1)
  {
    const u32 t = buf_in[idx];

    buf_in[idx] = t | generate_cmask_utf16le (t);

    u32 out = rem;

    rem = 0;

    if (is_lh ((t >>  0) & 0xff)) { rn++; out |= 0x0000ff00; }
    if (is_lh ((t >>  8) & 0xff)) { rn++; out |= 0x00ff0000; }
    if (is_lh ((t >> 16) & 0xff)) { rn++; out |= 0xff000000; }
    if (is_lh ((t >> 24) & 0xff)) { rn++; rem |= 0x000000ff; }

    buf_in[idx] &= ~(generate_cmask_utf16le (buf_in[idx]) & out);
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_uh_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  if (in_len == 0) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 rem = 0xff;

  u32 rn = 0;

  for (u32 i = 0, idx = 0; i < in_len; i += 4, idx += 1)
  {
    const u32 t = buf_in[idx];

    buf_in[idx] = t | generate_cmask_utf16le (t);

    u32 out = rem;

    rem = 0;

    if (is_uh ((t >>  0) & 0xff)) { rn++; out |= 0x0000ff00; }
    if (is_uh ((t >>  8) & 0xff)) { rn++; out |= 0x00ff0000; }
    if (is_uh ((t >> 16) & 0xff)) { rn++; out |= 0xff000000; }
    if (is_uh ((t >> 24) & 0xff)) { rn++; rem |= 0x000000ff; }

    buf_in[idx] &= ~(generate_cmask_utf16le (buf_in[idx]) & out);
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_s_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
  if (in_len == 0) return in_len;

  u32 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u32 rem = 0xff;

  u32 rn = 0;

  for (u32 i = 0, idx = 0; i < in_len; i += 4, idx += 1)
  {
    const u32 t = buf_in[idx];

    buf_in[idx] = t | generate_cmask_utf16le (t);

    u32 out = rem;

    rem = 0;

    if (is_s ((t >>  0) & 0xff)) { rn++; out |= 0x0000ff00; }
    if (is_s ((t >>  8) & 0xff)) { rn++; out |= 0x00ff0000; }
    if (is_s ((t >> 16) & 0xff)) { rn++; out |= 0xff000000; }
    if (is_s ((t >> 24) & 0xff)) { rn++; rem |= 0x000000ff; }

    buf_in[idx] &= ~(generate_cmask_utf16le (buf_in[idx]) & out);
  }

  if (rn == 0) return in_len;

  buf0[0] = buf_in[0];
  buf0[1] = buf_in[1];
  buf0[2] = buf_in[2];
  buf0[3] = buf_in[3];
  buf1[0] = buf_in[4];
  buf1[1] = buf_in[5];
  buf1[2] = buf_in[6];
  buf1[3] = buf_in[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_utf16le  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) //TODO
{
       if ((u8)p0 == 'l') return rule_op_mangle_title_sep_class_l_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_title_sep_class_u_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_title_sep_class_d_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_title_sep_class_lh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_title_sep_class_uh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_title_sep_class_s_utf16le (p0, p1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC u32 apply_rule_optimized_utf16le (const u32 name, const u32 p0, const u32 p1, PRIVATE_AS u32 *buf0, const u32 in_len)
{
  u32 out_len = in_len;

  if (name == RULE_OP_MANGLE_NOOP) return out_len;

  switch (name)
  {
    case RULE_OP_MANGLE_LREST:            out_len = rule_op_mangle_lrest_utf16le            (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_UREST:            out_len = rule_op_mangle_urest_utf16le            (p0, p1, buf0, out_len); break;  // revoir pour les nombre
    case RULE_OP_MANGLE_LREST_UFIRST:     out_len = rule_op_mangle_lrest_ufirst_utf16le     (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_UREST_LFIRST:     out_len = rule_op_mangle_urest_lfirst_utf16le     (p0, p1, buf0, out_len); break;  // revoir pour les nombre
    case RULE_OP_MANGLE_TREST:            out_len = rule_op_mangle_trest_utf16le            (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SHIFT_CASE:       out_len = rule_op_mangle_shift_case_utf16le       (p0, p1, buf0, out_len); break; //TODO
    case RULE_OP_MANGLE_TOGGLE_AT:        out_len = rule_op_mangle_toggle_at_utf16le        (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TOGGLE_AT_SEP:    out_len = rule_op_mangle_toggle_at_sep_utf16le    (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REVERSE:          out_len = rule_op_mangle_reverse_utf16le          (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEWORD:         out_len = rule_op_mangle_dupeword_utf16le         (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEWORD_TIMES:   out_len = rule_op_mangle_dupeword_times_utf16le   (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REFLECT:          out_len = rule_op_mangle_reflect_utf16le          (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_APPEND:           out_len = rule_op_mangle_append_utf16le           (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_PREPEND:          out_len = rule_op_mangle_prepend_utf16le          (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_ROTATE_LEFT:      out_len = rule_op_mangle_rotate_left_utf16le      (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_ROTATE_RIGHT:     out_len = rule_op_mangle_rotate_right_utf16le     (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_FIRST:     out_len = rule_op_mangle_delete_first_utf16le     (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_LAST:      out_len = rule_op_mangle_delete_last_utf16le      (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_AT:        out_len = rule_op_mangle_delete_at_utf16le        (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_EXTRACT:          out_len = rule_op_mangle_extract_utf16le          (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_OMIT:             out_len = rule_op_mangle_omit_utf16le             (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_INSERT:           out_len = rule_op_mangle_insert_utf16le           (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_INSERT_EVERY:     out_len = rule_op_mangle_insert_every_utf16le     (p0, p1, buf0, out_len); break; // TODO
    case RULE_OP_MANGLE_OVERSTRIKE:       out_len = rule_op_mangle_overstrike_utf16le       (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TRUNCATE_AT:      out_len = rule_op_mangle_truncate_at_utf16le      (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE:          out_len = rule_op_mangle_replace_utf16le          (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE_CLASS:    out_len = rule_op_mangle_replace_class_utf16le    (p0, p1, buf0, out_len); break;// TODO
    case RULE_OP_MANGLE_PURGECHAR:        out_len = rule_op_mangle_purgechar_utf16le        (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_PURGECHAR_CLASS:  out_len = rule_op_mangle_purgechar_class_utf16le  (p0, p1, buf0, out_len); break; // TODO
    //case RULE_OP_MANGLE_TOGGLECASE_REC:   out_len = rule_op_mangle_togglecase_rec_utf16le (p0, p1, buf0, out_len); break;
    case RULE_OP_MANGLE_DUPECHAR_FIRST:   out_len = rule_op_mangle_dupechar_first_utf16le   (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPECHAR_LAST:    out_len = rule_op_mangle_dupechar_last_utf16le    (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPECHAR_ALL:     out_len = rule_op_mangle_dupechar_all_utf16le     (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_FIRST:     out_len = rule_op_mangle_switch_first_utf16le     (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_LAST:      out_len = rule_op_mangle_switch_last_utf16le      (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_AT:        out_len = rule_op_mangle_switch_at_utf16le        (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_SHIFTL:       out_len = rule_op_mangle_chr_shiftl_utf16le       (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_SHIFTR:       out_len = rule_op_mangle_chr_shiftr_utf16le       (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_INCR:         out_len = rule_op_mangle_chr_incr_utf16le         (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_DECR:         out_len = rule_op_mangle_chr_decr_utf16le         (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_ADD:          out_len = rule_op_mangle_chr_add_utf16le          (p0, p1, buf0, out_len); break;//TODO
    case RULE_OP_MANGLE_REPLACE_NP1:      out_len = rule_op_mangle_replace_np1_utf16le      (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE_NM1:      out_len = rule_op_mangle_replace_nm1_utf16le      (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEBLOCK_FIRST:  out_len = rule_op_mangle_dupeblock_first_utf16le  (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEBLOCK_LAST:   out_len = rule_op_mangle_dupeblock_last_utf16le   (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TITLE_SEP:        out_len = rule_op_mangle_title_sep_utf16le        (p0, p1, buf0, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TITLE_SEP_CLASS:  out_len = rule_op_mangle_title_sep_class_utf16le  (p0, p1, buf0, out_len); break; // TODO
    case RULE_OP_MANGLE_TITLE:            out_len = rule_op_mangle_title_sep_utf16le        (' ', p1, buf0, out_len); break; // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TO_HEX_LOWER:     out_len = rule_op_mangle_to_hex_lower_utf16le     (p0, p1, buf0, out_len); break; // TODO
    case RULE_OP_MANGLE_TO_HEX_UPPER:     out_len = rule_op_mangle_to_hex_upper_utf16le     (p0, p1, buf0, out_len); break; // TODO
      }

  return out_len;
}

DECLSPEC u32 apply_rules_optimized_utf16le (CONSTANT_AS const u64 *cmds, PRIVATE_AS u32 *buf0, const u32 len)
{
  u32 out_len = len;

  for (u32 i = 0; cmds[i] != 0; i++)
  {
    const u64 cmd = cmds[i];
    
    //printf(" cmd : %.16llX \n", cmd);
    const u32 name = (cmd >>  0) & 0xffff;
    const u32 p0   = (cmd >>  16) & 0xffff;
    const u32 p1   = (cmd >>  32) & 0xffff;

/*     printf("name : %.8X \n", name);
    printf("p0 : %.8X \n", p0);
    printf("p1 : %.8X \n", p1);
 */
    //printf("AV len %d : buf0[0 ] : %.8X buf0[1 ] : %.8X buf0[2 ] : %.8X buf0[3 ] : %.8X buf0[4 ] : %.8X buf0[5 ] : %.8X buf0[6 ] : %.8X buf0[7 ] : %.8X\n", out_len, *buf0,*(buf0+1),*(buf0+2),*(buf0+3),*buf1,*(buf1+1),*(buf1+2),*(buf1+3));
    //printf("AV len %d : buf0[8 ] : %.8X buf0[9 ] : %.8X buf0[10] : %.8X buf0[11] : %.8X buf0[12] : %.8X buf0[13] : %.8X buf0[14] : %.8X buf0[15] : %.8X\n", out_len, *buf2,*(buf2+1),*(buf2+2),*(buf2+3),*buf3,*(buf3+1),*(buf3+2),*(buf3+3));

    // we need to guarantee input length < 32 otherwise functions like rule_op_mangle_switch_last() and others will read out of boundary
    out_len = apply_rule_optimized_utf16le (name, p0, p1, buf0, out_len);

    //printf("AP len %d : buf0[0 ] : %.8X buf0[1 ] : %.8X buf0[2 ] : %.8X buf0[3 ] : %.8X buf0[4 ] : %.8X buf0[5 ] : %.8X buf0[6 ] : %.8X buf0[7 ] : %.8X\n", out_len, *buf0,*(buf0+1),*(buf0+2),*(buf0+3),*buf1,*(buf1+1),*(buf1+2),*(buf1+3));
    //printf("AP len %d : buf0[8 ] : %.8X buf0[9 ] : %.8X buf0[10] : %.8X buf0[11] : %.8X buf0[12] : %.8X buf0[13] : %.8X buf0[14] : %.8X buf0[15] : %.8X\n", out_len, *buf2,*(buf2+1),*(buf2+2),*(buf2+3),*buf3,*(buf3+1),*(buf3+2),*(buf3+3));

  }

  return out_len;
}

DECLSPEC u32x apply_rules_vect_optimized_utf16le (PRIVATE_AS const u32 *pw_buf0, const u32 pw_len, CONSTANT_AS const kernel_rule_t *kernel_rules, const u32 il_pos, PRIVATE_AS u32x *buf0)
{
  //printf("cmd : %.8X  cmd64 : %.16llX  il_pos : %d \n", kernel_rules[il_pos].cmds[0], kernel_rules[il_pos].cmds[0], il_pos);
  #if VECT_SIZE == 1

  buf0[0 ] = pw_buf0[0 ];
  buf0[1 ] = pw_buf0[1 ];
  buf0[2 ] = pw_buf0[2 ];
  buf0[3 ] = pw_buf0[3 ];
  buf0[4 ] = pw_buf0[4 ];
  buf0[5 ] = pw_buf0[5 ];
  buf0[6 ] = pw_buf0[6 ];
  buf0[7 ] = pw_buf0[7 ];
  buf0[8 ] = pw_buf0[8 ];
  buf0[9 ] = pw_buf0[9 ];
  buf0[10] = pw_buf0[10];
  buf0[11] = pw_buf0[11];
  buf0[12] = pw_buf0[12];
  buf0[13] = pw_buf0[13];
  buf0[14] = pw_buf0[14];
  buf0[15] = pw_buf0[15];
  

  return apply_rules_optimized_utf16le (kernel_rules[il_pos].cmds, buf0, pw_len);

  #else

  u32x out_len = 0;

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < VECT_SIZE; i++)
  {
    u32 tmp0[16];

    tmp0[0 ] = pw_buf0[0 ];
    tmp0[1 ] = pw_buf0[1 ];
    tmp0[2 ] = pw_buf0[2 ];
    tmp0[3 ] = pw_buf0[3 ];
    tmp0[4 ] = pw_buf0[4 ];
    tmp0[5 ] = pw_buf0[5 ];
    tmp0[6 ] = pw_buf0[6 ];
    tmp0[7 ] = pw_buf0[7 ];
    tmp0[8 ] = pw_buf0[8 ];
    tmp0[9 ] = pw_buf0[9 ];
    tmp0[10] = pw_buf0[10];
    tmp0[11] = pw_buf0[11];
    tmp0[12] = pw_buf0[12];
    tmp0[13] = pw_buf0[13];
    tmp0[14] = pw_buf0[14];
    tmp0[15] = pw_buf0[15];
    const u32 tmp_len = apply_rules_optimized_utf16le (kernel_rules[il_pos + i].cmds, tmp0, -spw_len);

    switch (i)
    {
      #if VECT_SIZE >= 2
      case 0:
        buf0[0 ].s0 = tmp0[0 ];
        buf0[1 ].s0 = tmp0[1 ];
        buf0[2 ].s0 = tmp0[2 ];
        buf0[3 ].s0 = tmp0[3 ];
        buf0[4 ].s0 = tmp0[4 ];
        buf0[5 ].s0 = tmp0[5 ];
        buf0[6 ].s0 = tmp0[6 ];
        buf0[7 ].s0 = tmp0[7 ];
        buf0[8 ].s0 = tmp0[8 ];
        buf0[9 ].s0 = tmp0[9 ];
        buf0[10].s0 = tmp0[10];
        buf0[11].s0 = tmp0[11];
        buf0[12].s0 = tmp0[12];
        buf0[13].s0 = tmp0[13];
        buf0[14].s0 = tmp0[14];
        buf0[15].s0 = tmp0[15];
        out_len.s0 = tmp_len;
        break;

      case 1:
        buf0[0 ].s1 = tmp0[0 ];
        buf0[1 ].s1 = tmp0[1 ];
        buf0[2 ].s1 = tmp0[2 ];
        buf0[3 ].s1 = tmp0[3 ];
        buf0[4 ].s1 = tmp0[4 ];
        buf0[5 ].s1 = tmp0[5 ];
        buf0[6 ].s1 = tmp0[6 ];
        buf0[7 ].s1 = tmp0[7 ];
        buf0[8 ].s1 = tmp0[8 ];
        buf0[9 ].s1 = tmp0[9 ];
        buf0[10].s1 = tmp0[10];
        buf0[11].s1 = tmp0[11];
        buf0[12].s1 = tmp0[12];
        buf0[13].s1 = tmp0[13];
        buf0[14].s1 = tmp0[14];
        buf0[15].s1 = tmp0[15];
        out_len.s1 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 4
      case 2:
        buf0[0 ].s2 = tmp0[0 ];
        buf0[1 ].s2 = tmp0[1 ];
        buf0[2 ].s2 = tmp0[2 ];
        buf0[3 ].s2 = tmp0[3 ];
        buf0[4 ].s2 = tmp0[4 ];
        buf0[5 ].s2 = tmp0[5 ];
        buf0[6 ].s2 = tmp0[6 ];
        buf0[7 ].s2 = tmp0[7 ];
        buf0[8 ].s2 = tmp0[8 ];
        buf0[9 ].s2 = tmp0[9 ];
        buf0[10].s2 = tmp0[10];
        buf0[11].s2 = tmp0[11];
        buf0[12].s2 = tmp0[12];
        buf0[13].s2 = tmp0[13];
        buf0[14].s2 = tmp0[14];
        buf0[15].s2 = tmp0[15];
        out_len.s2 = tmp_len;
        break;

      case 3:
        buf0[0 ].s3 = tmp0[0 ];
        buf0[1 ].s3 = tmp0[1 ];
        buf0[2 ].s3 = tmp0[2 ];
        buf0[3 ].s3 = tmp0[3 ];
        buf0[4 ].s3 = tmp0[4 ];
        buf0[5 ].s3 = tmp0[5 ];
        buf0[6 ].s3 = tmp0[6 ];
        buf0[7 ].s3 = tmp0[7 ];
        buf0[8 ].s3 = tmp0[8 ];
        buf0[9 ].s3 = tmp0[9 ];
        buf0[10].s3 = tmp0[10];
        buf0[11].s3 = tmp0[11];
        buf0[12].s3 = tmp0[12];
        buf0[13].s3 = tmp0[13];
        buf0[14].s3 = tmp0[14];
        buf0[15].s3 = tmp0[15];
        out_len.s3 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 8
      case 4:
        buf0[0 ].s4 = tmp0[0 ];
        buf0[1 ].s4 = tmp0[1 ];
        buf0[2 ].s4 = tmp0[2 ];
        buf0[3 ].s4 = tmp0[3 ];
        buf0[4 ].s4 = tmp0[4 ];
        buf0[5 ].s4 = tmp0[5 ];
        buf0[6 ].s4 = tmp0[6 ];
        buf0[7 ].s4 = tmp0[7 ];
        buf0[8 ].s4 = tmp0[8 ];
        buf0[9 ].s4 = tmp0[9 ];
        buf0[10].s4 = tmp0[10];
        buf0[11].s4 = tmp0[11];
        buf0[12].s4 = tmp0[12];
        buf0[13].s4 = tmp0[13];
        buf0[14].s4 = tmp0[14];
        buf0[15].s4 = tmp0[15];
        out_len.s4 = tmp_len;
        break;

      case 5:
        buf0[0 ].s5 = tmp0[0 ];
        buf0[1 ].s5 = tmp0[1 ];
        buf0[2 ].s5 = tmp0[2 ];
        buf0[3 ].s5 = tmp0[3 ];
        buf0[4 ].s5 = tmp0[4 ];
        buf0[5 ].s5 = tmp0[5 ];
        buf0[6 ].s5 = tmp0[6 ];
        buf0[7 ].s5 = tmp0[7 ];
        buf0[8 ].s5 = tmp0[8 ];
        buf0[9 ].s5 = tmp0[9 ];
        buf0[10].s5 = tmp0[10];
        buf0[11].s5 = tmp0[11];
        buf0[12].s5 = tmp0[12];
        buf0[13].s5 = tmp0[13];
        buf0[14].s5 = tmp0[14];
        buf0[15].s5 = tmp0[15];
        out_len.s5 = tmp_len;
        break;

      case 6:
        buf0[0 ].s6 = tmp0[0 ];
        buf0[1 ].s6 = tmp0[1 ];
        buf0[2 ].s6 = tmp0[2 ];
        buf0[3 ].s6 = tmp0[3 ];
        buf0[4 ].s6 = tmp0[4 ];
        buf0[5 ].s6 = tmp0[5 ];
        buf0[6 ].s6 = tmp0[6 ];
        buf0[7 ].s6 = tmp0[7 ];
        buf0[8 ].s6 = tmp0[8 ];
        buf0[9 ].s6 = tmp0[9 ];
        buf0[10].s6 = tmp0[10];
        buf0[11].s6 = tmp0[11];
        buf0[12].s6 = tmp0[12];
        buf0[13].s6 = tmp0[13];
        buf0[14].s6 = tmp0[14];
        buf0[15].s6 = tmp0[15];
        out_len.s6 = tmp_len;
        break;

      case 7:
        buf0[0 ].s7 = tmp0[0 ];
        buf0[1 ].s7 = tmp0[1 ];
        buf0[2 ].s7 = tmp0[2 ];
        buf0[3 ].s7 = tmp0[3 ];
        buf0[4 ].s7 = tmp0[4 ];
        buf0[5 ].s7 = tmp0[5 ];
        buf0[6 ].s7 = tmp0[6 ];
        buf0[7 ].s7 = tmp0[7 ];
        buf0[8 ].s7 = tmp0[8 ];
        buf0[9 ].s7 = tmp0[9 ];
        buf0[10].s7 = tmp0[10];
        buf0[11].s7 = tmp0[11];
        buf0[12].s7 = tmp0[12];
        buf0[13].s7 = tmp0[13];
        buf0[14].s7 = tmp0[14];
        buf0[15].s7 = tmp0[15];
        out_len.s7 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 16
      case 8:
        buf0[0 ].s8 = tmp0[0 ];
        buf0[1 ].s8 = tmp0[1 ];
        buf0[2 ].s8 = tmp0[2 ];
        buf0[3 ].s8 = tmp0[3 ];
        buf0[4 ].s8 = tmp0[4 ];
        buf0[5 ].s8 = tmp0[5 ];
        buf0[6 ].s8 = tmp0[6 ];
        buf0[7 ].s8 = tmp0[7 ];
        buf0[8 ].s8 = tmp0[8 ];
        buf0[9 ].s8 = tmp0[9 ];
        buf0[10].s8 = tmp0[10];
        buf0[11].s8 = tmp0[11];
        buf0[12].s8 = tmp0[12];
        buf0[13].s8 = tmp0[13];
        buf0[14].s8 = tmp0[14];
        buf0[15].s8 = tmp0[15];
        out_len.s8 = tmp_len;
        break;

      case 9:
        buf0[0 ].s9 = tmp0[0 ];
        buf0[1 ].s9 = tmp0[1 ];
        buf0[2 ].s9 = tmp0[2 ];
        buf0[3 ].s9 = tmp0[3 ];
        buf0[4 ].s9 = tmp0[4 ];
        buf0[5 ].s9 = tmp0[5 ];
        buf0[6 ].s9 = tmp0[6 ];
        buf0[7 ].s9 = tmp0[7 ];
        buf0[8 ].s9 = tmp0[8 ];
        buf0[9 ].s9 = tmp0[9 ];
        buf0[10].s9 = tmp0[10];
        buf0[11].s9 = tmp0[11];
        buf0[12].s9 = tmp0[12];
        buf0[13].s9 = tmp0[13];
        buf0[14].s9 = tmp0[14];
        buf0[15].s9 = tmp0[15];
        out_len.s9 = tmp_len;
        break;

      case 10:
        buf0[0 ].sa = tmp0[0 ];
        buf0[1 ].sa = tmp0[1 ];
        buf0[2 ].sa = tmp0[2 ];
        buf0[3 ].sa = tmp0[3 ];
        buf0[4 ].sa = tmp0[4 ];
        buf0[5 ].sa = tmp0[5 ];
        buf0[6 ].sa = tmp0[6 ];
        buf0[7 ].sa = tmp0[7 ];
        buf0[8 ].sa = tmp0[8 ];
        buf0[9 ].sa = tmp0[9 ];
        buf0[10].sa = tmp0[10];
        buf0[11].sa = tmp0[11];
        buf0[12].sa = tmp0[12];
        buf0[13].sa = tmp0[13];
        buf0[14].sa = tmp0[14];
        buf0[15].sa = tmp0[15];
        out_len.sa = tmp_len;
        break;

      case 11:
        buf0[0 ].sb = tmp0[0 ];
        buf0[1 ].sb = tmp0[1 ];
        buf0[2 ].sb = tmp0[2 ];
        buf0[3 ].sb = tmp0[3 ];
        buf0[4 ].sb = tmp0[4 ];
        buf0[5 ].sb = tmp0[5 ];
        buf0[6 ].sb = tmp0[6 ];
        buf0[7 ].sb = tmp0[7 ];
        buf0[8 ].sb = tmp0[8 ];
        buf0[9 ].sb = tmp0[9 ];
        buf0[10].sb = tmp0[10];
        buf0[11].sb = tmp0[11];
        buf0[12].sb = tmp0[12];
        buf0[13].sb = tmp0[13];
        buf0[14].sb = tmp0[14];
        buf0[15].sb = tmp0[15];
        out_len.sb = tmp_len;
        break;

      case 12:
        buf0[0 ].sc = tmp0[0 ];
        buf0[1 ].sc = tmp0[1 ];
        buf0[2 ].sc = tmp0[2 ];
        buf0[3 ].sc = tmp0[3 ];
        buf0[4 ].sc = tmp0[4 ];
        buf0[5 ].sc = tmp0[5 ];
        buf0[6 ].sc = tmp0[6 ];
        buf0[7 ].sc = tmp0[7 ];
        buf0[8 ].sc = tmp0[8 ];
        buf0[9 ].sc = tmp0[9 ];
        buf0[10].sc = tmp0[10];
        buf0[11].sc = tmp0[11];
        buf0[12].sc = tmp0[12];
        buf0[13].sc = tmp0[13];
        buf0[14].sc = tmp0[14];
        buf0[15].sc = tmp0[15];
        out_len.sc = tmp_len;
        break;

      case 13:
        buf0[0 ].sd = tmp0[0 ];
        buf0[1 ].sd = tmp0[1 ];
        buf0[2 ].sd = tmp0[2 ];
        buf0[3 ].sd = tmp0[3 ];
        buf0[4 ].sd = tmp0[4 ];
        buf0[5 ].sd = tmp0[5 ];
        buf0[6 ].sd = tmp0[6 ];
        buf0[7 ].sd = tmp0[7 ];
        buf0[8 ].sd = tmp0[8 ];
        buf0[9 ].sd = tmp0[9 ];
        buf0[10].sd = tmp0[10];
        buf0[11].sd = tmp0[11];
        buf0[12].sd = tmp0[12];
        buf0[13].sd = tmp0[13];
        buf0[14].sd = tmp0[14];
        buf0[15].sd = tmp0[15];
        out_len.sd = tmp_len;
        break;

      case 14:
        buf0[0 ].se = tmp0[0 ];
        buf0[1 ].se = tmp0[1 ];
        buf0[2 ].se = tmp0[2 ];
        buf0[3 ].se = tmp0[3 ];
        buf0[4 ].se = tmp0[4 ];
        buf0[5 ].se = tmp0[5 ];
        buf0[6 ].se = tmp0[6 ];
        buf0[7 ].se = tmp0[7 ];
        buf0[8 ].se = tmp0[8 ];
        buf0[9 ].se = tmp0[9 ];
        buf0[10].se = tmp0[10];
        buf0[11].se = tmp0[11];
        buf0[12].se = tmp0[12];
        buf0[13].se = tmp0[13];
        buf0[14].se = tmp0[14];
        buf0[15].se = tmp0[15];
        out_len.se = tmp_len;
        break;

      case 15:
        buf0[0 ].sf = tmp0[0 ];
        buf0[1 ].sf = tmp0[1 ];
        buf0[2 ].sf = tmp0[2 ];
        buf0[3 ].sf = tmp0[3 ];
        buf0[4 ].sf = tmp0[4 ];
        buf0[5 ].sf = tmp0[5 ];
        buf0[6 ].sf = tmp0[6 ];
        buf0[7 ].sf = tmp0[7 ];
        buf0[8 ].sf = tmp0[8 ];
        buf0[9 ].sf = tmp0[9 ];
        buf0[10].sf = tmp0[10];
        buf0[11].sf = tmp0[11];
        buf0[12].sf = tmp0[12];
        buf0[13].sf = tmp0[13];
        buf0[14].sf = tmp0[14];
        buf0[15].sf = tmp0[15];
        out_len.sf = tmp_len;
        break;
      #endif
    }
  }

  return out_len;

  #endif
}
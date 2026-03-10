/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

#include "inc_vendor.h"
#include "inc_types.h"
#include "inc_platform.h"
#include "inc_common.h"
#include "inc_rp_optimized_utf16le_v2.h"

#ifndef MAYBE_UNUSED
#define MAYBE_UNUSED
#endif

DECLSPEC u64 generate_cmask_optimized_utf16le_v2 (const u64 value) // OK - Perte de perf dans le lmask
{

  u64 rmask =  ((value & 0x0040004000400040u) >> 1u)
            & ~((value & 0x0080008000800080u) >> 2u);

  const u64 a = 0x0005000500050005u;
  const u64 c = 0x001f001f001f001fu;
  const u64 b = (value & c);
  u64 hmask,lmask;
  asm volatile ("addc.u64 %0, %1, %2;" : "=l"(hmask) : "l"(b), "l"(a));
  asm volatile ("addc.u64 %0, %1, %2;" : "=l"(lmask) : "l"(b), "l"(c));
  //printf("AV : hmask : %.16llx, lmask : %.16llx, value : %.16llx, b : %.16llx\n", hmask, lmask, value, b);
  asm volatile ("not.b64 %0, %1;" : "=l"(hmask) : "l"(hmask));
  asm volatile ("and.b64 %0, %1, %2;" : "=l"(rmask) : "l"(rmask), "l"(hmask));  
  asm volatile ("and.b64 %0, %1, %2;" : "=l"(rmask) : "l"(rmask), "l"(lmask));


  const u64 high  = ((value & 0xFFFF000000000000u)>0x00C0000000000000?0x0020000000000000u:0x0000000000000000u)
                  | ((value & 0x0000FFFF00000000u)>0x000000C000000000?0x0000002000000000u:0x0000000000000000u)
                  | ((value & 0x00000000FFFF0000u)>0x0000000000C00000?0x0000000000200000u:0x0000000000000000u)
                  | ((value & 0x000000000000FFFFu)>0x00000000000000C0?0x0000000000000020u:0x0000000000000000u);

  asm volatile ("or.b64 %0, %1, %2;" : "=l"(rmask) : "l"(rmask), "l"(high));

  return rmask;
}
DECLSPEC void generate_acmask_optimized_utf16le_v2 (PRIVATE_AS const u64 *buf0, PRIVATE_AS const u64 *buf1, PRIVATE_AS u64 *cmask) // OK - Perte de perf dans le lmask
{ 
  const u32 a  = 0x05050505u;
  const u32 c  = 0x1f1f1f1fu;
  const u32 l  = 0x20202020u;
  const u32 h  = 0x80808080u;

  u32 low[8],high[8];

  u32 tmpmask[8],nmask[8];
  u32 l1[8],l2[8],h1[8],h2[8];

  u32 tmph,tmpl,tmpop1,tmpop2,tmpand;

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 4; i++)
  {
    asm volatile ("mov.b64 {%0, %1}, %2;" : "=r"(tmpl), "=r"(tmph) : "l"(buf0[i]));
    asm volatile ("prmt.b32 %0, %1, %2, 0x6420;" : "=r"(low[i]) : "r"(tmpl), "r"(tmph));
    asm volatile ("prmt.b32 %0, %1, %2, 0x7531;" : "=r"(high[i]) : "r"(tmpl), "r"(tmph));
  }

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 4; i++)
  {
    asm volatile ("mov.b64 {%0, %1}, %2;" : "=r"(tmpl), "=r"(tmph) : "l"(buf1[i]));
    asm volatile ("prmt.b32 %0, %1, %2, 0x6420;" : "=r"(low[4+i]) : "r"(tmpl), "r"(tmph));
    asm volatile ("prmt.b32 %0, %1, %2, 0x7531;" : "=r"(high[4+i]) : "r"(tmpl), "r"(tmph));
  }
  
  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 8; i++)
  {
    l1[i] = low[i] >> 1u;
    l2[i] = low[i] >> 2u;
    h1[i] = high[i] << 4u; //0x04 -> 0x20
    h2[i] = high[i] << 5u; // 0x03 -> 0x20 
  }

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 8; i++)
  {
    asm volatile ("lop3.b32 %0, %1, %2, %3, 0x40;" : "=r"(tmpmask[i]): "r"(l1[i]) , "r"(l), "r"(l2[i]));  // tmp1[i] & l & ~tmp2[i]  : rmask ((value & 0x40404040u) >> 1u) & ~((value & 0x80808080u) >> 2u)
  }

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 8; i++)
  {
    asm volatile ("and.b32 %0, %1, %2;" : "=r"(tmpand): "r"(low[i]) , "r"(c));
    asm volatile ("addc.u32 %0, %1, %2;" : "=r"(tmpop2): "r"(tmpand) , "r"(c));
    asm volatile ("addc.u32 %0, %1, %2;" : "=r"(tmpop1): "r"(tmpand) , "r"(a));
    asm volatile ("and.b32 %0, %1, %2;" : "=r"(tmpand): "r"(l1[i]) , "r"(l2[i]));
    asm volatile ("lop3.b32 %0, %1, %2, %3, 0x40;" : "=r"(tmpmask[i]): "r"(tmpmask[i]),"r"(tmpop2) , "r"(tmpop1));  // tmp1[i] & l & ~tmp2[i]
    asm volatile ("lop3.b32 %0, %1, %2, %3, 0xF8;" : "=r"(tmpmask[i]): "r"(tmpmask[i]),"r"(tmpand) , "r"(l));

    asm volatile ("or.b32 %0, %1, %2;" : "=r"(tmpand): "r"(h1[i]) , "r"(h2[i]));
    asm volatile ("lop3.b32 %0, %1, %2, %3, 0xF8;" : "=r"(tmpmask[i]): "r"(tmpmask[i]),"r"(tmpand) , "r"(l));
  }

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 8; i++)
  {
    asm volatile ("prmt.b32 %0, %1, 0, 0x5150;" : "=r"(tmpl) : "r"(tmpmask[i]));
    asm volatile ("prmt.b32 %0, %1, 0, 0x5352;" : "=r"(tmph) : "r"(tmpmask[i]));
    asm volatile ("mov.b64 %0,  {%1, %2};" : "=l"(cmask[i]) : "r"(tmpl),  "r"(tmph));    
  }

}
DECLSPEC void truncate_right_optimized_utf16le_v2 (PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1, const u32 offset) // check OFFSET
{
  const u64 m = (1u << ((offset & 2u) * 8u)) - 1u;
  const int pos = offset / 4;

  u64 t[8];

  t[0] = (pos == 0)? m : (pos < 0)? 0xffffffffffffffffu : 0u ;
  t[1] = (pos == 1)? m : (pos < 1)? 0xffffffffffffffffu : 0u ;
  t[2] = (pos == 2)? m : (pos < 2)? 0xffffffffffffffffu : 0u ;
  t[3] = (pos == 3)? m : (pos < 3)? 0xffffffffffffffffu : 0u ;
  t[4] = (pos == 4)? m : (pos < 4)? 0xffffffffffffffffu : 0u ;
  t[5] = (pos == 5)? m : (pos < 5)? 0xffffffffffffffffu : 0u ;
  t[6] = (pos == 6)? m : (pos < 6)? 0xffffffffffffffffu : 0u ;
  t[7] = (pos == 7)? m : (pos < 7)? 0xffffffffffffffffu : 0u ;

  buf0[0] &= t[0];
  buf0[1] &= t[1];
  buf0[2] &= t[2];
  buf0[3] &= t[3];
  buf1[0] &= t[4];
  buf1[1] &= t[5];
  buf1[2] &= t[6];
  buf1[3] &= t[7];


/*
  switch (offset_switch)
  {
    case  0:  buf0[0] &= tmp;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              break;
    case  1:  buf0[1] &= tmp;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              break;
    case  2:  buf0[2] &= tmp;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              break;
    case  3:  buf0[3] &= tmp;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              break;
    case  4:  buf1[0] &= tmp;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              break;
    case  5:  buf1[1] &= tmp;
              buf1[2]  = 0;
              buf1[3]  = 0;
              break;
    case  6:  buf1[2] &= tmp;
              buf1[3]  = 0;
              break;
    case  7:  buf1[3] &= tmp;
              break;
  }*/
}
DECLSPEC void truncate_left_optimized_utf16le_v2 (PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1, const u32 offset) // check OFFSET
{
  const u64 m = ~((1u << ((offset & 2u) * 8u)) - 1u);
  const int pos = offset / 4;

  u64 t[8];

  t[0] = (pos == 0)? m : (pos > 0)? 0xffffffffffffffffu : 0u ;
  t[1] = (pos == 1)? m : (pos > 1)? 0xffffffffffffffffu : 0u ;
  t[2] = (pos == 2)? m : (pos > 2)? 0xffffffffffffffffu : 0u ;
  t[3] = (pos == 3)? m : (pos > 3)? 0xffffffffffffffffu : 0u ;
  t[4] = (pos == 4)? m : (pos > 4)? 0xffffffffffffffffu : 0u ;
  t[5] = (pos == 5)? m : (pos > 5)? 0xffffffffffffffffu : 0u ;
  t[6] = (pos == 6)? m : (pos > 6)? 0xffffffffffffffffu : 0u ;
  t[7] = (pos == 7)? m : (pos > 7)? 0xffffffffffffffffu : 0u ;

  buf0[0] &= t[0];
  buf0[1] &= t[1];
  buf0[2] &= t[2];
  buf0[3] &= t[3];
  buf1[0] &= t[4];
  buf1[1] &= t[5];
  buf1[2] &= t[6];
  buf1[3] &= t[7];

/*

  const u64 tmp = ~((1u << ((offset & 2u) * 8u)) - 1u);

  const int offset_switch = offset / 4;

  switch (offset_switch)
  {
    case  0:  buf0[0] &= tmp;
              break;
    case  1:  buf0[0]  = 0;
              buf0[1] &= tmp;
              break;
    case  2:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2] &= tmp;
              break;
    case  3:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3] &= tmp;
              break;
    case  4:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0] &= tmp;
              break;
    case  5:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1] &= tmp;
              break;
    case  6:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2] &= tmp;
              break;
    case  7:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3] &= tmp;
              break;
  }*/
}
DECLSPEC void lshift_block_optimized_utf16le_v2 (PRIVATE_AS const u64 *in0, PRIVATE_AS const u64 *in1, PRIVATE_AS u64 *out0, PRIVATE_AS u64 *out1) // TODO hc_bytealign_S64
{
  out0[0] = hc_bytealign_S64 (in0[0], in0[1], 3);
  out0[1] = hc_bytealign_S64 (in0[1], in0[2], 3);
  out0[2] = hc_bytealign_S64 (in0[2], in0[3], 3);
  out0[3] = hc_bytealign_S64 (in0[3], in1[0], 3);
  out1[0] = hc_bytealign_S64 (in1[0], in1[1], 3);
  out1[1] = hc_bytealign_S64 (in1[1], in1[2], 3);
  out1[2] = hc_bytealign_S64 (in1[2], in1[3], 3);
  out1[3] = hc_bytealign_S64 (in1[3],      0, 3);
}
DECLSPEC void rshift_block_optimized_utf16le_v2 (PRIVATE_AS const u64 *in0, PRIVATE_AS const u64 *in1, PRIVATE_AS u64 *out0, PRIVATE_AS u64 *out1) // TODO hc_bytealign_S64
{
  out1[3] = hc_bytealign_S64 (in1[2], in1[3], 1);
  out1[2] = hc_bytealign_S64 (in1[1], in1[2], 1);
  out1[1] = hc_bytealign_S64 (in1[0], in1[1], 1);
  out1[0] = hc_bytealign_S64 (in0[3], in1[0], 1);
  out0[3] = hc_bytealign_S64 (in0[2], in0[3], 1);
  out0[2] = hc_bytealign_S64 (in0[1], in0[2], 1);
  out0[1] = hc_bytealign_S64 (in0[0], in0[1], 1);
  out0[0] = hc_bytealign_S64 (     0, in0[0], 1);
}
DECLSPEC void lshift_block_optimized_N_utf16le_v2 (PRIVATE_AS const u64 *in0, PRIVATE_AS const u64 *in1, PRIVATE_AS u64 *out0, PRIVATE_AS u64 *out1, const u32 num) // TODO hc_bytealign_S64
{
  switch (num)
  {
    case  0:  out0[0] = in0[0];
              out0[1] = in0[1];
              out0[2] = in0[2];
              out0[3] = in0[3];
              out1[0] = in1[0];
              out1[1] = in1[1];
              out1[2] = in1[2];
              out1[3] = in1[3];
              break;
    case  1:  out0[0] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out0[1] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out0[2] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out0[3] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out1[0] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out1[1] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out1[2] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out1[3] = hc_bytealign_S64 (in1[3],      0, 3);
              break;
    case  2:  out0[0] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out0[1] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out0[2] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out0[3] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out1[0] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out1[1] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out1[2] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out1[3] = hc_bytealign_S64 (in1[3],      0, 2);
              break;
    case  3:  out0[0] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out0[1] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out0[2] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out0[3] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out1[0] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out1[1] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out1[2] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out1[3] = hc_bytealign_S64 (in1[3],      0, 1);
              break;
    case  4:  out0[0] = in0[1];
              out0[1] = in0[2];
              out0[2] = in0[3];
              out0[3] = in1[0];
              out1[0] = in1[1];
              out1[1] = in1[2];
              out1[2] = in1[3];
              out1[3] = 0;
              break;
    case  5:  out0[0] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out0[1] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out0[2] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out0[3] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out1[0] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out1[1] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out1[2] = hc_bytealign_S64 (in1[3],      0, 3);
              out1[3] = 0;
              break;
    case  6:  out0[0] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out0[1] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out0[2] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out0[3] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out1[0] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out1[1] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out1[2] = hc_bytealign_S64 (in1[3],      0, 2);
              out1[3] = 0;
              break;
    case  7:  out0[0] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out0[1] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out0[2] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out0[3] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out1[0] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out1[1] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out1[2] = hc_bytealign_S64 (in1[3],      0, 1);
              out1[3] = 0;
              break;
    case  8:  out0[0] = in0[2];
              out0[1] = in0[3];
              out0[2] = in1[0];
              out0[3] = in1[1];
              out1[0] = in1[2];
              out1[1] = in1[3];
              out1[2] = 0;
              out1[3] = 0;
              break;
    case  9:  out0[0] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out0[1] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out0[2] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out0[3] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out1[0] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out1[1] = hc_bytealign_S64 (in1[3],      0, 3);
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 10:  out0[0] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out0[1] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out0[2] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out0[3] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out1[0] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out1[1] = hc_bytealign_S64 (in1[3],      0, 2);
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 11:  out0[0] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out0[1] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out0[2] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out0[3] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out1[0] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out1[1] = hc_bytealign_S64 (in1[3],      0, 1);
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 12:  out0[0] = in0[3];
              out0[1] = in1[0];
              out0[2] = in1[1];
              out0[3] = in1[2];
              out1[0] = in1[3];
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 13:  out0[0] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out0[1] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out0[2] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out0[3] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out1[0] = hc_bytealign_S64 (in1[3],      0, 3);
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 14:  out0[0] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out0[1] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out0[2] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out0[3] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out1[0] = hc_bytealign_S64 (in1[3],      0, 2);
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 15:  out0[0] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out0[1] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out0[2] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out0[3] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out1[0] = hc_bytealign_S64 (in1[3],      0, 1);
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 16:  out0[0] = in1[0];
              out0[1] = in1[1];
              out0[2] = in1[2];
              out0[3] = in1[3];
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 17:  out0[0] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out0[1] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out0[2] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out0[3] = hc_bytealign_S64 (in1[3],      0, 3);
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 18:  out0[0] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out0[1] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out0[2] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out0[3] = hc_bytealign_S64 (in1[3],      0, 2);
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 19:  out0[0] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out0[1] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out0[2] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out0[3] = hc_bytealign_S64 (in1[3],      0, 1);
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 20:  out0[0] = in1[1];
              out0[1] = in1[2];
              out0[2] = in1[3];
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 21:  out0[0] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out0[1] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out0[2] = hc_bytealign_S64 (in1[3],      0, 3);
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 22:  out0[0] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out0[1] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out0[2] = hc_bytealign_S64 (in1[3],      0, 2);
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 23:  out0[0] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out0[1] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out0[2] = hc_bytealign_S64 (in1[3],      0, 1);
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 24:  out0[0] = in1[2];
              out0[1] = in1[3];
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 25:  out0[0] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out0[1] = hc_bytealign_S64 (in1[3],      0, 3);
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 26:  out0[0] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out0[1] = hc_bytealign_S64 (in1[3],      0, 2);
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 27:  out0[0] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out0[1] = hc_bytealign_S64 (in1[3],      0, 1);
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 28:  out0[0] = in1[3];
              out0[1] = 0;
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 29:  out0[0] = hc_bytealign_S64 (in1[3],      0, 3);
              out0[1] = 0;
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 30:  out0[0] = hc_bytealign_S64 (in1[3],      0, 2);
              out0[1] = 0;
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
    case 31:  out0[0] = hc_bytealign_S64 (in1[3],      0, 1);
              out0[1] = 0;
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              break;
  }
}
DECLSPEC void rshift_block_optimized_N_utf16le_v2 (PRIVATE_AS const u64 *in0, PRIVATE_AS const u64 *in1, PRIVATE_AS u64 *out0, PRIVATE_AS u64 *out1, const u32 num) // OK
{
  switch (num/2)
  {
    case  0:  out1[3] = in1[3];
              out1[2] = in1[2];
              out1[1] = in1[1];
              out1[0] = in1[0];
              out0[3] = in0[3];
              out0[2] = in0[2];
              out0[1] = in0[1];
              out0[0] = in0[0];
              break;
    case  1:  out1[3] = hc_bytealign_S64 (in1[2], in1[3], 1);
              out1[2] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out1[1] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out1[0] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out0[3] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out0[2] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out0[1] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out0[0] = hc_bytealign_S64 (     0, in0[0], 1);
              break;
    case  2:  out1[3] = hc_bytealign_S64 (in1[2], in1[3], 2);
              out1[2] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out1[1] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out1[0] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out0[3] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out0[2] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out0[1] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out0[0] = hc_bytealign_S64 (     0, in0[0], 2);
              break;
    case  3:  out1[3] = hc_bytealign_S64 (in1[2], in1[3], 3);
              out1[2] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out1[1] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out1[0] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out0[3] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out0[2] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out0[1] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out0[0] = hc_bytealign_S64 (     0, in0[0], 3);
              break;
    case  4:  out1[3] = in1[2];
              out1[2] = in1[1];
              out1[1] = in1[0];
              out1[0] = in0[3];
              out0[3] = in0[2];
              out0[2] = in0[1];
              out0[1] = in0[0];
              out0[0] = 0;
              break;
    case  5:  out1[3] = hc_bytealign_S64 (in1[1], in1[2], 1);
              out1[2] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out1[1] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out1[0] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out0[3] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out0[2] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out0[1] = hc_bytealign_S64 (     0, in0[0], 1);
              out0[0] = 0;
              break;
    case  6:  out1[3] = hc_bytealign_S64 (in1[1], in1[2], 2);
              out1[2] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out1[1] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out1[0] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out0[3] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out0[2] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out0[1] = hc_bytealign_S64 (     0, in0[0], 2);
              out0[0] = 0;
              break;
    case  7:  out1[3] = hc_bytealign_S64 (in1[1], in1[2], 3);
              out1[2] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out1[1] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out1[0] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out0[3] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out0[2] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out0[1] = hc_bytealign_S64 (     0, in0[0], 3);
              out0[0] = 0;
              break;
    case  8:  out1[3] = in1[1];
              out1[2] = in1[0];
              out1[1] = in0[3];
              out1[0] = in0[2];
              out0[3] = in0[1];
              out0[2] = in0[0];
              out0[1] = 0;
              out0[0] = 0;
              break;
    case  9:  out1[3] = hc_bytealign_S64 (in1[0], in1[1], 1);
              out1[2] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out1[1] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out1[0] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out0[3] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out0[2] = hc_bytealign_S64 (     0, in0[0], 1);
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 10:  out1[3] = hc_bytealign_S64 (in1[0], in1[1], 2);
              out1[2] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out1[1] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out1[0] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out0[3] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out0[2] = hc_bytealign_S64 (     0, in0[0], 2);
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 11:  out1[3] = hc_bytealign_S64 (in1[0], in1[1], 3);
              out1[2] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out1[1] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out1[0] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out0[3] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out0[2] = hc_bytealign_S64 (     0, in0[0], 3);
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 12:  out1[3] = in1[0];
              out1[2] = in0[3];
              out1[1] = in0[2];
              out1[0] = in0[1];
              out0[3] = in0[0];
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 13:  out1[3] = hc_bytealign_S64 (in0[3], in1[0], 1);
              out1[2] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out1[1] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out1[0] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out0[3] = hc_bytealign_S64 (     0, in0[0], 1);
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 14:  out1[3] = hc_bytealign_S64 (in0[3], in1[0], 2);
              out1[2] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out1[1] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out1[0] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out0[3] = hc_bytealign_S64 (     0, in0[0], 2);
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 15:  out1[3] = hc_bytealign_S64 (in0[3], in1[0], 3);
              out1[2] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out1[1] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out1[0] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out0[3] = hc_bytealign_S64 (     0, in0[0], 3);
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 16:  out1[3] = in0[3];
              out1[2] = in0[2];
              out1[1] = in0[1];
              out1[0] = in0[0];
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 17:  out1[3] = hc_bytealign_S64 (in0[2], in0[3], 1);
              out1[2] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out1[1] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out1[0] = hc_bytealign_S64 (     0, in0[0], 1);
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 18:  out1[3] = hc_bytealign_S64 (in0[2], in0[3], 2);
              out1[2] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out1[1] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out1[0] = hc_bytealign_S64 (     0, in0[0], 2);
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 19:  out1[3] = hc_bytealign_S64 (in0[2], in0[3], 3);
              out1[2] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out1[1] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out1[0] = hc_bytealign_S64 (     0, in0[0], 3);
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 20:  out1[3] = in0[2];
              out1[2] = in0[1];
              out1[1] = in0[0];
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 21:  out1[3] = hc_bytealign_S64 (in0[1], in0[2], 1);
              out1[2] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out1[1] = hc_bytealign_S64 (     0, in0[0], 1);
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 22:  out1[3] = hc_bytealign_S64 (in0[1], in0[2], 2);
              out1[2] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out1[1] = hc_bytealign_S64 (     0, in0[0], 2);
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 23:  out1[3] = hc_bytealign_S64 (in0[1], in0[2], 3);
              out1[2] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out1[1] = hc_bytealign_S64 (     0, in0[0], 3);
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 24:  out1[3] = in0[1];
              out1[2] = in0[0];
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 25:  out1[3] = hc_bytealign_S64 (in0[0], in0[1], 1);
              out1[2] = hc_bytealign_S64 (     0, in0[0], 1);
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 26:  out1[3] = hc_bytealign_S64 (in0[0], in0[1], 2);
              out1[2] = hc_bytealign_S64 (     0, in0[0], 2);
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 27:  out1[3] = hc_bytealign_S64 (in0[0], in0[1], 3);
              out1[2] = hc_bytealign_S64 (     0, in0[0], 3);
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 28:  out1[3] = in0[0];
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 29:  out1[3] = hc_bytealign_S64 (     0, in0[0], 1);
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 30:  out1[3] = hc_bytealign_S64 (     0, in0[0], 2);
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 31:  out1[3] = hc_bytealign_S64 (     0, in0[0], 3);
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  }
}
DECLSPEC void append_block1_optimized_utf16le_v2 (const u32 offset, PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1, const u64 src_r0) // TODO set_mark &  append_helper
{
  // this version works with 2 bytes append only
  const u64 value = src_r0 & 0xffff;

  const u64 tmp = value <<  0
                | value <<  16
                | value <<  32
                | value <<  64;

  u64 v[4];

  set_mark_1x4_S_64 (v, offset); 

  const u32 offset8 = offset / 16;
  append_helper_1x4_S64 (buf0, ((offset8 == 0) ? tmp : 0), v);   
  append_helper_1x4_S64 (buf1, ((offset8 == 1) ? tmp : 0), v);
}


DECLSPEC void append_block8_optimized_utf16le_v2 (const u32 offset, PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1 PRIVATE_AS, const u64 *src_l0, PRIVATE_AS const u64 *src_l1, PRIVATE_AS const u64 *src_r0, PRIVATE_AS const u64 *src_r1)  // TODO hc_bytealign_S64
{
  u64 s0 = 0;
  u64 s1 = 0;
  u64 s2 = 0;
  u64 s3 = 0;
  u64 s4 = 0;
  u64 s5 = 0;
  u64 s6 = 0;
  u64 s7 = 0;

  const int offset_switch = offset / 4;

  const u64 src_r00 = src_r0[0];
  const u64 src_r01 = src_r0[1];
  const u64 src_r02 = src_r0[2];
  const u64 src_r03 = src_r0[3];
  const u64 src_r10 = src_r1[0];
  const u64 src_r11 = src_r1[1];
  const u64 src_r12 = src_r1[2];
  const u64 src_r13 = src_r1[3];

  switch (offset_switch)
  {
    case 0:
      s7 = hc_bytealign_S64 (src_r12, src_r13, offset);
      s6 = hc_bytealign_S64 (src_r11, src_r12, offset);
      s5 = hc_bytealign_S64 (src_r10, src_r11, offset);
      s4 = hc_bytealign_S64 (src_r03, src_r10, offset);
      s3 = hc_bytealign_S64 (src_r02, src_r03, offset);
      s2 = hc_bytealign_S64 (src_r01, src_r02, offset);
      s1 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s0 = hc_bytealign_S64 (      0, src_r00, offset);
      break;

    case 1:
      s7 = hc_bytealign_S64 (src_r11, src_r12, offset);
      s6 = hc_bytealign_S64 (src_r10, src_r11, offset);
      s5 = hc_bytealign_S64 (src_r03, src_r10, offset);
      s4 = hc_bytealign_S64 (src_r02, src_r03, offset);
      s3 = hc_bytealign_S64 (src_r01, src_r02, offset);
      s2 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s1 = hc_bytealign_S64 (      0, src_r00, offset);
      s0 = 0;
      break;

    case 2:
      s7 = hc_bytealign_S64 (src_r10, src_r11, offset);
      s6 = hc_bytealign_S64 (src_r03, src_r10, offset);
      s5 = hc_bytealign_S64 (src_r02, src_r03, offset);
      s4 = hc_bytealign_S64 (src_r01, src_r02, offset);
      s3 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s2 = hc_bytealign_S64 (      0, src_r00, offset);
      s1 = 0;
      s0 = 0;
      break;

    case 3:
      s7 = hc_bytealign_S64 (src_r03, src_r10, offset);
      s6 = hc_bytealign_S64 (src_r02, src_r03, offset);
      s5 = hc_bytealign_S64 (src_r01, src_r02, offset);
      s4 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s3 = hc_bytealign_S64 (      0, src_r00, offset);
      s2 = 0;
      s1 = 0;
      s0 = 0;

      break;

    case 4:
      s7 = hc_bytealign_S64 (src_r02, src_r03, offset);
      s6 = hc_bytealign_S64 (src_r01, src_r02, offset);
      s5 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s4 = hc_bytealign_S64 (      0, src_r00, offset);
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 5:
      s7 = hc_bytealign_S64 (src_r01, src_r02, offset);
      s6 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s5 = hc_bytealign_S64 (      0, src_r00, offset);
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 6:
      s7 = hc_bytealign_S64 (src_r00, src_r01, offset);
      s6 = hc_bytealign_S64 (      0, src_r00, offset);
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 7:
      s7 = hc_bytealign_S64 (      0, src_r00, offset);
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;
  }

  buf0[0] = src_l0[0] | s0;
  buf0[1] = src_l0[1] | s1;
  buf0[2] = src_l0[2] | s2;
  buf0[3] = src_l0[3] | s3;
  buf1[0] = src_l1[0] | s4;
  buf1[1] = src_l1[1] | s5;
  buf1[2] = src_l1[2] | s6;
  buf1[3] = src_l1[3] | s7;
}

DECLSPEC void reverse_block_optimized_utf16le_v2 (PRIVATE_AS u64 *in0, PRIVATE_AS u64 *in1, PRIVATE_AS u64 *out0, PRIVATE_AS u64 *out1, const u32 len) // TODO
{
  rshift_block_optimized_N_utf16le_v2 (in0, in1, out0, out1, 64 - len);

  u64 tib40[4];
  u64 tib41[4];

  tib40[0] = out1[3];
  tib40[1] = out1[2];
  tib40[2] = out1[1];
  tib40[3] = out1[0];
  tib41[0] = out0[3];
  tib41[1] = out0[2];
  tib41[2] = out0[1];
  tib41[3] = out0[0];

  out0[0] = hc_swap64_S2 (tib40[0]);
  out0[1] = hc_swap64_S2 (tib40[1]);
  out0[2] = hc_swap64_S2 (tib40[2]);
  out0[3] = hc_swap64_S2 (tib40[3]);
  out1[0] = hc_swap64_S2 (tib41[0]);
  out1[1] = hc_swap64_S2 (tib41[1]);
  out1[2] = hc_swap64_S2 (tib41[2]);
  out1[3] = hc_swap64_S2 (tib41[3]); 
 
}

DECLSPEC void exchange_byte_optimized_utf16le_v2 (PRIVATE_AS u64 *buf, const int off_src, const int off_dst) // OK - TO check
{
  PRIVATE_AS u16 *ptr = (PRIVATE_AS u16 *) buf; 

  const u16 tmp = ptr[off_src];

  ptr[off_src] = ptr[off_dst];
  ptr[off_dst] = tmp;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  u64 mask[8] = { 0 };

  generate_acmask_optimized_utf16le_v2(buf0,buf1,mask);

  buf0[0] |= mask[0];
  buf0[1] |= mask[1];
  buf0[2] |= mask[2];
  buf0[3] |= mask[3];
  buf1[0] |= mask[4];
  buf1[1] |= mask[5];
  buf1[2] |= mask[6];
  buf1[3] |= mask[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  u64 mask[8];
  generate_acmask_optimized_utf16le_v2(buf0,buf1,mask);

  buf0[0] &= ~mask[0];
  buf0[1] &= ~mask[1];
  buf0[2] &= ~mask[2];
  buf0[3] &= ~mask[3];
  buf1[0] &= ~mask[4];
  buf1[1] &= ~mask[5];
  buf1[2] &= ~mask[6];
  buf1[3] &= ~mask[7];

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_ufirst_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  u64 mask[8];
  generate_acmask_optimized_utf16le_v2(buf0,buf1,mask);

  buf0[0] |= mask[0];
  buf0[1] |= mask[1];
  buf0[2] |= mask[2];
  buf0[3] |= mask[3];
  buf1[0] |= mask[4];
  buf1[1] |= mask[5];
  buf1[2] |= mask[6];
  buf1[3] |= mask[7];

  buf0[0] &= ~(0x0000000000000020u & mask[0]);

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_lfirst_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  u64 mask[8];
  
  generate_acmask_optimized_utf16le_v2(buf0,buf1,mask);

  buf0[0] &= ~mask[0];
  buf0[1] &= ~mask[1];
  buf0[2] &= ~mask[2];
  buf0[3] &= ~mask[3];
  buf1[0] &= ~mask[4];
  buf1[1] &= ~mask[5];
  buf1[2] &= ~mask[6];
  buf1[3] &= ~mask[7];

  buf0[0] |= 0x0000000000000020 & mask[0];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_trest_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  u64 mask[8];
  generate_acmask_optimized_utf16le_v2(buf0,buf1,mask);

  buf0[0] ^= mask[0];
  buf0[1] ^= mask[1];
  buf0[2] ^= mask[2];
  buf0[3] ^= mask[3];
  buf1[0] ^= mask[4];
  buf1[1] ^= mask[5];
  buf1[2] ^= mask[6];
  buf1[3] ^= mask[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_shift_case_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO 
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK
{
  if (p0 >= in_len) return in_len;

  u64 t[8], mask[8] = { 0 };
  u32 pos = p0 / 4;

  const u64 m = 0x0020u << (((u64)p0 & 3u) * 16u);

  generate_acmask_optimized_utf16le_v2(buf0,buf1,mask);

  t[0] = (pos == 0)? m : 0u;
  t[1] = (pos == 1)? m : 0u;
  t[2] = (pos == 2)? m : 0u;
  t[3] = (pos == 3)? m : 0u;
  t[4] = (pos == 4)? m : 0u;
  t[5] = (pos == 5)? m : 0u;
  t[6] = (pos == 6)? m : 0u;
  t[7] = (pos == 7)? m : 0u;


  //const u64 tmp = t[p0 / 8];
  //t[p0 / 8] = tmp ^ (m & generate_cmask_optimized_utf16le_v2(tmp));

  buf0[0] ^= t[0] & mask[0];
  buf0[1] ^= t[1] & mask[1];
  buf0[2] ^= t[2] & mask[2];
  buf0[3] ^= t[3] & mask[3];
  buf1[0] ^= t[4] & mask[4];
  buf1[1] ^= t[5] & mask[5];
  buf1[2] ^= t[6] & mask[6];
  buf1[3] ^= t[7] & mask[7];

  return (in_len);
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_sep_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO
{
  if (in_len == 0) return in_len;

  u64 mask[8] = { 0 }, cmask[8] = { 0 };
  u32 n[8];
  generate_acmask_optimized_utf16le_v2(buf0,buf1,cmask);

  search_on_array_sep_utf16le_v2 (p0, p1, buf0, buf1, mask);  // > 10 Gh/s
  rshift_block_optimized_utf16le_v2 (mask, mask+4, mask, mask+4);   // -1 Gh/s

  
  buf0[0] ^= mask[0] & cmask[0];
  buf0[1] ^= mask[1] & cmask[1];
  buf0[2] ^= mask[2] & cmask[2];
  buf0[3] ^= mask[3] & cmask[3];
  buf1[0] ^= mask[4] & cmask[4];
  buf1[1] ^= mask[5] & cmask[5];
  buf1[2] ^= mask[6] & cmask[6];
  buf1[3] ^= mask[7] & cmask[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reverse_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  reverse_block_optimized_utf16le_v2 (buf0, buf1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;
  append_block8_optimized_utf16le_v2 (out_len/2, buf0, buf1, buf0, buf1, buf0, buf1);

  out_len += in_len;
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_times_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  u32 p0_2 = p0/2u;

  if (((in_len * p0_2) + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u64 tib40[4];
  u64 tib41[4];

  tib40[0] = buf0[0];
  tib40[1] = buf0[1];
  tib40[2] = buf0[2];
  tib40[3] = buf0[3];
  tib41[0] = buf1[0];
  tib41[1] = buf1[1];
  tib41[2] = buf1[2];
  tib41[3] = buf1[3];

  for (u32 i = 0; i < p0_2; i++)
  {
    append_block8_optimized_utf16le_v2 (out_len, buf0, buf1, buf0, buf1, tib40, tib41);

    out_len += in_len;
  }

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reflect_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u64 tib40[4] = { 0 };
  u64 tib41[4] = { 0 };

  reverse_block_optimized_utf16le_v2 (buf0, buf1, tib40, tib41, out_len);

  append_block8_optimized_utf16le_v2 (out_len, buf0, buf1, buf0, buf1, tib40, tib41);

  out_len += in_len;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_to_hex_lower_utf16le_v2  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_to_hex_upper_utf16le_v2  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_append_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if ((in_len + 2) >= 64) return in_len;

  u32 out_len = in_len;

  append_block1_optimized_utf16le_v2 (out_len, buf0, buf1, p0);

  out_len += 2;

  return out_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_prepend_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if ((in_len + 2) >= 32) return in_len;

  u32 out_len = in_len;

  rshift_block_optimized_utf16le_v2 (buf0, buf1, buf0, buf1);

  buf0[0] = buf0[0] | p0;

  out_len += 2;

  return out_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_left_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u64 tmp = buf0[0];

  lshift_block_optimized_utf16le_v2 (buf0, buf1, buf0, buf1);

  append_block1_optimized_utf16le_v2 (in_len1, buf0, buf1,tmp);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_right_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO set_mark
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 sh = (in_len1 & 2) * 8;

  u64 tmp = 0;

  u64 v[4];

  set_mark_1x4_S_64 (v, in_len1);
  switch (in_len1 / 16)
  {
    case 0:
      tmp |= buf0[0] & v[0];
      tmp |= buf0[1] & v[1];
      tmp |= buf0[2] & v[2];
      tmp |= buf0[3] & v[3];
      break;

    case 1:
      tmp |= buf1[0] & v[0];
      tmp |= buf1[1] & v[1];
      tmp |= buf1[2] & v[2];
      tmp |= buf1[3] & v[3];
      break;
  }

  tmp = (tmp >> sh) & 0xffff;

  rshift_block_optimized_utf16le_v2 (buf0, buf1,buf0, buf1);

  buf0[0] |= tmp;

  truncate_right_optimized_utf16le_v2 (buf0, buf1, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_first_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  lshift_block_optimized_utf16le_v2 (buf0, buf1, buf0, buf1);

  return in_len1;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_last_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u64 mask = (1 << ((in_len1 & 2) * 8)) - 1;
  buf0[0] &=                      (in_len1 <  8)  ? mask : 0xffffffffffffffffu;
  buf0[1] &= ((in_len1 >=  8) &&  (in_len1 < 16)) ? mask : 0xffffffffffffffffu;
  buf0[2] &= ((in_len1 >=  16) && (in_len1 < 24)) ? mask : 0xffffffffffffffffu;
  buf0[3] &= ((in_len1 >=  24) && (in_len1 < 32)) ? mask : 0xffffffffffffffffu;
  buf1[0] &= ((in_len1 >=  32) && (in_len1 < 40)) ? mask : 0xffffffffffffffffu;
  buf1[1] &= ((in_len1 >=  40) && (in_len1 < 48)) ? mask : 0xffffffffffffffffu;
  buf1[2] &= ((in_len1 >=  48) && (in_len1 < 56)) ? mask : 0xffffffffffffffffu;
  buf1[3] &=  (in_len1 >=  56)                    ? mask : 0xffffffffffffffffu;

  return in_len1;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_at_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO
{
  if (p0 >= in_len) return in_len;

  u32 out_len = in_len;

  const u64 m = (1u << ((p0 & 2u) * 8u)) - 1u;
  const u32 pos = p0 / 4u;

  u64 tib40[4];
  u64 tib41[4];

  lshift_block_optimized_utf16le_v2 (buf0, buf1, tib40, tib41);

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  buf0[0] = (t[0] & buf0[0]) | (~t[0] & tib40[0]) ;
  buf0[1] = (t[1] & buf0[1]) | (~t[1] & tib40[1]) ;
  buf0[2] = (t[2] & buf0[2]) | (~t[2] & tib40[2]) ;
  buf0[3] = (t[3] & buf0[3]) | (~t[3] & tib40[3]) ;
  buf1[0] = (t[4] & buf1[0]) | (~t[4] & tib41[0]) ;
  buf1[1] = (t[5] & buf1[1]) | (~t[5] & tib41[1]) ;
  buf1[2] = (t[6] & buf1[2]) | (~t[6] & tib41[2]) ;
  buf1[3] = (t[7] & buf1[3]) | (~t[7] & tib41[3]) ;
  
/*

  const int p0_switch = p0 / 4;

  switch (p0_switch)
  {
    case  0:  buf0[0] =  (buf0[0] & ml)
                      | (tib40[0] & mr);
              buf0[1] =  tib40[1];
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  1:  buf0[1] =  (buf0[1] & ml)
                      | (tib40[1] & mr);
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  2:  buf0[2] =  (buf0[2] & ml)
                      | (tib40[2] & mr);
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  3:  buf0[3] =  (buf0[3] & ml)
                      | (tib40[3] & mr);
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  4:  buf1[0] =  (buf1[0] & ml)
                      | (tib41[0] & mr);
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  5:  buf1[1] =  (buf1[1] & ml)
                      | (tib41[1] & mr);
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  6:  buf1[2] =  (buf1[2] & ml)
                      | (tib41[2] & mr);
              buf1[3] =  tib41[3];
              break;
    case  7:  buf1[3] =  (buf1[3] & ml)
                      | (tib41[3] & mr);
              break;
  }*/

  out_len -= 2;
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_extract_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (p0 >= in_len) return in_len;

  if ((p0 + p1) > in_len) return in_len;

  u32 out_len = p1;
  lshift_block_optimized_N_utf16le_v2 (buf0, buf1, buf0, buf1, p0);  
  truncate_right_optimized_utf16le_v2 (buf0, buf1, out_len);
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_omit_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO
{
  if (p0 >= in_len) return in_len;

  if ((p0 + p1) > in_len) return in_len;

  u32 out_len = in_len;

  u64 tib40[4];
  u64 tib41[4];

  lshift_block_optimized_N_utf16le_v2 (buf0, buf1, tib40, tib41, p1);

  const u64 ml = (1 << ((p0 & 2u) * 8u)) - 1;
  const u64 mr = ~ml;

  const int pos = p0 / 4;

  u64 t[8];

  t[0] = (pos == 0)? ml : (pos < 0)? 0xffffffffffffffffu : 0u;
  t[1] = (pos == 1)? ml : (pos < 1)? 0xffffffffffffffffu : 0u;
  t[2] = (pos == 2)? ml : (pos < 2)? 0xffffffffffffffffu : 0u;
  t[3] = (pos == 3)? ml : (pos < 3)? 0xffffffffffffffffu : 0u;
  t[4] = (pos == 4)? ml : (pos < 4)? 0xffffffffffffffffu : 0u;
  t[5] = (pos == 5)? ml : (pos < 5)? 0xffffffffffffffffu : 0u;
  t[6] = (pos == 6)? ml : (pos < 6)? 0xffffffffffffffffu : 0u;
  t[7] = (pos == 7)? ml : (pos < 7)? 0xffffffffffffffffu : 0u;

  buf0[0] =  ( buf0[0] & t[0] ) | ( tib40[0] & ~t[0] );
  buf0[1] =  ( buf0[1] & t[1] ) | ( tib40[1] & ~t[1] );
  buf0[2] =  ( buf0[2] & t[2] ) | ( tib40[2] & ~t[2] );
  buf0[3] =  ( buf0[3] & t[3] ) | ( tib40[3] & ~t[3] );
  buf1[0] =  ( buf1[0] & t[4] ) | ( tib41[0] & ~t[4] );
  buf1[1] =  ( buf1[1] & t[5] ) | ( tib41[1] & ~t[5] );
  buf1[2] =  ( buf1[2] & t[6] ) | ( tib41[2] & ~t[6] );
  buf1[3] =  ( buf1[3] & t[7] ) | ( tib41[3] & ~t[7] );
  
/*
  switch (pos)
  {
    case  0:  buf0[0] =  (buf0[0] & ml)
                      | (tib40[0] & mr);
              buf0[1] =  tib40[1];
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  1:  buf0[1] =  (buf0[1] & ml)
                      | (tib40[1] & mr);
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  2:  buf0[2] =  (buf0[2] & ml)
                      | (tib40[2] & mr);
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  3:  buf0[3] =  (buf0[3] & ml)
                      | (tib40[3] & mr);
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  4:  buf1[0] =  (buf1[0] & ml)
                      | (tib41[0] & mr);
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  5:  buf1[1] =  (buf1[1] & ml)
                      | (tib41[1] & mr);
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  6:  buf1[2] =  (buf1[2] & ml)
                      | (tib41[2] & mr);
              buf1[3] =  tib41[3];
              break;
    case  7:  buf1[3] =  (buf1[3] & ml)
                      | (tib41[3] & mr);
              break;
  }
*/
  out_len -= p1;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_every_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO
{
  if (p0 > in_len) return in_len;

  if ((in_len + 2) >= 64) return in_len;

  const u64 p1n = (u64)p1 << ((p0 & 3u) * 16u);
  const u32 pos = p0 / 4u;

  //const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));
  
  const u64 ml = (1 << ((p0 & 2) * 8)) - 1;
  const u64 mr = 0xffff0000 << ((p0 & 2) * 8);

  u64 tl[8],tr[8];

  tl[0] = (pos == 0)? ml : 0xffffffffffffffffu;
  tl[1] = (pos == 1)? ml : 0xffffffffffffffffu;
  tl[2] = (pos == 2)? ml : 0xffffffffffffffffu;
  tl[3] = (pos == 3)? ml : 0xffffffffffffffffu;
  tl[4] = (pos == 4)? ml : 0xffffffffffffffffu;
  tl[5] = (pos == 5)? ml : 0xffffffffffffffffu;
  tl[6] = (pos == 6)? ml : 0xffffffffffffffffu;
  tl[7] = (pos == 7)? ml : 0xffffffffffffffffu;

  tr[0] = (pos == 0)? mr : 0u;
  tr[1] = (pos == 1)? mr : 0u;
  tr[2] = (pos == 2)? mr : 0u;
  tr[3] = (pos == 3)? mr : 0u;
  tr[4] = (pos == 4)? mr : 0u;
  tr[5] = (pos == 5)? mr : 0u;
  tr[6] = (pos == 6)? mr : 0u;
  tr[7] = (pos == 7)? mr : 0u;


  u32 out_len = in_len;

  u64 tib40[4];
  u64 tib41[4];

  rshift_block_optimized_utf16le_v2 (buf0, buf1, tib40, tib41);

  buf0[0] =  (buf0[0] & tl[0] ) | p1n | ( tib40[0] & tr[0] );
  buf0[1] =  (buf0[1] & tl[1] ) | p1n | ( tib40[1] & tr[1] );
  buf0[2] =  (buf0[2] & tl[2] ) | p1n | ( tib40[2] & tr[2] );
  buf0[3] =  (buf0[3] & tl[3] ) | p1n | ( tib40[3] & tr[3] );
  buf1[0] =  (buf1[0] & tl[4] ) | p1n | ( tib41[0] & tr[4] );
  buf1[1] =  (buf1[1] & tl[5] ) | p1n | ( tib41[1] & tr[5] );
  buf1[2] =  (buf1[2] & tl[6] ) | p1n | ( tib41[2] & tr[6] );
  buf1[3] =  (buf1[3] & tl[7] ) | p1n | ( tib41[3] & tr[7] );

/*
  switch (pos)
  {
    case  0:  buf0[0] =  (buf0[0] & ml) | p1n | (tib40[0] & mr);
              buf0[1] =  tib40[1];
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  1:  buf0[1] =  (buf0[1] & ml) | p1n | (tib40[1] & mr);
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  2:  buf0[2] =  (buf0[2] & ml) | p1n | (tib40[2] & mr);
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  3:  buf0[3] =  (buf0[3] & ml) | p1n | (tib40[3] & mr);
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  4:  buf1[0] =  (buf1[0] & ml) | p1n | (tib41[0] & mr);
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  5:  buf1[1] =  (buf1[1] & ml) | p1n | (tib41[1] & mr);
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              break;
    case  6:  buf1[2] =  (buf1[2] & ml) | p1n | (tib41[2] & mr);
              buf1[3] =  tib41[3];
              break;
    case  7:  buf1[3] =  (buf1[3] & ml) | p1n | (tib41[3] & mr);
              break;
  } */

  out_len += 2;

  return out_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_overstrike_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (p0 >= in_len) return in_len;

  const u64 p1n = (u64)p1 << ((p0 & 3u) * 16u);
  const u32 pos = p0 / 4u;

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  buf0[0] = (t[0] & buf0[0]) | (~t[0] & p1n) ;
  buf0[1] = (t[1] & buf0[1]) | (~t[1] & p1n) ;
  buf0[2] = (t[2] & buf0[2]) | (~t[2] & p1n) ;
  buf0[3] = (t[3] & buf0[3]) | (~t[3] & p1n) ;
  buf1[0] = (t[4] & buf1[0]) | (~t[4] & p1n) ;
  buf1[1] = (t[5] & buf1[1]) | (~t[5] & p1n) ;
  buf1[2] = (t[6] & buf1[2]) | (~t[6] & p1n) ;
  buf1[3] = (t[7] & buf1[3]) | (~t[7] & p1n) ;

  //printf("buf0[0] : %.16llx, buf0[1] : %.16llx, buf0[2] : %.16llx, buf0[3] : %.16llx,\n buf1[0] : %.16llx, buf1[1] : %.16llx, buf1[2] : %.16llx, buf1[3] : %.16llx, \np0 : %.8x, pos : %d, m : %.16llx, p1n : %.16llx \n", buf0[0],buf0[1],buf0[2],buf0[3],buf1[0],buf1[1],buf1[2],buf1[3],p0,pos,m,p1n);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_truncate_at_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (p0 >= in_len) return in_len;

  truncate_right_optimized_utf16le_v2 (buf0, buf1, p0);

  return p0;
}

DECLSPEC u64 search_on_register_utf16le_v2 (const u64 in, const u32 p0) // TODO
{
  u64 r = 0;
  r |= (hc_bfe_S64 (in,    0, 16) == p0)? 1:0;
  r |= (hc_bfe_S64 (in,   16, 16) == p0)? 2:0;
  r |= (hc_bfe_S64 (in,   32, 16) == p0)? 4:0;
  r |= (hc_bfe_S64 (in,   48, 16) == p0)? 8:0;

  return r;
}

DECLSPEC u64 replace_on_register_utf16le_v2 (const u64 in, const u64 r, const u32 p1) // OK - TO check
{
  u64 out = in;
  u64 mask=0,p;

#if  (defined IS_AMD || defined IS_HIP) && HAS_VPERM == 1

  u32 pl;
  __asm__ __volatile__ ("V_PERM_B32 %0, 0, %1, 0x01000100;" : "=v"(pl) : "v"(p1));
  p = hl32_to_64_S(pl,pl);

#elif defined IS_NV  && HAS_PRMT  == 1

  u32 pl; 
  asm volatile ("prmt.b32 %0, %1, 0, 0x1010;" : "=r"(pl) : "r"(p1));
  asm volatile ("mov.b64 %0, {%1, %2};" : "=l"(p) : "r"(pl), "r"(pl));

#else

  p = (u64)p1 | ((u64)p1 << 16u) | ((u64)p1 << 32u) | ((u64)p1 << 48u );

#endif

  mask |=   (r & 1)    *0xffffu;
  mask |= (((r & 2)>>1)*0xffffu) << 16u; 
  mask |= (((r & 4)>>2)*0xffffu) << 32u; 
  mask |= (((r & 8)>>3)*0xffffu) << 48u; 
  out = (in & ~mask) | (p & mask);
  
  //printf("r, %d, mask : %.16llx, p : %.16llx, out : %.16llx \n", r,mask,p,out);

  return out;
}

DECLSPEC void search_on_array_sep_utf16le_v2 (const u32 p0, const u32 p1, PRIVATE_AS const u64 *buf0, PRIVATE_AS const u64 *buf1, PRIVATE_AS u64 *mask) // TODO
{

  u64 p,tmpmask,tmp,tmp2;

  u32 pl,n,m=0; 

  asm volatile ("prmt.b32 %0, %1, 0, 0x1010;" : "=r"(pl) : "r"(p1));
  asm volatile ("mov.b64 %0, {%1, %2};" : "=l"(p) : "r"(pl), "r"(pl));

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 4; i++)
  {
    tmpmask = 0;
    tmp = ~(buf0[i] ^ p);
    tmp2 = tmp & 0x000000000000FFFFu;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> 4);
    tmpmask |= (m==p0)*((n >> 4)*0x000000000000FFFFu);;

    tmp2 = tmp & 0x00000000FFFF0000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> 4);
    tmpmask |= (m==p0)*((n >> 4)*0x00000000FFFF0000u);

    tmp2 = tmp & 0x0000FFFF00000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> 4);
    tmpmask |= (m==p0)*((n >> 4)*0x0000FFFF00000000u);

    tmp2 = tmp & 0xFFFF000000000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> 4);
    tmpmask |= (m==p0)*((n >> 4)*0xFFFF000000000000u);

    mask[i] |= tmpmask;
  }

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 4; i++)
  {
    tmpmask = 0;
    tmp = ~(buf1[i] ^ p);
    tmp2 = tmp & 0x000000000000FFFFu;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> 4);
    tmpmask |= (m==p0)*((n >> 4)*0x000000000000FFFFu);
    tmp2 = tmp & 0x00000000FFFF0000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2)); 
    m += (n >> 4); 
    tmpmask |= (m==p0)*((n >> 4)*0x00000000FFFF0000u);
    tmp2 = tmp & 0x0000FFFF00000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> 4);
    tmpmask |= (m==p0)*((n >> 4)*0x0000FFFF00000000u);
    tmp2 = tmp & 0xFFFF000000000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    m += (n >> p0);
    tmpmask |= (m==2)*((n >> 4)*0xFFFF000000000000u);
    mask[i+4] |= tmpmask;
  }

}


DECLSPEC void search_on_array_utf16le_v2 (PRIVATE_AS const u64 *buf0, PRIVATE_AS const u64 *buf1, PRIVATE_AS u64 *mask, const u32 p0) // TODO
{

  u64 p,tmpmask,tmp,tmp2;

  u32 pl,n; 
  asm volatile ("prmt.b32 %0, %1, 0, 0x1010;" : "=r"(pl) : "r"(p0));
  asm volatile ("mov.b64 %0, {%1, %2};" : "=l"(p) : "r"(pl), "r"(pl));

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 4; i++)
  {
    tmpmask = 0;
    tmp = ~(buf0[i] ^ p);
    tmp2 = tmp & 0x000000000000FFFFu;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0x000000000000FFFFu);

    tmp2 = tmp & 0x00000000FFFF0000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0x00000000FFFF0000u);

    tmp2 = tmp & 0x0000FFFF00000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0x0000FFFF00000000u);

    tmp2 = tmp & 0xFFFF000000000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0xFFFF000000000000u);

    mask[i] |= tmpmask;
  }

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < 4; i++)
  {
    tmpmask = 0;
    tmp = ~(buf1[i] ^ p);
    tmp2 = tmp & 0x000000000000FFFFu;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0x000000000000FFFFu);
    tmp2 = tmp & 0x00000000FFFF0000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2)); 
    tmpmask |= ((n >> 4)*0x00000000FFFF0000u);

    tmp2 = tmp & 0x0000FFFF00000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0x0000FFFF00000000u);

    tmp2 = tmp & 0xFFFF000000000000u;
    asm volatile ("popc.b64 %0, %1;" : "=r"(n): "l"(tmp2));
    tmpmask |= ((n >> 4)*0xFFFF000000000000u);
    mask[i+4] |= tmpmask;
  }

  /*mask[0] ^= ((hc_bfe_S64 (buf0[0],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[0] ^= ((hc_bfe_S64 (buf0[0],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[0] ^= ((hc_bfe_S64 (buf0[0],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[0] ^= ((hc_bfe_S64 (buf0[0],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[1] ^= ((hc_bfe_S64 (buf0[1],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[1] ^= ((hc_bfe_S64 (buf0[1],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[1] ^= ((hc_bfe_S64 (buf0[1],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[1] ^= ((hc_bfe_S64 (buf0[1],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[2] ^= ((hc_bfe_S64 (buf0[2],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[2] ^= ((hc_bfe_S64 (buf0[2],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[2] ^= ((hc_bfe_S64 (buf0[2],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[2] ^= ((hc_bfe_S64 (buf0[2],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[3] ^= ((hc_bfe_S64 (buf0[3],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[3] ^= ((hc_bfe_S64 (buf0[3],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[3] ^= ((hc_bfe_S64 (buf0[3],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[3] ^= ((hc_bfe_S64 (buf0[3],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[4] ^= ((hc_bfe_S64 (buf1[0],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[4] ^= ((hc_bfe_S64 (buf1[0],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[4] ^= ((hc_bfe_S64 (buf1[0],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[4] ^= ((hc_bfe_S64 (buf1[0],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[5] ^= ((hc_bfe_S64 (buf1[1],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[5] ^= ((hc_bfe_S64 (buf1[1],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[5] ^= ((hc_bfe_S64 (buf1[1],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[5] ^= ((hc_bfe_S64 (buf1[1],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[6] ^= ((hc_bfe_S64 (buf1[2],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[6] ^= ((hc_bfe_S64 (buf1[2],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[6] ^= ((hc_bfe_S64 (buf1[2],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[6] ^= ((hc_bfe_S64 (buf1[2],    48, 16) == p0)*0xFFFFu) << 48u;
  mask[7] ^= ((hc_bfe_S64 (buf1[3],     0, 16) == p0)*0xFFFFu) <<  0u;
  mask[7] ^= ((hc_bfe_S64 (buf1[3],    16, 16) == p0)*0xFFFFu) << 16u;
  mask[7] ^= ((hc_bfe_S64 (buf1[3],    32, 16) == p0)*0xFFFFu) << 32u;
  mask[7] ^= ((hc_bfe_S64 (buf1[3],    48, 16) == p0)*0xFFFFu) << 48u;*/

}

DECLSPEC void replace_on_array_utf16le_v2 (PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1, PRIVATE_AS const u64 *mask, const u32 p0) // OK - TO check
{
 
  u64 p;

  #if  (defined IS_AMD || defined IS_HIP) && HAS_VPERM == 1

  u32 pl;
  __asm__ __volatile__ ("V_PERM_B32 %0, 0, %1, 0x01000100;" : "=v"(pl) : "v"(p0));
  p = hl32_to_64_S(pl,pl);

  #elif defined IS_NV  && HAS_PRMT  == 1

  u32 pl; 
  asm volatile ("prmt.b32 %0, %1, 0, 0x1010;" : "=r"(pl) : "r"(p0));
  asm volatile ("mov.b64 %0, {%1, %2};" : "=l"(p) : "r"(pl), "r"(pl));

  #else

  p = (u64)p0 | ((u64)p0 << 16u) | ((u64)p0 << 32u) | ((u64)p0 << 48u );

  #endif

  buf0[0] = ( buf0[0] & ~mask[0] ) | ( p & mask[0] );
  buf0[1] = ( buf0[1] & ~mask[1] ) | ( p & mask[1] );
  buf0[2] = ( buf0[2] & ~mask[2] ) | ( p & mask[2] );
  buf0[3] = ( buf0[3] & ~mask[3] ) | ( p & mask[3] );
  buf1[0] = ( buf1[0] & ~mask[4] ) | ( p & mask[4] );
  buf1[1] = ( buf1[1] & ~mask[5] ) | ( p & mask[5] );
  buf1[2] = ( buf1[2] & ~mask[6] ) | ( p & mask[6] );
  buf1[3] = ( buf1[3] & ~mask[7] ) | ( p & mask[7] );
  
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{

  u64 mask[8];

  search_on_array_utf16le_v2(buf0,buf1,mask,p0);
  replace_on_array_utf16le_v2(buf0,buf1,mask,p0);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_l_utf16le_v2 MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_u_utf16le_v2 MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len)  // TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_d_utf16le_v2 MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len)  //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_lh_utf16le_v2 MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len)  //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_uh_utf16le_v2 MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len)  // TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_s_utf16le_v2 MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len)  // TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
{
       if ((u8)p0 == 'l') return rule_op_mangle_replace_class_l_utf16le   (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_replace_class_u_utf16le  (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_replace_class_d_utf16le  (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_replace_class_lh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_replace_class_uh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_replace_class_s_utf16le  (p0, p1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  const u64 r0 = search_on_register_utf16le_v2 (buf0[0], p0);
  const u64 r1 = search_on_register_utf16le_v2 (buf0[1], p0);
  const u64 r2 = search_on_register_utf16le_v2 (buf0[2], p0);
  const u64 r3 = search_on_register_utf16le_v2 (buf0[3], p0);
  const u64 r4 = search_on_register_utf16le_v2 (buf1[0], p0);
  const u64 r5 = search_on_register_utf16le_v2 (buf1[1], p0);
  const u64 r6 = search_on_register_utf16le_v2 (buf1[2], p0);
  const u64 r7 = search_on_register_utf16le_v2 (buf1[3], p0);

  const u64 rn = r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7;

  if (rn == 0) return in_len;

  u32 out_len = 0;

  u64 buf_in[8];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];

  u64 buf_out[8] = { 0 };

  PRIVATE_AS u16 *in  = (PRIVATE_AS u16 *) buf_in;
  PRIVATE_AS u16 *out = (PRIVATE_AS u16 *) buf_out;

  for (u32 pos = 0; pos < in_len/2; pos++)
  {
    if (in[pos] == (u16) p0) continue;

    out[out_len] = in[pos];

    out_len++;
  }

  out_len*=2;
  
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_l_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_u_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_d_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO 
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_lh_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO 
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_uh_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_s_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_utf16le_v2  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO 
{
  else if ((u8)p0 == 'u') return rule_op_mangle_purgechar_class_u_utf16le (p0, p1, buf0, buf1, in_len);
       if ((u8)p0 == 'l') return rule_op_mangle_purgechar_class_l_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_purgechar_class_d_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_purgechar_class_lh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_purgechar_class_uh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_purgechar_class_s_utf16le (p0, p1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_first_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if ( in_len       ==  0) return in_len;
  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  const u32 tmp = buf0[0] & 0xFFFFllu;
  
  //const u32 tmp = buf0[0] & 0xFFFFllu;

  u64 tmp64;

  u32 pl; 
  asm volatile ("prmt.b32 %0, %1, 0, 0x1010;" : "=r"(pl) : "r"(tmp));
  asm volatile ("mov.b64 %0, {%1, %2};" : "=l"(tmp64) : "r"(pl), "r"(pl));

  /*const u64 tmp64 = tmp <<  0u
                  | tmp <<  16u
                  | tmp <<  32u
                  | tmp <<  48u;*/

  rshift_block_optimized_N_utf16le_v2 (buf0, buf1, buf0, buf1, p0);  // -6 Gh/s

  u64 t[8] = { tmp64, tmp64, tmp64, tmp64,tmp64, tmp64, tmp64, tmp64 };

  truncate_right_optimized_utf16le_v2 (t, t+4, p0); // -5 Gh/s

  buf0[0] |= t[0];
  buf0[1] |= t[1];
  buf0[2] |= t[2];
  buf0[3] |= t[3];
  buf1[0] |= t[4];
  buf1[1] |= t[5];
  buf1[2] |= t[6];
  buf1[3] |= t[7];

  out_len += p0;

  return out_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_last_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // TODO set_mark
{
  if ( in_len       ==  0) return in_len;
  if ((in_len + p0) >= 64) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 sh = (in_len1 & 2) * 8;

  u64 tmp = 0;

  u64 v[4];

  set_mark_1x4_S_64 (v, in_len1); 

  switch (in_len1 / 16)
  {
    case 0:
      tmp |= buf0[0] & v[0];
      tmp |= buf0[1] & v[1];
      tmp |= buf0[2] & v[2];
      tmp |= buf0[3] & v[3];
      break;

    case 1:
      tmp |= buf1[0] & v[0];
      tmp |= buf1[1] & v[1];
      tmp |= buf1[2] & v[2];
      tmp |= buf1[3] & v[3];
      break;
  }

  tmp = (tmp >> sh) & 0xffff;

  u32 out_len = in_len;

  for (u32 i = 0; i < p0/2; i++)
  {
    append_block1_optimized_utf16le_v2 (out_len, buf0, buf1, tmp); 

    out_len+=2;
  }

  return out_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_all_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if ( in_len           ==  0) return in_len;
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u64 tib40[4];
  u64 tib41[4];

  tib40[0] = ((buf0[0] & 0x000000000000FFFF) <<   0) | ((buf0[0] & 0x000000000000FFFF) <<  16) 
           | ((buf0[0] & 0x00000000FFFF0000) <<  16) | ((buf0[0] & 0x00000000FFFF0000) <<  32);
  tib40[1] = ((buf0[0] & 0x0000FFFF00000000) >>  32) | ((buf0[0] & 0x0000FFFF00000000) >>  16) 
           | ((buf0[0] & 0xFFFF000000000000) >>   0) | ((buf0[0] & 0xFFFF000000000000) >>  16);

  tib40[2] = ((buf0[1] & 0x000000000000FFFF) <<   0) | ((buf0[1] & 0x000000000000FFFF) <<  16) 
           | ((buf0[1] & 0x00000000FFFF0000) <<  16) | ((buf0[1] & 0x00000000FFFF0000) <<  32);
  tib40[3] = ((buf0[1] & 0x0000FFFF00000000) >>  32) | ((buf0[1] & 0x0000FFFF00000000) >>  16) 
           | ((buf0[1] & 0xFFFF000000000000) >>   0) | ((buf0[1] & 0xFFFF000000000000) >>  16);

  tib41[0] = ((buf0[2] & 0x000000000000FFFF) <<   0) | ((buf0[2] & 0x000000000000FFFF) <<  16) 
           | ((buf0[2] & 0x00000000FFFF0000) <<  16) | ((buf0[2] & 0x00000000FFFF0000) <<  32);
  tib41[1] = ((buf0[2] & 0x0000FFFF00000000) >>  32) | ((buf0[2] & 0x0000FFFF00000000) >>  16) 
           | ((buf0[2] & 0xFFFF000000000000) >>   0) | ((buf0[2] & 0xFFFF000000000000) >>  16);

  tib41[2] = ((buf0[3] & 0x000000000000FFFF) <<   0) | ((buf0[3] & 0x000000000000FFFF) <<  16) 
           | ((buf0[3] & 0x00000000FFFF0000) <<  16) | ((buf0[3] & 0x00000000FFFF0000) <<  32);
  tib41[3] = ((buf0[3] & 0x0000FFFF00000000) >>  32) | ((buf0[3] & 0x0000FFFF00000000) >>  16) 
           | ((buf0[3] & 0xFFFF000000000000) >>   0) | ((buf0[3] & 0xFFFF000000000000) >>  16);

  buf0[0] = tib40[0]; 
  buf0[1] = tib40[1];
  buf0[2] = tib40[2];
  buf0[3] = tib40[3];
  buf1[0] = tib41[0];
  buf1[1] = tib41[1];
  buf1[2] = tib41[2];
  buf1[3] = tib41[3];

  out_len = out_len + out_len;

  return out_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_first_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (in_len < 4 ) return in_len;

  buf0[0] = ((buf0[0] & 0x0000FFFFu) << 16) | ((buf0[0] & 0xFFFF0000u) >> 16);

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_last_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check  
{
  if (in_len < 4) return in_len;

  u64 t[8];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];

  exchange_byte_optimized_utf16le_v2 (t, (in_len/2) - 2, (in_len/2) - 1);  

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_at_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (p0 >= in_len) return in_len;
  if (p1 >= in_len) return in_len;

  u64 t[8];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];

  exchange_byte_optimized_utf16le_v2 (t, p0/2, p1/2);

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftl_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if (p0 >= in_len) return in_len;

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));  
  const u32 pos = p0 / 4u;

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  //const u64 tmp = t[p0 / 4];
  //t[p0 / 4] = (tmp & ml) | ((tmp  << 1) & ~ml);  

  buf0[0] = ( t[0] & buf0[0] ) | ( ~t[0] & ( buf0[0] << 1u )) ;
  buf0[1] = ( t[1] & buf0[1] ) | ( ~t[1] & ( buf0[1] << 1u )) ;
  buf0[2] = ( t[2] & buf0[2] ) | ( ~t[2] & ( buf0[2] << 1u )) ;
  buf0[3] = ( t[3] & buf0[3] ) | ( ~t[3] & ( buf0[3] << 1u )) ;
  buf1[0] = ( t[4] & buf1[0] ) | ( ~t[4] & ( buf1[0] << 1u )) ;
  buf1[1] = ( t[5] & buf1[1] ) | ( ~t[5] & ( buf1[1] << 1u )) ;
  buf1[2] = ( t[6] & buf1[2] ) | ( ~t[6] & ( buf1[2] << 1u )) ;
  buf1[3] = ( t[7] & buf1[3] ) | ( ~t[7] & ( buf1[3] << 1u )) ;

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftr_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (p0 >= in_len) return in_len;

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));  
  const u32 pos = p0 / 4u;

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  //const u64 tmp = t[p0 / 4];
  //t[p0 / 4] = (tmp & ml) | ((tmp  >> 1) & ~ml);  

  buf0[0] = ( t[0] & buf0[0] ) | ( ~t[0] & ( buf0[0] >> 1u )) ;
  buf0[1] = ( t[1] & buf0[1] ) | ( ~t[1] & ( buf0[1] >> 1u )) ;
  buf0[2] = ( t[2] & buf0[2] ) | ( ~t[2] & ( buf0[2] >> 1u )) ;
  buf0[3] = ( t[3] & buf0[3] ) | ( ~t[3] & ( buf0[3] >> 1u )) ;
  buf1[0] = ( t[4] & buf1[0] ) | ( ~t[4] & ( buf1[0] >> 1u )) ;
  buf1[1] = ( t[5] & buf1[1] ) | ( ~t[5] & ( buf1[1] >> 1u )) ;
  buf1[2] = ( t[6] & buf1[2] ) | ( ~t[6] & ( buf1[2] >> 1u )) ;
  buf1[3] = ( t[7] & buf1[3] ) | ( ~t[7] & ( buf1[3] >> 1u )) ;

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_incr_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check
{
  if (p0 >= in_len) return in_len;

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));  
  const u32 pos = p0 / 4u;
  const u64 n = 0x0001000100010001u ; 

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  buf0[0] = ( t[0] & buf0[0] ) | ( ~t[0] & ( buf0[0] + n )) ;
  buf0[1] = ( t[1] & buf0[1] ) | ( ~t[1] & ( buf0[1] + n )) ;
  buf0[2] = ( t[2] & buf0[2] ) | ( ~t[2] & ( buf0[2] + n )) ;
  buf0[3] = ( t[3] & buf0[3] ) | ( ~t[3] & ( buf0[3] + n )) ;
  buf1[0] = ( t[4] & buf1[0] ) | ( ~t[4] & ( buf1[0] + n )) ;
  buf1[1] = ( t[5] & buf1[1] ) | ( ~t[5] & ( buf1[1] + n )) ;
  buf1[2] = ( t[6] & buf1[2] ) | ( ~t[6] & ( buf1[2] + n )) ;
  buf1[3] = ( t[7] & buf1[3] ) | ( ~t[7] & ( buf1[3] + n )) ;

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_decr_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if (p0 >= in_len) return in_len;

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));  
  const u32 pos = p0 / 4u;
  const u64 n = 0x0001000100010001u ; 

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  buf0[0] = ( t[0] & buf0[0] ) | ( ~t[0] & ( buf0[0] - n )) ;
  buf0[1] = ( t[1] & buf0[1] ) | ( ~t[1] & ( buf0[1] - n )) ;
  buf0[2] = ( t[2] & buf0[2] ) | ( ~t[2] & ( buf0[2] - n )) ;
  buf0[3] = ( t[3] & buf0[3] ) | ( ~t[3] & ( buf0[3] - n )) ;
  buf1[0] = ( t[4] & buf1[0] ) | ( ~t[4] & ( buf1[0] - n )) ;
  buf1[1] = ( t[5] & buf1[1] ) | ( ~t[5] & ( buf1[1] - n )) ;
  buf1[2] = ( t[6] & buf1[2] ) | ( ~t[6] & ( buf1[2] - n )) ;
  buf1[3] = ( t[7] & buf1[3] ) | ( ~t[7] & ( buf1[3] - n )) ;

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_add_utf16le_v2  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len)   //TODO
{
  if (p0 >= in_len) return in_len;

  const u32 mr = 0xffu << ((p0 & 3) * 8);
  const u32 ml = ~mr;

  const u32 n = (p1 & 0xffu) << ((p0 & 3) * 8);

  u32 t[8];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];

  const u32 tmp = t[p0 / 4];

  t[p0 / 4] = (tmp & ml) | (((tmp & mr) + n) & mr);

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_np1_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if ((p0 + 2) >= in_len) return in_len;

  u64 tib4x[8];

  lshift_block_optimized_utf16le_v2 (buf0, buf1,tib4x + 0, tib4x + 4);

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));
  const u32 pos = p0 / 4u;

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  //const u64 tmp = t[pos];
  //const u64 tmp2 = tib4x[pos];
  //t[pos] = (tmp & ml) | (tmp2 & mr);

  buf0[0] = ( t[0] & buf0[0] ) | ( ~t[0] & tib4x[0] );
  buf0[1] = ( t[1] & buf0[1] ) | ( ~t[1] & tib4x[1] );
  buf0[2] = ( t[2] & buf0[2] ) | ( ~t[2] & tib4x[2] );
  buf0[3] = ( t[3] & buf0[3] ) | ( ~t[3] & tib4x[3] );
  buf1[0] = ( t[4] & buf1[0] ) | ( ~t[4] & tib4x[0] );
  buf1[1] = ( t[5] & buf1[1] ) | ( ~t[5] & tib4x[1] );
  buf1[2] = ( t[6] & buf1[2] ) | ( ~t[6] & tib4x[2] );
  buf1[3] = ( t[7] & buf1[3] ) | ( ~t[7] & tib4x[3] );

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_nm1_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if (p0 == 0) return in_len;

  if (p0 >= in_len) return in_len;

  u64 tib4x[8];

  rshift_block_optimized_utf16le_v2 (buf0, buf1, tib4x + 0, tib4x + 4);

  const u64 m = ~(0xffffllu << ((p0 & 3u) * 16u));
  const u32 pos = p0 / 4u;

  u64 t[8];

  t[0] = (pos == 0)? m : 0xffffffffffffffffu;
  t[1] = (pos == 1)? m : 0xffffffffffffffffu;
  t[2] = (pos == 2)? m : 0xffffffffffffffffu;
  t[3] = (pos == 3)? m : 0xffffffffffffffffu;
  t[4] = (pos == 4)? m : 0xffffffffffffffffu;
  t[5] = (pos == 5)? m : 0xffffffffffffffffu;
  t[6] = (pos == 6)? m : 0xffffffffffffffffu;
  t[7] = (pos == 7)? m : 0xffffffffffffffffu;

  //const u64 tmp = t[p0 / 4];
  //const u64 tmp2 = tib4x[p0 / 4];
  //t[p0 / 4] = (tmp & ml) | (tmp2 & mr);

  buf0[0] = ( t[0] & buf0[0] ) | ( ~t[0] & tib4x[0] );
  buf0[1] = ( t[1] & buf0[1] ) | ( ~t[1] & tib4x[1] );
  buf0[2] = ( t[2] & buf0[2] ) | ( ~t[2] & tib4x[2] );
  buf0[3] = ( t[3] & buf0[3] ) | ( ~t[3] & tib4x[3] );
  buf1[0] = ( t[4] & buf1[0] ) | ( ~t[4] & tib4x[0] );
  buf1[1] = ( t[5] & buf1[1] ) | ( ~t[5] & tib4x[1] );
  buf1[2] = ( t[6] & buf1[2] ) | ( ~t[6] & tib4x[2] );
  buf1[3] = ( t[7] & buf1[3] ) | ( ~t[7] & tib4x[3] );

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_first_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if (p0 > in_len) return in_len;

  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  u64 tib40[4];
  u64 tib41[4];

  tib40[0] = buf0[0];
  tib40[1] = buf0[1];
  tib40[2] = buf0[2];
  tib40[3] = buf0[3];
  tib41[0] = buf1[0];
  tib41[1] = buf1[1];
  tib41[2] = buf1[2];
  tib41[3] = buf1[3];
  truncate_right_optimized_utf16le_v2 (tib40, tib41, p0);

  rshift_block_optimized_N_utf16le_v2 (buf0, buf1, buf0, buf1, p0);

  buf0[0] |= tib40[0];
  buf0[1] |= tib40[1];
  buf0[2] |= tib40[2];
  buf0[3] |= tib40[3];
  buf1[0] |= tib41[0];
  buf1[1] |= tib41[1];
  buf1[2] |= tib41[2];
  buf1[3] |= tib41[3];

  out_len += p0;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_last_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check 
{
  if (p0 > in_len) return in_len;

  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  u64 tib40[4];
  u64 tib41[4];

  rshift_block_optimized_N_utf16le_v2 (buf0, buf1, tib40, tib41, p0);

  truncate_left_optimized_utf16le_v2 (tib40, tib41, out_len);

  buf0[0] |= tib40[0];
  buf0[1] |= tib40[1];
  buf0[2] |= tib40[2];
  buf0[3] |= tib40[3];
  buf1[0] |= tib41[0];
  buf1[1] |= tib41[1];
  buf1[2] |= tib41[2];
  buf1[3] |= tib41[3];

  out_len += p0;

  return out_len;
}

DECLSPEC u64 toggle_on_register_utf16le_v2 (const u64 in, const u64 r) // OK - TO check  
{
  u64 out;

  const u64 cmask = generate_cmask_optimized_utf16le_v2(in);
  u64 mask=0;

  mask |=   (r & 1)    *0x0020u;
  mask |= (((r & 2)>>1)*0x0020u) << 16u; 
  mask |= (((r & 4)>>2)*0x0020u) << 32u; 
  mask |= (((r & 8)>>3)*0x0020u) << 48u; 

  asm volatile ("and.b64 %0, %1, %2;" : "=l"(mask) : "l"(mask), "l"(cmask));
  asm volatile ("xor.b64 %0, %1, %2;" : "=l"(out) : "l"(in), "l"(mask));


  out = in ^ (mask & cmask);

  return out;
}
DECLSPEC void toggle_on_array_utf16le_v2 (PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1, PRIVATE_AS const u64 *mask, const u64 r) // OK - TO check  
{
  
  u64 cmask[8] = {0};
  generate_acmask_optimized_utf16le_v2(buf0,buf1,cmask);


  /*mask |=   (r & 1)    *0x0020u;
  mask |= (((r & 2)>>1)*0x0020u) << 16u; 
  mask |= (((r & 4)>>2)*0x0020u) << 32u; 
  mask |= (((r & 8)>>3)*0x0020u) << 48u; 

  asm volatile ("and.b64 %0, %1, %2;" : "=l"(mask) : "l"(mask), "l"(cmask));
  asm volatile ("xor.b64 %0, %1, %2;" : "=l"(out) : "l"(in), "l"(mask));


  //out = in ^ (mask & cmask);*/

}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) // OK - TO check  
{
  if (in_len == 0) return in_len;

  u64 mask[8] = {0}, cmask[8] = {0};
  
  search_on_array_utf16le_v2(buf0,buf1,mask,p0);

  rshift_block_optimized_utf16le_v2 (mask, mask+4, mask, mask+4);

  generate_acmask_optimized_utf16le_v2(buf0,buf1,cmask);

  mask[0] |= 0xFFFFu;

  buf0[0] ^= mask[0] & cmask[0];
  buf0[1] ^= mask[1] & cmask[1];
  buf0[2] ^= mask[2] & cmask[2];
  buf0[3] ^= mask[3] & cmask[3];
  buf1[0] ^= mask[4] & cmask[4];
  buf1[1] ^= mask[5] & cmask[5];
  buf1[2] ^= mask[6] & cmask[6];
  buf1[3] ^= mask[7] & cmask[7];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_l_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_u_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_d_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_lh_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_uh_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_s_utf16le_v2 (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_utf16le_v2  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u64 *buf0, MAYBE_UNUSED PRIVATE_AS u64 *buf1, const u32 in_len) //TODO
{
       if ((u8)p0 == 'l') return rule_op_mangle_title_sep_class_l_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_title_sep_class_u_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_title_sep_class_d_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_title_sep_class_lh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_title_sep_class_uh_utf16le (p0, p1, buf0, buf1, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_title_sep_class_s_utf16le (p0, p1, buf0, buf1, in_len);

  return in_len;
}

DECLSPEC u32 apply_rule_optimized_utf16le_v2 (const u32 name, const u32 p0, const u32 p1, PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1,  const u32 in_len){
  if(name == RULE_OP_MANGLE_NOOP) return in_len;
  //u32 out_len = in_len;
  //out_len = rule_op_mangle_dupechar_first_utf16le_v2   (p0, p1, buf0, buf1, in_len);
  
  u32 out_len = in_len;
  
  switch (name)
  { 
    case RULE_OP_MANGLE_LREST:            out_len = rule_op_mangle_lrest_utf16le_v2            (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_UREST:            out_len = rule_op_mangle_urest_utf16le_v2            (p0, p1, buf0, buf1, in_len); break;  // revoir pour les nombre
    case RULE_OP_MANGLE_LREST_UFIRST:     out_len = rule_op_mangle_lrest_ufirst_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_UREST_LFIRST:     out_len = rule_op_mangle_urest_lfirst_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // revoir pour les nombre
    case RULE_OP_MANGLE_TREST:            out_len = rule_op_mangle_trest_utf16le_v2            (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SHIFT_CASE:       out_len = rule_op_mangle_shift_case_utf16le_v2		   (p0, p1, buf0, buf1, in_len); break; //TODO
    case RULE_OP_MANGLE_TOGGLE_AT:        out_len = rule_op_mangle_toggle_at_utf16le_v2        (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TOGGLE_AT_SEP:    out_len = rule_op_mangle_toggle_at_sep_utf16le_v2    (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REVERSE:          out_len = rule_op_mangle_reverse_utf16le_v2          (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEWORD:         out_len = rule_op_mangle_dupeword_utf16le_v2         (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEWORD_TIMES:   out_len = rule_op_mangle_dupeword_times_utf16le_v2   (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REFLECT:          out_len = rule_op_mangle_reflect_utf16le_v2          (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_APPEND:           out_len = rule_op_mangle_append_utf16le_v2           (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_PREPEND:          out_len = rule_op_mangle_prepend_utf16le_v2          (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_ROTATE_LEFT:      out_len = rule_op_mangle_rotate_left_utf16le_v2      (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_ROTATE_RIGHT:     out_len = rule_op_mangle_rotate_right_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_FIRST:     out_len = rule_op_mangle_delete_first_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_LAST:      out_len = rule_op_mangle_delete_last_utf16le_v2      (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_AT:        out_len = rule_op_mangle_delete_at_utf16le_v2        (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_EXTRACT:          out_len = rule_op_mangle_extract_utf16le_v2          (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_OMIT:             out_len = rule_op_mangle_omit_utf16le_v2             (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_INSERT:           out_len = rule_op_mangle_insert_utf16le_v2           (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_INSERT_EVERY:     out_len = rule_op_mangle_insert_every_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // TODO
    case RULE_OP_MANGLE_OVERSTRIKE:       out_len = rule_op_mangle_overstrike_utf16le_v2       (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TRUNCATE_AT:      out_len = rule_op_mangle_truncate_at_utf16le_v2      (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE:          out_len = rule_op_mangle_replace_utf16le_v2          (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE_CLASS:    out_len = rule_op_mangle_replace_class_utf16le_v2    (p0, p1, buf0, buf1, in_len); break;  //TODO
    case RULE_OP_MANGLE_PURGECHAR:        out_len = rule_op_mangle_purgechar_utf16le_v2        (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_PURGECHAR_CLASS:  out_len = rule_op_mangle_purgechar_class_utf16le     (p0, p1, buf0, buf1, in_len); break;  // TODO
    case RULE_OP_MANGLE_TOGGLECASE_REC:   out_len = rule_op_mangle_togglecase_rec_utf16le_v2   (p0, p1, buf0, buf1, in_len); break;  // TODO
    case RULE_OP_MANGLE_DUPECHAR_FIRST:   out_len = rule_op_mangle_dupechar_first_utf16le_v2   (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPECHAR_LAST:    out_len = rule_op_mangle_dupechar_last_utf16le_v2    (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPECHAR_ALL:     out_len = rule_op_mangle_dupechar_all_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_FIRST:     out_len = rule_op_mangle_switch_first_utf16le_v2     (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_LAST:      out_len = rule_op_mangle_switch_last_utf16le_v2      (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_AT:        out_len = rule_op_mangle_switch_at_utf16le_v2        (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_SHIFTL:       out_len = rule_op_mangle_chr_shiftl_utf16le_v2       (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_SHIFTR:       out_len = rule_op_mangle_chr_shiftr_utf16le_v2       (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_INCR:         out_len = rule_op_mangle_chr_incr_utf16le_v2         (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_DECR:         out_len = rule_op_mangle_chr_decr_utf16le_v2         (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_ADD:          out_len = rule_op_mangle_chr_add_utf16le 	           (p0, p1, buf0, buf1, in_len); break;  //TODO
    case RULE_OP_MANGLE_REPLACE_NP1:      out_len = rule_op_mangle_replace_np1_utf16le_v2      (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE_NM1:      out_len = rule_op_mangle_replace_nm1_utf16le_v2      (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEBLOCK_FIRST:  out_len = rule_op_mangle_dupeblock_first_utf16le_v2  (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEBLOCK_LAST:   out_len = rule_op_mangle_dupeblock_last_utf16le_v2   (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TITLE_SEP:        out_len = rule_op_mangle_title_sep_utf16le_v2        (p0, p1, buf0, buf1, in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TITLE_SEP_CLASS:  out_len = rule_op_mangle_title_sep_class_utf16le     (p0, p1, buf0, buf1, in_len); break;  //TODO
    case RULE_OP_MANGLE_TITLE:            out_len = rule_op_mangle_title_sep_utf16le_v2        (' ', p1, buf0, buf1,in_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TO_HEX_LOWER: out_len = rule_op_mangle_to_hex_lower_utf16le            (p0, p1, buf0, buf1, in_len); break; break; // TODO
    case RULE_OP_MANGLE_TO_HEX_UPPER:     out_len = rule_op_mangle_to_hex_upper_utf16le        (p0, p1, buf0, buf1, in_len); break; // TODO

  }

  return out_len;
}
DECLSPEC u32 apply_rules_optimized_utf16le_v2 (CONSTANT_AS const u64 *cmds, PRIVATE_AS u64 *buf0, PRIVATE_AS u64 *buf1, const u32 len)
{
  u32 out_len = len;

  for (u32 i = 0; cmds[i] != 0; i++)
  {
    const u64 cmd = cmds[i];
    
    //printf(" cmd : %.16llX \n", cmd);
    const u32 name = (cmd >>  0) & 0xffff;
    const u32 p0   = (cmd >>  16) & 0xffff;
    const u32 p1   = (cmd >>  32) & 0xffff;

  /*printf("name : %.8X \n", name);
  printf("p0 : %.8X \n", p0);
  printf("p1 : %.8X \n", p1);*/
 
    //printf("AV len %d : buf0[0] : %.16llX buf0[1] : %.16llX buf0[2] : %.16llX buf0[3] : %.16llX\n\t    buf1[0] : %.16llX buf1[1] : %.16llX buf1[2] : %.16llX buf1[3] : %.16llX\n", out_len, *buf0,*(buf0+1),*(buf0+2),*(buf0+3),*buf1,*(buf1+1),*(buf1+2),*(buf1+3));
    // we need to guarantee input length < 32 otherwise functions like rule_op_mangle_switch_last() and others will read out of boundary
    out_len = apply_rule_optimized_utf16le_v2 (name, p0, p1, buf0, buf1, out_len);

    //printf("AP len %d : buf0[0] : %.16llX buf0[1] : %.16llX buf0[2] : %.16llX buf0[3] : %.16llX\n\t    buf1[0] : %.16llX buf1[1] : %.16llX buf1[2] : %.16llX buf1[3] : %.16llX\n", out_len, *buf0,*(buf0+1),*(buf0+2),*(buf0+3),*buf1,*(buf1+1),*(buf1+2),*(buf1+3));
  }

  return out_len;
}
DECLSPEC u32x apply_rules_vect_optimized_utf16le_v2 (PRIVATE_AS const u64 *pw_buf0, PRIVATE_AS const u64 *pw_buf1, const u32 pw_len, CONSTANT_AS const kernel_rule_t *kernel_rules, const u32 il_pos, PRIVATE_AS u32x *buf0, PRIVATE_AS u32x *buf1, PRIVATE_AS u32x *buf2, PRIVATE_AS u32x *buf3)
{

  #if VECT_SIZE == 1

  u64 tmp0[4];
  u64 tmp1[4];
  
  tmp0[0] = *pw_buf0;
  tmp0[1] = *(pw_buf0+1);
  tmp0[2] = *(pw_buf0+2);
  tmp0[3] = *(pw_buf0+3);
  tmp1[0] = *pw_buf1;
  tmp1[1] = *(pw_buf1+1);
  tmp1[2] = *(pw_buf1+2);
  tmp1[3] = *(pw_buf1+3);

  const u32 tmp_len = apply_rules_optimized_utf16le_v2 (kernel_rules[il_pos].cmds, tmp0, tmp1, pw_len);

  buf0[0] = (u32)(tmp0[0] & 0xFFFFFFFF);
  buf0[1] = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
  buf0[2] = (u32)( tmp0[1] & 0xFFFFFFFF);
  buf0[3] = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
  buf1[0] = (u32)( tmp0[2] & 0xFFFFFFFF);
  buf1[1] = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
  buf1[2] = (u32)( tmp0[3] & 0xFFFFFFFF);
  buf1[3] = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
  buf2[0] = (u32)( tmp1[0] & 0xFFFFFFFF);
  buf2[1] = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
  buf2[2] = (u32)( tmp1[1] & 0xFFFFFFFF);
  buf2[3] = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
  buf3[0] = (u32)( tmp1[2] & 0xFFFFFFFF);
  buf3[1] = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
  buf3[2] = (u32)( tmp1[3] & 0xFFFFFFFF);
  buf3[3] = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);

  return tmp_len;

  #else

  u32x out_len = 0;

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < VECT_SIZE; i++)
  {
    u64 tmp0[4];
    u64 tmp1[4];
    
    tmp0[0] = *pw_buf0;
    tmp0[1] = *(pw_buf0+1);
    tmp0[2] = *(pw_buf0+2);
    tmp0[3] = *(pw_buf0+3);
    tmp1[0] = *pw_buf1;
    tmp1[1] = *(pw_buf1+1);
    tmp1[2] = *(pw_buf1+2);
    tmp1[3] = *(pw_buf1+3);

    const u32 tmp_len = apply_rules_optimized_utf16le_v2 (kernel_rules[il_pos + i].cmds, tmp0, tmp1, pw_len);

    switch (i)
    {
      #if VECT_SIZE >= 2
      case 0:
        buf0[0].s0 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s0 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s0 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s0 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s0 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s0 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s0 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s0 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s0 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s0 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s0 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s0 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s0 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s0 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s0 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s0 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s0 = tmp_len;
        break;

      case 1:
        buf0[0].s1 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s1 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s1 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s1 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s1 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s1 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s1 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s1 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s1 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s1 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s1 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s1 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s1 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s1 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s1 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s1 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s1 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 4
      case 2:
        buf0[0].s2 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s2 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s2 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s2 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s2 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s2 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s2 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s2 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s2 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s2 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s2 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s2 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s2 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s2 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s2 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s2 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s2 = tmp_len;
        break;

      case 3:
        buf0[0].s3 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s3 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s3 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s3 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s3 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s3 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s3 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s3 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s3 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s3 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s3 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s3 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s3 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s3 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s3 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s3 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s3 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 8
      case 4:
        buf0[0].s4 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s4 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s4 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s4 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s4 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s4 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s4 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s4 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s4 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s4 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s4 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s4 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s4 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s4 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s4 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s4 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s4 = tmp_len;
        break;

      case 5:
        buf0[0].s5 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s5 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s5 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s5 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s5 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s5 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s5 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s5 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s5 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s5 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s5 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s5 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s5 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s5 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s5 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s5 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s5 = tmp_len;
        break;

      case 6:
        buf0[0].s6 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s6 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s6 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s6 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s6 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s6 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s6 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s6 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s6 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s6 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s6 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s6 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s6 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s6 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s6 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s6 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s6 = tmp_len;
        break;

      case 7:
        buf0[0].s7 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s7 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s7 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s7 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s7 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s7 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s7 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s7 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s7 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s7 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s7 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s7 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s7 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s7 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s7 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s7 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s7 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 16
      case 8:
        buf0[0].s8 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s8 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s8 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s8 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s8 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s8 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s8 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s8 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s8 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s8 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s8 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s8 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s8 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s8 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s8 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s8 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s8 = tmp_len;
        break;

      case 9:
        buf0[0].s9 = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].s9 = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].s9 = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].s9 = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].s9 = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].s9 = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].s9 = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].s9 = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].s9 = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].s9 = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].s9 = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].s9 = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].s9 = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].s9 = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].s9 = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].s9 = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.s9 = tmp_len;
        break;

      case 10:
        buf0[0].sa = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].sa = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].sa = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].sa = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].sa = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].sa = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].sa = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].sa = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].sa = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].sa = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].sa = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].sa = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].sa = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].sa = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].sa = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].sa = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.sa = tmp_len;
        break;

      case 11:
        buf0[0].sb = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].sb = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].sb = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].sb = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].sb = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].sb = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].sb = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].sb = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].sb = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].sb = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].sb = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].sb = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].sb = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].sb = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].sb = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].sb = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.sb = tmp_len;
        break;

      case 12:
        buf0[0].sc = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].sc = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].sc = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].sc = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].sc = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].sc = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].sc = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].sc = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].sc = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].sc = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].sc = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].sc = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].sc = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].sc = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].sc = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].sc = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.sc = tmp_len;
        break;

      case 13:
        buf0[0].sd = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].sd = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].sd = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].sd = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].sd = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].sd = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].sd = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].sd = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].sd = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].sd = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].sd = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].sd = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].sd = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].sd = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].sd = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].sd = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.sd = tmp_len;
        break;

      case 14:
        buf0[0].se = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].se = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].se = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].se = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].se = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].se = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].se = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].se = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].se = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].se = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].se = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].se = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].se = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].se = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].se = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].se = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.se = tmp_len;
        break;

      case 15:
        buf0[0].sf = (u32)(tmp0[0] & 0xFFFFFFFF);
        buf0[1].sf = (u32)((tmp0[0] >> 32) & 0xFFFFFFFF);
        buf0[2].sf = (u32)( tmp0[1] & 0xFFFFFFFF);
        buf0[3].sf = (u32)((tmp0[1] >> 32) & 0xFFFFFFFF);
        buf1[0].sf = (u32)( tmp0[2] & 0xFFFFFFFF);
        buf1[1].sf = (u32)((tmp0[2] >> 32) & 0xFFFFFFFF);
        buf1[2].sf = (u32)( tmp0[3] & 0xFFFFFFFF);
        buf1[3].sf = (u32)((tmp0[3] >> 32) & 0xFFFFFFFF);
        buf2[0].sf = (u32)( tmp1[0] & 0xFFFFFFFF);
        buf2[1].sf = (u32)((tmp1[0] >> 32) & 0xFFFFFFFF);
        buf2[2].sf = (u32)( tmp1[1] & 0xFFFFFFFF);
        buf2[3].sf = (u32)((tmp1[1] >> 32) & 0xFFFFFFFF);
        buf3[0].sf = (u32)( tmp1[2] & 0xFFFFFFFF);
        buf3[1].sf = (u32)((tmp1[2] >> 32) & 0xFFFFFFFF);
        buf3[2].sf = (u32)( tmp1[3] & 0xFFFFFFFF);
        buf3[3].sf = (u32)((tmp1[3] >> 32) & 0xFFFFFFFF);
        out_len.sf = tmp_len;
        break;
      #endif
    }
  }

  return out_len;

  #endif
  
}

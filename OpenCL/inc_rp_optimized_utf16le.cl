/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

#include "inc_vendor.h"
#include "inc_types.h"
#include "inc_platform.h"
#include "inc_common.h"

#include "inc_rp_optimized_utf16le.h"
#include "inc_rp_common.cl"

#ifndef MAYBE_UNUSED
#define MAYBE_UNUSED
#endif

DECLSPEC void truncate_right_optimized_utf16le (PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, PRIVATE_AS u32 *buf2, PRIVATE_AS u32 *buf3, const u32 offset)
{
  const u32 tmp = (1u << ((offset & 2u) * 8u)) - 1u;

  const int offset_switch = offset / 4;
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
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  1:  buf0[1] &= tmp;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  2:  buf0[2] &= tmp;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  3:  buf0[3] &= tmp;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  4:  buf1[0] &= tmp;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  5:  buf1[1] &= tmp;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  6:  buf1[2] &= tmp;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  7:  buf1[3] &= tmp;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  8:  buf2[0] &= tmp;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  9:  buf2[1] &= tmp;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case 10:  buf2[2] &= tmp;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  11: buf2[3] &= tmp;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  12: buf3[0] &= tmp;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  13: buf3[1] &= tmp;
              buf3[2]  = 0;
              buf3[3]  = 0;
              break;
    case  14: buf3[2] &= tmp;
              buf3[3]  = 0;
              break;
    case  15: buf3[3] &= tmp;
              break;
  }
}

DECLSPEC void truncate_left_optimized_utf16le (PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, PRIVATE_AS u32 *buf2, PRIVATE_AS u32 *buf3, const u32 offset) 
{
  const u32 tmp = ~((1u << ((offset & 2u) * 8u)) - 1u);

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
    case  8:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0] &= tmp;
              break;
    case  9:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1] &= tmp;
              break;
    case  10:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2] &= tmp;
              break;
    case  11: buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3] &= tmp;
              break;
    case  12:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0] &= tmp;
              break;
    case  13:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1] &= tmp;
              break;
    case  14:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2] &= tmp;
              break;
    case  15:  buf0[0]  = 0;
              buf0[1]  = 0;
              buf0[2]  = 0;
              buf0[3]  = 0;
              buf1[0]  = 0;
              buf1[1]  = 0;
              buf1[2]  = 0;
              buf1[3]  = 0;
              buf2[0]  = 0;
              buf2[1]  = 0;
              buf2[2]  = 0;
              buf2[3]  = 0;
              buf3[0]  = 0;
              buf3[1]  = 0;
              buf3[2]  = 0;
              buf3[3] &= tmp;
              break;
  }
}

DECLSPEC void lshift_block_optimized_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS const u32 *in1, PRIVATE_AS const u32 *in2, PRIVATE_AS const u32 *in3, PRIVATE_AS u32 *out0, PRIVATE_AS u32 *out1, PRIVATE_AS u32 *out2, PRIVATE_AS u32 *out3)
{
  out0[0] = hc_2bytesalign_S (in0[0], in0[1], 2);
  out0[1] = hc_2bytesalign_S (in0[1], in0[2], 2);
  out0[2] = hc_2bytesalign_S (in0[2], in0[3], 2);
  out0[3] = hc_2bytesalign_S (in0[3], in1[0], 2);
  out1[0] = hc_2bytesalign_S (in1[0], in1[1], 2);
  out1[1] = hc_2bytesalign_S (in1[1], in1[2], 2);
  out1[2] = hc_2bytesalign_S (in1[2], in1[3], 2);
  out1[3] = hc_2bytesalign_S (in1[3], in2[0], 2);
  out2[0] = hc_2bytesalign_S (in2[0], in2[1], 2);
  out2[1] = hc_2bytesalign_S (in2[1], in2[2], 2);
  out2[2] = hc_2bytesalign_S (in2[2], in2[3], 2);
  out2[3] = hc_2bytesalign_S (in2[3], in3[0], 2);
  out3[0] = hc_2bytesalign_S (in3[0], in3[1], 2);
  out3[1] = hc_2bytesalign_S (in3[1], in3[2], 2);
  out3[2] = hc_2bytesalign_S (in3[2], in3[3], 2);
  out3[3] = hc_2bytesalign_S (in3[3],      0, 2);
}

DECLSPEC void rshift_block_optimized_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS const u32 *in1, PRIVATE_AS const u32 *in2, PRIVATE_AS const u32 *in3, PRIVATE_AS u32 *out0, PRIVATE_AS u32 *out1, PRIVATE_AS u32 *out2, PRIVATE_AS u32 *out3)
{
  out3[3] = hc_2bytesalign_S (in3[2], in3[3], 2);
  out3[2] = hc_2bytesalign_S (in3[1], in3[2], 2);
  out3[1] = hc_2bytesalign_S (in3[0], in3[1], 2);
  out3[0] = hc_2bytesalign_S (in2[3], in3[0], 2);
  out2[3] = hc_2bytesalign_S (in2[2], in2[3], 2);
  out2[2] = hc_2bytesalign_S (in2[1], in2[2], 2);
  out2[1] = hc_2bytesalign_S (in2[0], in2[1], 2);
  out2[0] = hc_2bytesalign_S (in1[3], in2[0], 2);
  out1[3] = hc_2bytesalign_S (in1[2], in1[3], 2);
  out1[2] = hc_2bytesalign_S (in1[1], in1[2], 2);
  out1[1] = hc_2bytesalign_S (in1[0], in1[1], 2);
  out1[0] = hc_2bytesalign_S (in0[3], in1[0], 2);
  out0[3] = hc_2bytesalign_S (in0[2], in0[3], 2);
  out0[2] = hc_2bytesalign_S (in0[1], in0[2], 2);
  out0[1] = hc_2bytesalign_S (in0[0], in0[1], 2);
  out0[0] = hc_2bytesalign_S (     0, in0[0], 2);
}

DECLSPEC void lshift_block_optimized_N_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS const u32 *in1, PRIVATE_AS const u32 *in2, PRIVATE_AS const u32 *in3, PRIVATE_AS u32 *out0, PRIVATE_AS u32 *out1, PRIVATE_AS u32 *out2, PRIVATE_AS u32 *out3, const u32 num)
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
              out2[0] = in2[0];
              out2[1] = in2[1];
              out2[2] = in2[2];
              out2[3] = in2[3];
              out3[0] = in3[0];
              out3[1] = in3[1];
              out3[2] = in3[2];
              out3[3] = in3[3];
              break;
    case  2:  out0[0] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out0[1] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out0[2] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out0[3] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out1[0] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out1[1] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out1[2] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out1[3] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out0[0] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out0[1] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out0[2] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out0[3] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out1[0] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out1[1] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out1[2] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out1[3] = hc_2bytesalign_S (in3[3],      0, 2);
              break;
    case  4:  out0[0] = in0[1];
              out0[1] = in0[2];
              out0[2] = in0[3];
              out0[3] = in1[0];
              out1[0] = in1[1];
              out1[1] = in1[2];
              out1[2] = in1[3];
              out1[3] = in2[0];
              out2[0] = in2[1];
              out2[1] = in2[2];
              out2[2] = in2[3];
              out2[3] = in3[0];
              out3[0] = in3[1];
              out3[1] = in3[2];
              out3[2] = in3[3];
              out3[3] = 0;
              break;
    case  6:  out0[0] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out0[1] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out0[2] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out0[3] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out1[0] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out1[1] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out1[2] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out1[3] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out2[0] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out2[1] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out2[2] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out2[3] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out2[0] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out2[1] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out2[2] = hc_2bytesalign_S (in3[3],      0, 2);
              out2[3] = 0;
              break;
    case  8:  out0[0] = in0[2];
              out0[1] = in0[3];
              out0[2] = in1[0];
              out0[3] = in1[1];
              out1[0] = in1[2];
              out1[1] = in1[3];
              out1[2] = in2[0];
              out1[3] = in2[1];
              out2[0] = in2[2];
              out2[1] = in2[3];
              out2[2] = in3[0];
              out2[3] = in3[1];
              out3[0] = in3[2];
              out3[1] = in3[3];
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  10:  out0[0] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out0[1] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out0[2] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out0[3] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out1[0] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out1[1] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out1[2] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out1[3] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out2[0] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out2[1] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out2[2] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out2[3] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out3[0] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out3[1] = hc_2bytesalign_S (in3[3],      0, 2);
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  12:  out0[0] = in0[3];
              out0[1] = in1[0];
              out0[2] = in1[1];
              out0[3] = in1[2];
              out1[0] = in1[3];
              out1[1] = in2[0];
              out1[2] = in2[1];
              out1[3] = in2[2];
              out2[0] = in2[3];
              out2[1] = in3[0];
              out2[2] = in3[1];
              out2[3] = in3[2];
              out3[0] = in3[3];
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  14:  out0[0] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out0[1] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out0[2] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out0[3] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out1[0] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out1[1] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out1[2] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out1[3] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out2[0] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out2[1] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out2[2] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out2[3] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out3[0] = hc_2bytesalign_S (in3[3],      0, 2);
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  16:  out0[0] = in1[0];
              out0[1] = in1[1];
              out0[2] = in1[2];
              out0[3] = in1[3];
              out1[0] = in2[0];
              out1[1] = in2[1];
              out1[2] = in2[2];
              out1[3] = in2[3];
              out2[0] = in3[0];
              out2[1] = in3[1];
              out2[2] = in3[2];
              out2[3] = in3[3];
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  18:  out0[0] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out0[1] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out0[2] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out0[3] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out1[0] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out1[1] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out1[2] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out1[3] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out2[0] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out2[1] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out2[2] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out2[3] = hc_2bytesalign_S (in3[3],      0, 2);
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 20:  out0[0] = in1[1];
              out0[1] = in1[2];
              out0[2] = in1[3];
              out0[3] = in2[0];
              out1[0] = in2[1];
              out1[1] = in2[2];
              out1[2] = in2[3];
              out1[3] = in3[0];
              out2[0] = in3[1];
              out2[1] = in3[2];
              out2[2] = in3[3];
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 22:  out0[0] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out0[1] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out0[2] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out0[3] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out1[0] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out1[1] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out1[2] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out1[3] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out2[0] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out2[1] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out2[2] = hc_2bytesalign_S (in3[3],      0, 2);
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 24:  out0[0] = in1[2];
              out0[1] = in1[3];
              out0[2] = in2[0];
              out0[3] = in2[1];
              out1[0] = in2[2];
              out1[1] = in2[3];
              out1[2] = in3[0];
              out1[3] = in3[1];
              out2[0] = in3[2];
              out2[1] = in3[3];
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 26:  out0[0] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out0[1] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out0[2] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out0[3] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out1[0] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out1[1] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out1[2] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out1[3] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out2[0] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out2[1] = hc_2bytesalign_S (in3[3],      0, 2);
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 28:  out0[0] = in1[3];
              out0[1] = in2[0];
              out0[2] = in2[1];
              out0[3] = in2[2];
              out1[0] = in2[3];
              out1[1] = in3[0];
              out1[2] = in3[1];
              out1[3] = in3[2];
              out2[0] = in3[3];
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 30:  out0[0] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out0[1] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out0[2] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out0[3] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out1[0] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out1[1] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out1[2] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out1[3] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out2[0] = hc_2bytesalign_S (in3[3],      0, 2);
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  32: out0[0] = in2[0];
              out0[1] = in2[1];
              out0[2] = in2[2];
              out0[3] = in2[3];
              out1[0] = in3[0];
              out1[1] = in3[1];
              out1[2] = in3[2];
              out1[3] = in3[3];
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  34: out0[0] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out0[1] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out0[2] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out0[3] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out1[0] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out1[1] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out1[2] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out1[3] = hc_2bytesalign_S (in3[3],      0, 2);
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  36: out0[0] = in2[1];
              out0[1] = in2[2];
              out0[2] = in2[3];
              out0[3] = in3[0];
              out1[0] = in3[1];
              out1[1] = in3[2];
              out1[2] = in3[3];
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  38: out0[0] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out0[1] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out0[2] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out0[3] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out1[0] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out1[1] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out1[2] = hc_2bytesalign_S (in3[3],      0, 2);
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  40: out0[0] = in2[2];
              out0[1] = in2[3];
              out0[2] = in3[0];
              out0[3] = in3[1];
              out1[0] = in3[2];
              out1[1] = in3[3];
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  42: out0[0] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out0[1] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out0[2] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out0[3] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out1[0] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out1[1] = hc_2bytesalign_S (in3[3],      0, 2);
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  44: out0[0] = in2[3];
              out0[1] = in3[0];
              out0[2] = in3[1];
              out0[3] = in3[2];
              out1[0] = in3[3];
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  46: out0[0] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out0[1] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out0[2] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out0[3] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out1[0] = hc_2bytesalign_S (in3[3],      0, 2);
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  48: out0[0] = in3[0];
              out0[1] = in3[1];
              out0[2] = in3[2];
              out0[3] = in3[3];
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case  50: out0[0] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out0[1] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out0[2] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out0[3] = hc_2bytesalign_S (in3[3],      0, 2);
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 52:  out0[0] = in3[1];
              out0[1] = in3[2];
              out0[2] = in3[3];
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 54:  out0[0] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out0[1] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out0[2] = hc_2bytesalign_S (in3[3],      0, 2);
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 56:  out0[0] = in3[2];
              out0[1] = in3[3];
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 58:  out0[0] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out0[1] = hc_2bytesalign_S (in3[3],      0, 2);
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 60:  out0[0] = in3[3];
              out0[1] = 0;
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
    case 62:  out0[0] = hc_2bytesalign_S (in3[3],      0, 2);
              out0[1] = 0;
              out0[2] = 0;
              out0[3] = 0;
              out1[0] = 0;
              out1[1] = 0;
              out1[2] = 0;
              out1[3] = 0;
              out2[0] = 0;
              out2[1] = 0;
              out2[2] = 0;
              out2[3] = 0;
              out3[0] = 0;
              out3[1] = 0;
              out3[2] = 0;
              out3[3] = 0;
              break;
  }
}

DECLSPEC void rshift_block_optimized_N_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS const u32 *in1, PRIVATE_AS const u32 *in2, PRIVATE_AS const u32 *in3, PRIVATE_AS u32 *out0, PRIVATE_AS u32 *out1, PRIVATE_AS u32 *out2, PRIVATE_AS u32 *out3, const u32 num)
{
  switch (num)
  {
    case  0:  out3[3] = in3[3];
              out3[2] = in3[2];
              out3[1] = in3[1];
              out3[0] = in3[0];
              out2[3] = in2[3];
              out2[2] = in2[2];
              out2[1] = in2[1];
              out2[0] = in2[0];
              out1[3] = in1[3];
              out1[2] = in1[2];
              out1[1] = in1[1];
              out1[0] = in1[0];
              out0[3] = in0[3];
              out0[2] = in0[2];
              out0[1] = in0[1];
              out0[0] = in0[0];
              break;
    case  2:  out3[3] = hc_2bytesalign_S (in3[2], in3[3], 2);
              out3[2] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out3[1] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out3[0] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out2[3] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out2[2] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out2[1] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out2[0] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out1[3] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out1[2] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out1[1] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out1[0] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out0[3] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out0[2] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out0[1] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out0[0] = hc_2bytesalign_S (     0, in0[0], 2);
              break;
    case  4:  out3[3] = in3[2];
              out3[2] = in3[1];
              out3[1] = in3[0];
              out3[0] = in2[3];
              out2[3] = in2[2];
              out2[2] = in2[1];
              out2[1] = in2[0];
              out2[0] = in1[3];
              out1[3] = in1[2];
              out1[2] = in1[1];
              out1[1] = in1[0];
              out1[0] = in0[3];
              out0[3] = in0[2];
              out0[2] = in0[1];
              out0[1] = in0[0];
              out0[0] = 0;
              break;
    case  6:  out3[3] = hc_2bytesalign_S (in3[1], in3[2], 2);
              out3[2] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out3[1] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out3[0] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out2[3] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out2[2] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out2[1] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out2[0] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out1[3] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out1[2] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out1[1] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out1[0] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out0[3] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out0[2] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out0[1] = hc_2bytesalign_S (     0, in0[0], 2);
              out0[0] = 0;
              break;
    case  8:  out3[3] = in3[1];
              out3[2] = in3[0];
              out3[1] = in2[3];
              out3[0] = in2[2];
              out2[3] = in2[1];
              out2[2] = in2[0];
              out2[1] = in1[3];
              out2[0] = in1[2];
              out1[3] = in1[1];
              out1[2] = in1[0];
              out1[1] = in0[3];
              out1[0] = in0[2];
              out0[3] = in0[1];
              out0[2] = in0[0];
              out0[1] = 0;
              out0[0] = 0;
              break;
    case  10: out3[3] = hc_2bytesalign_S (in3[0], in3[1], 2);
              out3[2] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out3[1] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out3[0] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out2[3] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out2[2] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out2[1] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out2[0] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out1[3] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out1[2] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out1[1] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out1[0] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out0[3] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out0[2] = hc_2bytesalign_S (     0, in0[0], 2);
              out0[1] = 0;
              out0[0] = 0;
              break;
    case  12:  out3[3] = in3[0];
              out3[2] = in2[3];
              out3[1] = in2[2];
              out3[0] = in2[1];
              out2[3] = in2[0];
              out2[2] = in1[3];
              out2[1] = in1[2];
              out2[0] = in1[1];
              out1[3] = in1[0];
              out1[2] = in0[3];
              out1[1] = in0[2];
              out1[0] = in0[1];
              out0[3] = in0[0];
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case  14: out3[3] = hc_2bytesalign_S (in2[3], in3[0], 2);
              out3[2] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out3[1] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out3[0] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out2[3] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out2[2] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out2[1] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out2[0] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out1[3] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out1[2] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out1[1] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out1[0] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out0[3] = hc_2bytesalign_S (     0, in0[0], 2);
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case  16: out3[3] = in2[3];
              out3[2] = in2[2];
              out3[1] = in2[1];
              out3[0] = in2[0];
              out2[3] = in1[3];
              out2[2] = in1[2];
              out2[1] = in1[1];
              out2[0] = in1[0];
              out1[3] = in0[3];
              out1[2] = in0[2];
              out1[1] = in0[1];
              out1[0] = in0[0];
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case  18: out3[3] = hc_2bytesalign_S (in2[2], in2[3], 2);
              out3[2] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out3[1] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out3[0] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out2[3] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out2[2] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out2[1] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out2[0] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out1[3] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out1[2] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out1[1] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out1[0] = hc_2bytesalign_S (     0, in0[0], 2);
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 20:  out3[3] = in2[2];
              out3[2] = in2[1];
              out3[1] = in2[0];
              out3[0] = in1[3];
              out2[3] = in1[2];
              out2[2] = in1[1];
              out2[1] = in1[0];
              out2[0] = in0[3];
              out1[3] = in0[2];
              out1[2] = in0[1];
              out1[1] = in0[0];
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 22:  out3[3] = hc_2bytesalign_S (in2[1], in2[2], 2);
              out3[2] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out3[1] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out3[0] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out2[3] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out2[2] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out2[1] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out2[0] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out1[3] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out1[2] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out1[1] = hc_2bytesalign_S (     0, in0[0], 2);
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 24:  out3[3] = in2[1];
              out3[2] = in2[0];
              out3[1] = in1[3];
              out3[0] = in1[2];
              out2[3] = in1[1];
              out2[2] = in1[0];
              out2[1] = in0[3];
              out2[0] = in0[2];
              out1[3] = in0[1];
              out1[2] = in0[0];
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 26:  out3[3] = hc_2bytesalign_S (in2[0], in2[1], 2);
              out3[2] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out3[1] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out3[0] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out2[3] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out2[2] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out2[1] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out2[0] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out1[3] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out1[2] = hc_2bytesalign_S (     0, in0[0], 2);
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 28:  out3[3] = in2[0];
              out3[2] = in1[3];
              out3[1] = in1[2];
              out3[0] = in1[1];
              out2[3] = in1[0];
              out2[2] = in0[3];
              out2[1] = in0[2];
              out2[0] = in0[1];
              out1[3] = in0[0];
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 30:  out3[3] = hc_2bytesalign_S (in1[3], in2[0], 2);
              out3[2] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out3[1] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out3[0] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out2[3] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out2[2] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out2[1] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out2[0] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out1[3] = hc_2bytesalign_S (     0, in0[0], 2);
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
    case 32:  out3[3] = in1[3];
              out3[2] = in1[2];
              out3[1] = in1[1];
              out3[0] = in1[0];
              out2[3] = in0[3];
              out2[2] = in0[2];
              out2[1] = in0[1];
              out2[0] = in0[0];
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 34:    out3[3] = hc_2bytesalign_S (in1[2], in1[3], 2);
              out3[2] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out3[1] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out3[0] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out2[3] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out2[2] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out2[1] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out2[0] = hc_2bytesalign_S (     0, in0[0], 2);
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 36:    out3[3] = in1[2];
              out3[2] = in1[1];
              out3[1] = in1[0];
              out3[0] = in0[3];
              out2[3] = in0[2];
              out2[2] = in0[1];
              out2[1] = in0[0];
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 38:    out3[3] = hc_2bytesalign_S (in1[1], in1[2], 2);
              out3[2] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out3[1] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out3[0] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out2[3] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out2[2] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out2[1] = hc_2bytesalign_S (     0, in0[0], 2);
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 40:    out3[3] = in1[1];
              out3[2] = in1[0];
              out3[1] = in0[3];
              out3[0] = in0[2];
              out2[3] = in0[1];
              out2[2] = in0[0];
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 42:    out3[3] = hc_2bytesalign_S (in1[0], in1[1], 2);
              out3[2] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out3[1] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out3[0] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out2[3] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out2[2] = hc_2bytesalign_S (     0, in0[0], 2);
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 44:    out3[3] = in1[0];
              out3[2] = in0[3];
              out3[1] = in0[2];
              out3[0] = in0[1];
              out2[3] = in0[0];
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 46:    out3[3] = hc_2bytesalign_S (in0[3], in1[0], 2);
              out3[2] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out3[1] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out3[0] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out2[3] = hc_2bytesalign_S (     0, in0[0], 2);
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 48:    out3[3] = in0[3];
              out3[2] = in0[2];
              out3[1] = in0[1];
              out3[0] = in0[0];
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
 case 50:     out3[3] = hc_2bytesalign_S (in0[2], in0[3], 2);
              out3[2] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out3[1] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out3[0] = hc_2bytesalign_S (     0, in0[0], 2);
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 52:    out3[3] = in0[2];
              out3[2] = in0[1];
              out3[1] = in0[0];
              out3[0] = 0;
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 54:    out3[3] = hc_2bytesalign_S (in0[1], in0[2], 2);
              out3[2] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out3[1] = hc_2bytesalign_S (     0, in0[0], 2);
              out3[0] = 0;
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 56:    out3[3] = in0[1];
              out3[2] = in0[0];
              out3[1] = 0;
              out3[0] = 0;
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
 case 58:     out3[3] = hc_2bytesalign_S (in0[0], in0[1], 2);
              out3[2] = hc_2bytesalign_S (     0, in0[0], 2);
              out3[1] = 0;
              out3[0] = 0;
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 60:    out3[3] = in0[0];
              out3[2] = 0;
              out3[1] = 0;
              out3[0] = 0;
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
              out1[2] = 0;
              out1[1] = 0;
              out1[0] = 0;
              out0[3] = 0;
              out0[2] = 0;
              out0[1] = 0;
              out0[0] = 0;
              break;
  case 62:    out3[3] = hc_2bytesalign_S (     0, in0[0], 2);
              out3[2] = 0;
              out3[1] = 0;
              out3[0] = 0;
              out2[3] = 0;
              out2[2] = 0;
              out2[1] = 0;
              out2[0] = 0;
              out1[3] = 0;
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

DECLSPEC void append_block1_optimized_utf16le (const u32 offset, PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, PRIVATE_AS u32 *buf2, PRIVATE_AS u32 *buf3, const u32 src_r0)
{
  // this version works with 2 bytes append only
  const u32 value = src_r0 & 0xffff;

  const u32 tmp = value <<  0
                | value <<  16;

  u32 v[4];

  set_mark_1x4_S_16 (v, offset); 

  const u32 offset8 = offset / 16;
  append_helper_1x4_S (buf0, ((offset8 == 0) ? tmp : 0), v);   
  append_helper_1x4_S (buf1, ((offset8 == 1) ? tmp : 0), v);
  append_helper_1x4_S (buf2, ((offset8 == 2) ? tmp : 0), v);   
  append_helper_1x4_S (buf3, ((offset8 == 3) ? tmp : 0), v); 
}

DECLSPEC void append_block8_optimized_utf16le (const u32 offset, PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, PRIVATE_AS u32 *buf2, PRIVATE_AS u32 *buf3, PRIVATE_AS const u32 *src_l0, PRIVATE_AS const u32 *src_l1, PRIVATE_AS const u32 *src_l2, PRIVATE_AS const u32 *src_l3, PRIVATE_AS const u32 *src_r0, PRIVATE_AS const u32 *src_r1, PRIVATE_AS const u32 *src_r2, PRIVATE_AS const u32 *src_r3) // fixed , check perf todo
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

  const int offset_switch = offset / 4;

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
      s15 = hc_2bytesalign_S (src_r32, src_r33, offset);
      s14 = hc_2bytesalign_S (src_r31, src_r32, offset);
      s13 = hc_2bytesalign_S (src_r30, src_r31, offset);
      s12 = hc_2bytesalign_S (src_r23, src_r30, offset);
      s11 = hc_2bytesalign_S (src_r22, src_r23, offset);
      s10 = hc_2bytesalign_S (src_r21, src_r22, offset);
      s9 =  hc_2bytesalign_S (src_r20, src_r21, offset);
      s8 =  hc_2bytesalign_S (src_r13, src_r20, offset);
      s7 =  hc_2bytesalign_S (src_r12, src_r13, offset);
      s6 =  hc_2bytesalign_S (src_r11, src_r12, offset);
      s5 =  hc_2bytesalign_S (src_r10, src_r11, offset);
      s4 =  hc_2bytesalign_S (src_r03, src_r10, offset);
      s3 =  hc_2bytesalign_S (src_r02, src_r03, offset);
      s2 =  hc_2bytesalign_S (src_r01, src_r02, offset);
      s1 =  hc_2bytesalign_S (src_r00, src_r01, offset);
      s0 =  hc_2bytesalign_S (      0, src_r00, offset);
      break;

    case 1:
      s15 = hc_2bytesalign_S (src_r31, src_r32, offset);
      s14 = hc_2bytesalign_S (src_r30, src_r31, offset);
      s13 = hc_2bytesalign_S (src_r23, src_r30, offset);
      s12 = hc_2bytesalign_S (src_r22, src_r23, offset);
      s11 = hc_2bytesalign_S (src_r21, src_r22, offset);
      s10 = hc_2bytesalign_S (src_r20, src_r21, offset);
      s9 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s8 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s7 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s6 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s5 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s4 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s3 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s2 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s1 = hc_2bytesalign_S (      0, src_r00, offset);
      s0 = 0;
      break;

    case 2:
      s15 = hc_2bytesalign_S (src_r30, src_r31, offset);
      s14 = hc_2bytesalign_S (src_r23, src_r30, offset);
      s13 = hc_2bytesalign_S (src_r22, src_r23, offset);
      s12 = hc_2bytesalign_S (src_r21, src_r22, offset);
      s11 = hc_2bytesalign_S (src_r20, src_r21, offset);
      s10 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s9 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s8 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s7 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s6 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s5 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s4 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s3 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s2 = hc_2bytesalign_S (      0, src_r00, offset);
      s1 = 0;
      s0 = 0;
      break;

    case 3:
      s15 = hc_2bytesalign_S (src_r23, src_r30, offset);
      s14 = hc_2bytesalign_S (src_r22, src_r23, offset);
      s13 = hc_2bytesalign_S (src_r21, src_r22, offset);
      s12 = hc_2bytesalign_S (src_r20, src_r21, offset);
      s11 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s10 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s9 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s8 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s7 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s6 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s5 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s4 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s3 = hc_2bytesalign_S (      0, src_r00, offset);
      s2 = 0;
      s1 = 0;
      s0 = 0;

      break;

    case 4:
      s15 = hc_2bytesalign_S (src_r22, src_r23, offset);
      s14 = hc_2bytesalign_S (src_r21, src_r22, offset);
      s13 = hc_2bytesalign_S (src_r20, src_r21, offset);
      s12 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s11 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s10 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s9 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s8 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s7 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s6 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s5 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s4 = hc_2bytesalign_S (      0, src_r00, offset);
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 5:
      s15 = hc_2bytesalign_S (src_r21, src_r22, offset);
      s14 = hc_2bytesalign_S (src_r20, src_r21, offset);
      s13 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s12 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s11 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s10 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s9 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s8 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s7 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s6 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s5 = hc_2bytesalign_S (      0, src_r00, offset);
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 6:
      s15 = hc_2bytesalign_S (src_r20, src_r21, offset);
      s14 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s13 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s12 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s11 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s10 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s9 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s8 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s7 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s6 = hc_2bytesalign_S (      0, src_r00, offset);
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 7:
      s15 = hc_2bytesalign_S (src_r13, src_r20, offset);
      s14 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s13 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s12 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s11 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s10 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s9 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s8 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s7 = hc_2bytesalign_S (      0, src_r00, offset);
      s6 = 0;
      s5 = 0;
      s4 = 0;
      s3 = 0;
      s2 = 0;
      s1 = 0;
      s0 = 0;
      break;

    case 8:
      s15 = hc_2bytesalign_S (src_r12, src_r13, offset);
      s14 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s13 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s12 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s11 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s10 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s9 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s8 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (src_r11, src_r12, offset);
      s14 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s13 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s12 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s11 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s10 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s9 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (src_r10, src_r11, offset);
      s14 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s13 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s12 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s11 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s10 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (src_r03, src_r10, offset);
      s14 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s13 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s12 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s11 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (src_r02, src_r03, offset);
      s14 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s13 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s12 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (src_r01, src_r02, offset);
      s14 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s13 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (src_r00, src_r01, offset);
      s14 = hc_2bytesalign_S (      0, src_r00, offset);
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
      s15 = hc_2bytesalign_S (      0, src_r00, offset);
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

  buf0[0] = src_l0[0] | s0;
  buf0[1] = src_l0[1] | s1;
  buf0[2] = src_l0[2] | s2;
  buf0[3] = src_l0[3] | s3;
  buf1[0] = src_l1[0] | s4;
  buf1[1] = src_l1[1] | s5;
  buf1[2] = src_l1[2] | s6;
  buf1[3] = src_l1[3] | s7;
  buf2[0] = src_l2[0] | s8;
  buf2[1] = src_l2[1] | s9;
  buf2[2] = src_l2[2] | s10;
  buf2[3] = src_l2[3] | s11;
  buf3[0] = src_l3[0] | s12;
  buf3[1] = src_l3[1] | s13;
  buf3[2] = src_l3[2] | s14;
  buf3[3] = src_l3[3] | s15;
}

DECLSPEC void reverse_block_optimized_utf16le (PRIVATE_AS u32 *in0, PRIVATE_AS u32 *in1, PRIVATE_AS u32 *in2, PRIVATE_AS u32 *in3, PRIVATE_AS u32 *out0, PRIVATE_AS u32 *out1, PRIVATE_AS u32 *out2, PRIVATE_AS u32 *out3, const u32 len)
{
  rshift_block_optimized_N_utf16le (in0, in1, in2, in3, out0, out1, out2, out3, 64 - len);

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  tib40[0] = out3[3];
  tib40[1] = out3[2];
  tib40[2] = out3[1];
  tib40[3] = out3[0];
  tib41[0] = out2[3];
  tib41[1] = out2[2];
  tib41[2] = out2[1];
  tib41[3] = out2[0];
  tib42[0] = out1[3];
  tib42[1] = out1[2];
  tib42[2] = out1[1];
  tib42[3] = out1[0];
  tib43[0] = out0[3];
  tib43[1] = out0[2];
  tib43[2] = out0[1];
  tib43[3] = out0[0];

  out0[0] = hc_2bytesalign_S (tib40[0],tib40[0],2);
  out0[1] = hc_2bytesalign_S (tib40[1],tib40[1],2);
  out0[2] = hc_2bytesalign_S (tib40[2],tib40[2],2);
  out0[3] = hc_2bytesalign_S (tib40[3],tib40[3],2);
  out1[0] = hc_2bytesalign_S (tib41[0],tib41[0],2);
  out1[1] = hc_2bytesalign_S (tib41[1],tib41[1],2);
  out1[2] = hc_2bytesalign_S (tib41[2],tib41[2],2);
  out1[3] = hc_2bytesalign_S (tib41[3],tib41[3],2);  
  out2[0] = hc_2bytesalign_S (tib42[0],tib42[0],2); 
  out2[1] = hc_2bytesalign_S (tib42[1],tib42[1],2);
  out2[2] = hc_2bytesalign_S (tib42[2],tib42[2],2);
  out2[3] = hc_2bytesalign_S (tib42[3],tib42[3],2);
  out3[0] = hc_2bytesalign_S (tib43[0],tib43[0],2);
  out3[1] = hc_2bytesalign_S (tib43[1],tib43[1],2);
  out3[2] = hc_2bytesalign_S (tib43[2],tib43[2],2);
  out3[3] = hc_2bytesalign_S (tib43[3],tib43[3],2);  

}

DECLSPEC void exchange_byte_optimized_utf16le (PRIVATE_AS u32 *buf, const int off_src, const int off_dst)
{
  PRIVATE_AS u16 *ptr = (PRIVATE_AS u16 *) buf; 

  const u16 tmp = ptr[off_src];

  ptr[off_src] = ptr[off_dst];
  ptr[off_dst] = tmp;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 t;

  t = buf0[0]; buf0[0] = t | generate_cmask_utf16le(t);
  t = buf0[1]; buf0[1] = t | generate_cmask_utf16le(t);
  t = buf0[2]; buf0[2] = t | generate_cmask_utf16le(t);
  t = buf0[3]; buf0[3] = t | generate_cmask_utf16le(t);
  t = buf1[0]; buf1[0] = t | generate_cmask_utf16le(t);
  t = buf1[1]; buf1[1] = t | generate_cmask_utf16le(t);
  t = buf1[2]; buf1[2] = t | generate_cmask_utf16le(t);
  t = buf1[3]; buf1[3] = t | generate_cmask_utf16le(t);
  t = buf2[0]; buf2[0] = t | generate_cmask_utf16le(t);
  t = buf2[1]; buf2[1] = t | generate_cmask_utf16le(t);
  t = buf2[2]; buf2[2] = t | generate_cmask_utf16le(t);
  t = buf2[3]; buf2[3] = t | generate_cmask_utf16le(t);
  t = buf3[0]; buf3[0] = t | generate_cmask_utf16le(t);
  t = buf3[1]; buf3[1] = t | generate_cmask_utf16le(t);
  t = buf3[2]; buf3[2] = t | generate_cmask_utf16le(t);
  t = buf3[3]; buf3[3] = t | generate_cmask_utf16le(t);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 t;

  t = buf0[0]; buf0[0] = t & ~(generate_cmask_utf16le(t));
  t = buf0[1]; buf0[1] = t & ~(generate_cmask_utf16le(t));
  t = buf0[2]; buf0[2] = t & ~(generate_cmask_utf16le(t));
  t = buf0[3]; buf0[3] = t & ~(generate_cmask_utf16le(t));
  t = buf1[0]; buf1[0] = t & ~(generate_cmask_utf16le(t));
  t = buf1[1]; buf1[1] = t & ~(generate_cmask_utf16le(t));
  t = buf1[2]; buf1[2] = t & ~(generate_cmask_utf16le(t));
  t = buf1[3]; buf1[3] = t & ~(generate_cmask_utf16le(t));
  t = buf2[0]; buf2[0] = t & ~(generate_cmask_utf16le(t));
  t = buf2[1]; buf2[1] = t & ~(generate_cmask_utf16le(t));
  t = buf2[2]; buf2[2] = t & ~(generate_cmask_utf16le(t));
  t = buf2[3]; buf2[3] = t & ~(generate_cmask_utf16le(t));
  t = buf3[0]; buf3[0] = t & ~(generate_cmask_utf16le(t));
  t = buf3[1]; buf3[1] = t & ~(generate_cmask_utf16le(t));
  t = buf3[2]; buf3[2] = t & ~(generate_cmask_utf16le(t));
  t = buf3[3]; buf3[3] = t & ~(generate_cmask_utf16le(t));

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_ufirst_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 t;

  t = buf0[0]; buf0[0] = t | generate_cmask_utf16le(t);
  t = buf0[1]; buf0[1] = t | generate_cmask_utf16le(t);
  t = buf0[2]; buf0[2] = t | generate_cmask_utf16le(t);
  t = buf0[3]; buf0[3] = t | generate_cmask_utf16le(t);
  t = buf1[0]; buf1[0] = t | generate_cmask_utf16le(t);
  t = buf1[1]; buf1[1] = t | generate_cmask_utf16le(t);
  t = buf1[2]; buf1[2] = t | generate_cmask_utf16le(t);
  t = buf1[3]; buf1[3] = t | generate_cmask_utf16le(t);
  t = buf2[0]; buf2[0] = t | generate_cmask_utf16le(t);
  t = buf2[1]; buf2[1] = t | generate_cmask_utf16le(t);
  t = buf2[2]; buf2[2] = t | generate_cmask_utf16le(t);
  t = buf2[3]; buf2[3] = t | generate_cmask_utf16le(t);
  t = buf3[0]; buf3[0] = t | generate_cmask_utf16le(t);
  t = buf3[1]; buf3[1] = t | generate_cmask_utf16le(t);
  t = buf3[2]; buf3[2] = t | generate_cmask_utf16le(t);
  t = buf3[3]; buf3[3] = t | generate_cmask_utf16le(t);

  t = buf0[0]; buf0[0] = t & ~(0x00000020 & generate_cmask_utf16le(t));

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_lfirst_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 t;

  t = buf0[0]; buf0[0] = t & ~(generate_cmask_utf16le(t));
  t = buf0[1]; buf0[1] = t & ~(generate_cmask_utf16le(t));
  t = buf0[2]; buf0[2] = t & ~(generate_cmask_utf16le(t));
  t = buf0[3]; buf0[3] = t & ~(generate_cmask_utf16le(t));
  t = buf1[0]; buf1[0] = t & ~(generate_cmask_utf16le(t));
  t = buf1[1]; buf1[1] = t & ~(generate_cmask_utf16le(t));
  t = buf1[2]; buf1[2] = t & ~(generate_cmask_utf16le(t));
  t = buf1[3]; buf1[3] = t & ~(generate_cmask_utf16le(t));
  t = buf2[0]; buf2[0] = t & ~(generate_cmask_utf16le(t));
  t = buf2[1]; buf2[1] = t & ~(generate_cmask_utf16le(t));
  t = buf2[2]; buf2[2] = t & ~(generate_cmask_utf16le(t));
  t = buf2[3]; buf2[3] = t & ~(generate_cmask_utf16le(t));
  t = buf3[0]; buf3[0] = t & ~(generate_cmask_utf16le(t));
  t = buf3[1]; buf3[1] = t & ~(generate_cmask_utf16le(t));
  t = buf3[2]; buf3[2] = t & ~(generate_cmask_utf16le(t));
  t = buf3[3]; buf3[3] = t & ~(generate_cmask_utf16le(t));

  t = buf0[0]; buf0[0] = t | (0x00000020 & generate_cmask_utf16le(t));

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_trest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 t;

  t = buf0[0]; buf0[0] = t ^ generate_cmask_utf16le(t);
  t = buf0[1]; buf0[1] = t ^ generate_cmask_utf16le(t);
  t = buf0[2]; buf0[2] = t ^ generate_cmask_utf16le(t);
  t = buf0[3]; buf0[3] = t ^ generate_cmask_utf16le(t);
  t = buf1[0]; buf1[0] = t ^ generate_cmask_utf16le(t);
  t = buf1[1]; buf1[1] = t ^ generate_cmask_utf16le(t);
  t = buf1[2]; buf1[2] = t ^ generate_cmask_utf16le(t);
  t = buf1[3]; buf1[3] = t ^ generate_cmask_utf16le(t);
  t = buf2[0]; buf2[0] = t ^ generate_cmask_utf16le(t);
  t = buf2[1]; buf2[1] = t ^ generate_cmask_utf16le(t);
  t = buf2[2]; buf2[2] = t ^ generate_cmask_utf16le(t);
  t = buf2[3]; buf2[3] = t ^ generate_cmask_utf16le(t);
  t = buf3[0]; buf3[0] = t ^ generate_cmask_utf16le(t);
  t = buf3[1]; buf3[1] = t ^ generate_cmask_utf16le(t);
  t = buf3[2]; buf3[2] = t ^ generate_cmask_utf16le(t);
  t = buf3[3]; buf3[3] = t ^ generate_cmask_utf16le(t);

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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  if (p0 >= in_len) return in_len;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];
  
  const u32 tmp = t[p0 / 4];

  const u32 m = 0x0020u << ((p0 & 2u) * 8u);

  t[p0 / 4] = tmp ^ (m & generate_cmask_utf16le(tmp));

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_sep_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  if (in_len == 0) return in_len;

  u32 r0 = search_on_register_utf16le (buf0[0], p1);
  u32 r1 = search_on_register_utf16le (buf0[1], p1);
  u32 r2 = search_on_register_utf16le (buf0[2], p1);
  u32 r3 = search_on_register_utf16le (buf0[3], p1);
  u32 r4 = search_on_register_utf16le (buf1[0], p1);
  u32 r5 = search_on_register_utf16le (buf1[1], p1);
  u32 r6 = search_on_register_utf16le (buf1[2], p1);
  u32 r7 = search_on_register_utf16le (buf1[3], p1);
  u32 r8 = search_on_register_utf16le (buf2[0], p1);
  u32 r9 = search_on_register_utf16le (buf2[1], p1);
  u32 r10 = search_on_register_utf16le (buf2[2], p1);
  u32 r11 = search_on_register_utf16le (buf2[3], p1);
  u32 r12 = search_on_register_utf16le (buf3[0], p1);
  u32 r13 = search_on_register_utf16le (buf3[1], p1);
  u32 r14 = search_on_register_utf16le (buf3[2], p1);
  u32 r15 = search_on_register_utf16le (buf3[3], p1);

  const u32 rn = (r0 <<  0)
               | (r1 <<  2)
               | (r2 <<  4)
               | (r3 << 6)
               | (r4 << 8)
               | (r5 << 10)
               | (r6 << 12)
               | (r7 << 14)
               | (r8 << 16)
               | (r9 << 18)
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
      occurence++;
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
    }
  }

  r0 = (ro >>  0) & 0x0F;
  r1 = (ro >>  2) & 0x0F;
  r2 = (ro >>  4) & 0x0F;
  r3 = (ro >> 6) & 0x0F;
  r4 = (ro >> 8) & 0x0F;
  r5 = (ro >> 10) & 0x0F;
  r6 = (ro >> 12) & 0x0F;
  r7 = (ro >> 14) & 0x0F;
  r8 = (ro >> 16) & 0x0F;
  r9 = (ro >> 18) & 0x0F;
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

  buf0[0] = toggle_on_register_utf16le (buf0[0], r0);
  buf0[1] = toggle_on_register_utf16le (buf0[1], r1);
  buf0[2] = toggle_on_register_utf16le (buf0[2], r2);
  buf0[3] = toggle_on_register_utf16le (buf0[3], r3);
  buf1[0] = toggle_on_register_utf16le (buf1[0], r4);
  buf1[1] = toggle_on_register_utf16le (buf1[1], r5);
  buf1[2] = toggle_on_register_utf16le (buf1[2], r6);
  buf1[3] = toggle_on_register_utf16le (buf1[3], r7);
  buf2[0] = toggle_on_register_utf16le (buf2[0], r8);
  buf2[1] = toggle_on_register_utf16le (buf2[1], r9);
  buf2[2] = toggle_on_register_utf16le (buf2[2], r10);
  buf2[3] = toggle_on_register_utf16le (buf2[3], r11);
  buf3[0] = toggle_on_register_utf16le (buf3[0], r12);
  buf3[1] = toggle_on_register_utf16le (buf3[1], r13);
  buf3[2] = toggle_on_register_utf16le (buf3[2], r14);
  buf3[3] = toggle_on_register_utf16le (buf3[3], r15);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reverse_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  reverse_block_optimized_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;
  append_block8_optimized_utf16le (out_len, buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3);

  out_len += in_len;
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_times_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 p0_2 = p0/2u;

  if (((in_len * p0_2) + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  tib40[0] = buf0[0];
  tib40[1] = buf0[1];
  tib40[2] = buf0[2];
  tib40[3] = buf0[3];
  tib41[0] = buf1[0];
  tib41[1] = buf1[1];
  tib41[2] = buf1[2];
  tib41[3] = buf1[3];
  tib42[0] = buf2[0];
  tib42[1] = buf2[1];
  tib42[2] = buf2[2];
  tib42[3] = buf2[3];
  tib43[0] = buf3[0];
  tib43[1] = buf3[1];
  tib43[2] = buf3[2];
  tib43[3] = buf3[3];

  for (u32 i = 0; i < p0_2; i++)
  {
    append_block8_optimized_utf16le (out_len, buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43);

    out_len += in_len;
  }

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reflect_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)
{
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib40[4] = { 0 };
  u32 tib41[4] = { 0 };
  u32 tib42[4] = { 0 };
  u32 tib43[4] = { 0 };

  reverse_block_optimized_utf16le (buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43, out_len);

  append_block8_optimized_utf16le (out_len, buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43);

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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_append_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if ((in_len + 2) >= 64) return in_len;

  u32 out_len = in_len;

  append_block1_optimized_utf16le (out_len, buf0, buf1, buf2, buf3, p0);

  out_len += 2;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_prepend_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if ((in_len + 2) >= 32) return in_len;

  u32 out_len = in_len;

  rshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3);

  buf0[0] = buf0[0] | p0;

  out_len += 2;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_left_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 tmp = buf0[0];

  lshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3);

  append_block1_optimized_utf16le (in_len1, buf0, buf1, buf2, buf3, tmp);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_right_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 sh = (in_len1 & 2) * 8;

  u32 tmp = 0;

  u32 v[4];

  set_mark_1x4_S_16 (v, in_len1);
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
    
    case 2:
      tmp |= buf2[0] & v[0];
      tmp |= buf2[1] & v[1];
      tmp |= buf2[2] & v[2];
      tmp |= buf2[3] & v[3];
      break;
    
    case 3:
      tmp |= buf3[0] & v[0];
      tmp |= buf3[1] & v[1];
      tmp |= buf3[2] & v[2];
      tmp |= buf3[3] & v[3];
      break;
  }

  tmp = (tmp >> sh) & 0xffff;

  rshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3);

  buf0[0] |= tmp;

  truncate_right_optimized_utf16le (buf0, buf1, buf2, buf3, in_len);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  lshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3);

  return in_len1;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (in_len == 0) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 mask = (1 << ((in_len1 & 2) * 8)) - 1;
  buf0[0] &=                     (in_len1 <  4)  ? mask : 0xffffffff;
  buf0[1] &= ((in_len1 >=  4) && (in_len1 <  8)) ? mask : 0xffffffff;
  buf0[2] &= ((in_len1 >=  8) && (in_len1 < 12)) ? mask : 0xffffffff;
  buf0[3] &= ((in_len1 >=  12) && (in_len1 < 16)) ? mask : 0xffffffff;
  buf1[0] &= ((in_len1 >=  16) && (in_len1 < 20)) ? mask : 0xffffffff;
  buf1[1] &= ((in_len1 >=  20) && (in_len1 < 24)) ? mask : 0xffffffff;
  buf1[2] &= ((in_len1 >=  24) && (in_len1 < 28)) ? mask : 0xffffffff;
  buf1[3] &= ((in_len1 >=  28) && (in_len1 < 32)) ? mask : 0xffffffff;
  buf2[0] &= ((in_len1 >=  32) && (in_len1 < 36)) ? mask : 0xffffffff;
  buf2[1] &= ((in_len1 >=  36) && (in_len1 < 40)) ? mask : 0xffffffff;
  buf2[2] &= ((in_len1 >=  40) && (in_len1 < 44)) ? mask : 0xffffffff;
  buf2[3] &= ((in_len1 >=  44) && (in_len1 < 48)) ? mask : 0xffffffff;
  buf3[0] &= ((in_len1 >=  48) && (in_len1 < 52)) ? mask : 0xffffffff;
  buf3[1] &= ((in_len1 >=  52) && (in_len1 < 56)) ? mask : 0xffffffff;
  buf3[2] &= ((in_len1 >=  56) && (in_len1 < 60)) ? mask : 0xffffffff;
  buf3[3] &=  (in_len1 >=  60)                    ? mask : 0xffffffff;

  return in_len1;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;
  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  lshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43);

  const u32 ml =(1u << ((p0 & 2u) * 8u)) - 1u;
  const u32 mr = ~ml;

  const int p0_switch = p0 / 4;

  switch (p0_switch)
  {
    case  0:  buf0[0] =  (buf0[0] & ml)
                      | (tib40[0] & mr );
              buf0[1] =  tib40[1];
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  1:  buf0[1] =  (buf0[1] & ml)
                      | (tib40[1] & mr);
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  2:  buf0[2] =  (buf0[2] & ml)
                      | (tib40[2] & mr);
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  3:  buf0[3] =  (buf0[3] & ml)
                      | (tib40[3] & mr);
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  4:  buf1[0] =  (buf1[0] & ml)
                      | (tib41[0] & mr);
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  5:  buf1[1] =  (buf1[1] & ml)
                      | (tib41[1] & mr);
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  6:  buf1[2] =  (buf1[2] & ml)
                      | (tib41[2] & mr);
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  7:  buf1[3] =  (buf1[3] & ml)
                      | (tib41[3] & mr);
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  8:
              buf2[0] =  (buf2[0] & ml)
                      | (tib42[0] & mr);
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  9:
              buf2[1] =  (buf2[1] & ml)
                      | (tib42[1] & mr);
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  10:
              buf2[2] =  (buf2[2] & ml)
                      | (tib42[2] & mr);
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  11:
              buf2[3] =  (buf2[3] & ml)
                      | (tib42[3] & mr);
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  12:
              buf3[0] =  (buf3[0] & ml)
                      | (tib43[0] & mr);
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  13:
              buf3[1] =  (buf3[1] & ml)
                      | (tib43[1] & mr);
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  14:
              buf3[2] =  (buf3[2] & ml)
                      | (tib43[2] & mr);
              buf3[3] =  tib43[3];
              break;
    case  15:
              buf3[3] =  (buf3[3] & ml)
                      | (tib43[3] & mr);
              break;
  }

  out_len -= 2;
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_extract_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  if ((p0 + p1) > in_len) return in_len;

  u32 out_len = p1;
  lshift_block_optimized_N_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, p0);  
  truncate_right_optimized_utf16le (buf0, buf1, buf2, buf3, out_len);
  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_omit_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  if ((p0 + p1) > in_len) return in_len;

  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  tib40[0] = 0;
  tib40[1] = 0;
  tib40[2] = 0;
  tib40[3] = 0;
  tib41[0] = 0;
  tib41[1] = 0;
  tib41[2] = 0;
  tib41[3] = 0;
  tib42[0] = 0;
  tib42[1] = 0;
  tib42[2] = 0;
  tib42[3] = 0;
  tib43[0] = 0;
  tib43[1] = 0;
  tib43[2] = 0;
  tib43[3] = 0;

  lshift_block_optimized_N_utf16le (buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43, p1);

  const u32 ml = (1 << ((p0 & 2u) * 8u)) - 1;
  const u32 mr = ~ml;

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
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  1:  buf0[1] =  (buf0[1] & ml)
                      | (tib40[1] & mr);
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  2:  buf0[2] =  (buf0[2] & ml)
                      | (tib40[2] & mr);
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  3:  buf0[3] =  (buf0[3] & ml)
                      | (tib40[3] & mr);
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  4:  buf1[0] =  (buf1[0] & ml)
                      | (tib41[0] & mr);
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  5:  buf1[1] =  (buf1[1] & ml)
                      | (tib41[1] & mr);
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  6:  buf1[2] =  (buf1[2] & ml)
                      | (tib41[2] & mr);
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  7:  buf1[3] =  (buf1[3] & ml)
                      | (tib41[3] & mr);
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  8:
              buf2[0] =  (buf2[0] & ml)
                      | (tib42[0] & mr);
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  9:
              buf2[1] =  (buf2[1] & ml)
                      | (tib42[1] & mr);
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;    
    case  10:
              buf2[2] =  (buf2[2] & ml)
                      | (tib42[2] & mr);
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;       
    case  11:
              buf2[3] =  (buf2[3] & ml)
                      | (tib42[3] & mr);
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;    
    case  12:
              buf3[0] =  (buf3[0] & ml)
                      | (tib43[0] & mr);
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;    
    case  13:
              buf3[1] =  (buf3[1] & ml)
                      | (tib43[1] & mr);
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;      
    case  14:
              buf3[2] =  (buf3[2] & ml)
                      | (tib43[2] & mr);
              buf3[3] =  tib43[3];
              break;      
    case  15:
              buf3[3] =  (buf3[3] & ml)
                      | (tib43[3] & mr);
              break;
  }

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
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 > in_len) return in_len;

  if ((in_len + 2) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  rshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43);

  const u32 p1n = p1 << ((p0 & 2) * 8);

  const u32 ml = (1 << ((p0 & 2) * 8)) - 1;

  const u32 mr = 0xffff0000 << ((p0 & 2) * 8);

  const int p0_switch = p0 / 4;

  switch (p0_switch)
  {
    case  0:  buf0[0] =  (buf0[0] & ml) | p1n | (tib40[0] & mr);
              buf0[1] =  tib40[1];
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  1:  buf0[1] =  (buf0[1] & ml) | p1n | (tib40[1] & mr);
              buf0[2] =  tib40[2];
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  2:  buf0[2] =  (buf0[2] & ml) | p1n | (tib40[2] & mr);
              buf0[3] =  tib40[3];
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  3:  buf0[3] =  (buf0[3] & ml) | p1n | (tib40[3] & mr);
              buf1[0] =  tib41[0];
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  4:  buf1[0] =  (buf1[0] & ml) | p1n | (tib41[0] & mr);
              buf1[1] =  tib41[1];
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  5:  buf1[1] =  (buf1[1] & ml) | p1n | (tib41[1] & mr);
              buf1[2] =  tib41[2];
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  6:  buf1[2] =  (buf1[2] & ml) | p1n | (tib41[2] & mr);
              buf1[3] =  tib41[3];
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  7:  buf1[3] =  (buf1[3] & ml) | p1n | (tib41[3] & mr);
              buf2[0] =  tib42[0];
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  8:
              buf2[0] =  (buf2[0] & ml) | p1n | (tib42[0] & mr);
              buf2[1] =  tib42[1];
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  9:
              buf2[1] =  (buf2[1] & ml) | p1n | (tib42[1] & mr);
              buf2[2] =  tib42[2];
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  10:
              buf2[2] =  (buf2[2] & ml) | p1n | (tib42[2] & mr);
              buf2[3] =  tib42[3];
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  11:
              buf2[3] =  (buf2[3] & ml) | p1n | (tib42[3] & mr);
              buf3[0] =  tib43[0];
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  12:
              buf3[0] =  (buf3[0] & ml) | p1n | (tib43[0] & mr);
              buf3[1] =  tib43[1];
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  13:
              buf3[1] =  (buf3[1] & ml) | p1n | (tib43[1] & mr);
              buf3[2] =  tib43[2];
              buf3[3] =  tib43[3];
              break;
    case  14:
              buf3[2] =  (buf3[2] & ml) | p1n | (tib43[2] & mr);
              buf3[3] =  tib43[3];
              break;
    case  15:
              buf3[3] =  (buf3[3] & ml) | p1n | (tib43[3] & mr);
              break;
  }

  out_len += 2;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_overstrike_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 p1n = p1 << ((p0 & 2) * 8);

  const u32 m = ~(0xffffu << ((p0 & 2) * 8));

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  const u32 tmp = t[p0 / 4];

  t[p0 / 4] = (tmp & m) | p1n;

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_truncate_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  truncate_right_optimized_utf16le (buf0, buf1, buf2, buf3, p0);

  return p0;
}

DECLSPEC u32 search_on_register_utf16le (const u32 in, const u32 p0) 
{
  u32 r = 0;

  if (hc_bfe_S (in,  0, 16) == p0) r |= 1;
  if (hc_bfe_S (in,  16, 16) == p0) r |= 2;

  return r;
}

DECLSPEC u32 replace_on_register_utf16le (const u32 in, const u32 r, const u32 p1) 
{
  u32 out = in;

  if (r & 1) out = (out & 0xffff0000) | (p1 <<  0);
  if (r & 2) out = (out & 0x0000ffff) | (p1 <<  16);

  return out;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  const u32 r0 = search_on_register_utf16le (buf0[0], p0);
  const u32 r1 = search_on_register_utf16le (buf0[1], p0);
  const u32 r2 = search_on_register_utf16le (buf0[2], p0);
  const u32 r3 = search_on_register_utf16le (buf0[3], p0);
  const u32 r4 = search_on_register_utf16le (buf1[0], p0);
  const u32 r5 = search_on_register_utf16le (buf1[1], p0);
  const u32 r6 = search_on_register_utf16le (buf1[2], p0);
  const u32 r7 = search_on_register_utf16le (buf1[3], p0);
  const u32 r8 = search_on_register_utf16le (buf2[0], p0);
  const u32 r9 = search_on_register_utf16le (buf2[1], p0);
  const u32 r10 = search_on_register_utf16le (buf2[2], p0);
  const u32 r11 = search_on_register_utf16le (buf2[3], p0);
  const u32 r12 = search_on_register_utf16le (buf3[0], p0);
  const u32 r13 = search_on_register_utf16le (buf3[1], p0);
  const u32 r14 = search_on_register_utf16le (buf3[2], p0);
  const u32 r15 = search_on_register_utf16le (buf3[3], p0);

  const u32 rn = r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 ;

  if (rn == 0) return in_len;

  buf0[0] = replace_on_register_utf16le (buf0[0], r0, p1);
  buf0[1] = replace_on_register_utf16le (buf0[1], r1, p1);
  buf0[2] = replace_on_register_utf16le (buf0[2], r2, p1);
  buf0[3] = replace_on_register_utf16le (buf0[3], r3, p1);
  buf1[0] = replace_on_register_utf16le (buf1[0], r4, p1);
  buf1[1] = replace_on_register_utf16le (buf1[1], r5, p1);
  buf1[2] = replace_on_register_utf16le (buf1[2], r6, p1);
  buf1[3] = replace_on_register_utf16le (buf1[3], r7, p1);
  buf2[0] = replace_on_register_utf16le (buf2[0], r8, p1);
  buf2[1] = replace_on_register_utf16le (buf2[1], r9, p1);
  buf2[2] = replace_on_register_utf16le (buf2[2], r10, p1);
  buf2[3] = replace_on_register_utf16le (buf2[3], r11, p1);
  buf3[0] = replace_on_register_utf16le (buf3[0], r12, p1);
  buf3[1] = replace_on_register_utf16le (buf3[1], r13, p1);
  buf3[2] = replace_on_register_utf16le (buf3[2], r14, p1);
  buf3[3] = replace_on_register_utf16le (buf3[3], r15, p1);

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
       if ((u8)p0 == 'l') return rule_op_mangle_replace_class_l_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_replace_class_u_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_replace_class_d_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_replace_class_lh_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_replace_class_uh_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_replace_class_s_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);

  return in_len;
}


DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  const u32 r0 = search_on_register_utf16le (buf0[0], p0);
  const u32 r1 = search_on_register_utf16le (buf0[1], p0);
  const u32 r2 = search_on_register_utf16le (buf0[2], p0);
  const u32 r3 = search_on_register_utf16le (buf0[3], p0);
  const u32 r4 = search_on_register_utf16le (buf1[0], p0);
  const u32 r5 = search_on_register_utf16le (buf1[1], p0);
  const u32 r6 = search_on_register_utf16le (buf1[2], p0);
  const u32 r7 = search_on_register_utf16le (buf1[3], p0);
  const u32 r8 = search_on_register_utf16le (buf2[0], p0);
  const u32 r9 = search_on_register_utf16le (buf2[1], p0);
  const u32 r10 = search_on_register_utf16le (buf2[2], p0);
  const u32 r11 = search_on_register_utf16le (buf2[3], p0);
  const u32 r12 = search_on_register_utf16le (buf3[0], p0);
  const u32 r13 = search_on_register_utf16le (buf3[1], p0);
  const u32 r14 = search_on_register_utf16le (buf3[2], p0);
  const u32 r15 = search_on_register_utf16le (buf3[3], p0);

  const u32 rn = r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 ;

  if (rn == 0) return in_len;

  u32 out_len = 0;

  u32 buf_in[16];

  buf_in[0] = buf0[0];
  buf_in[1] = buf0[1];
  buf_in[2] = buf0[2];
  buf_in[3] = buf0[3];
  buf_in[4] = buf1[0];
  buf_in[5] = buf1[1];
  buf_in[6] = buf1[2];
  buf_in[7] = buf1[3];
  buf_in[8] = buf2[0];
  buf_in[9] = buf2[1];
  buf_in[10] = buf2[2];
  buf_in[11] = buf2[3];
  buf_in[12] = buf3[0];
  buf_in[13] = buf3[1];
  buf_in[14] = buf3[2];
  buf_in[15] = buf3[3];

  u32 buf_out[16] = { 0 };

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
  buf2[0] = buf_out[8];
  buf2[1] = buf_out[9];
  buf2[2] = buf_out[10];
  buf2[3] = buf_out[11];
  buf3[0] = buf_out[12];
  buf3[1] = buf_out[13];
  buf3[2] = buf_out[14];
  buf3[3] = buf_out[15];

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
       if ((u8)p0 == 'l') return rule_op_mangle_purgechar_class_l_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_purgechar_class_u_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_purgechar_class_d_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_purgechar_class_lh_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_purgechar_class_uh_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_purgechar_class_s_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);

  return in_len;
}
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if ( in_len       ==  0) return in_len;
  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  const u32 tmp = buf0[0] & 0xFFFF;

  const u32 tmp32 = tmp <<  0
                  | tmp <<  16;

  rshift_block_optimized_N_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, p0); 

  u32 t0[4] = { tmp32, tmp32, tmp32, tmp32 };
  u32 t1[4] = { tmp32, tmp32, tmp32, tmp32 };
  u32 t2[4] = { tmp32, tmp32, tmp32, tmp32 };
  u32 t3[4] = { tmp32, tmp32, tmp32, tmp32 };

  truncate_right_optimized_utf16le (t0, t1, t2, t3, p0);

  buf0[0] |= t0[0];
  buf0[1] |= t0[1];
  buf0[2] |= t0[2];
  buf0[3] |= t0[3];
  buf1[0] |= t1[0];
  buf1[1] |= t1[1];
  buf1[2] |= t1[2];
  buf1[3] |= t1[3];
  buf2[0] |= t2[0];
  buf2[1] |= t2[1];
  buf2[2] |= t2[2];
  buf2[3] |= t2[3];
  buf3[0] |= t3[0];
  buf3[1] |= t3[1];
  buf3[2] |= t3[2];
  buf3[3] |= t3[3];

  out_len += p0;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if ( in_len       ==  0) return in_len;
  if ((in_len + p0) >= 64) return in_len;

  const u32 in_len1 = in_len - 2;

  const u32 sh = (in_len1 & 2) * 8;

  u32 tmp = 0;

  u32 v[4];

  set_mark_1x4_S_16 (v, in_len1); 

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

    case 2:
      tmp |= buf2[0] & v[0];
      tmp |= buf2[1] & v[1];
      tmp |= buf2[2] & v[2];
      tmp |= buf2[3] & v[3];
      break;

    case 3:
      tmp |= buf3[0] & v[0];
      tmp |= buf3[1] & v[1];
      tmp |= buf3[2] & v[2];
      tmp |= buf3[3] & v[3];
      break;
  }

  tmp = (tmp >> sh) & 0xffff;

  u32 out_len = in_len;

  for (u32 i = 0; i < p0/2; i++)
  {
    append_block1_optimized_utf16le (out_len, buf0, buf1, buf2, buf3, tmp); 

    out_len+=2;
  }

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_all_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  
{
  if ( in_len           ==  0) return in_len;
  if ((in_len + in_len) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  tib40[0] = ((buf0[0] & 0x0000FFFF) <<  0) | ((buf0[0] & 0x0000FFFF) <<  16);
  tib40[1] = ((buf0[0] & 0xFFFF0000) >> 16) | ((buf0[0] & 0xFFFF0000) >>  0);
  tib40[2] = ((buf0[1] & 0x0000FFFF) <<  0) | ((buf0[1] & 0x0000FFFF) <<  16);
  tib40[3] = ((buf0[1] & 0xFFFF0000) >> 16) | ((buf0[1] & 0xFFFF0000) >>  0);
  tib41[0] = ((buf0[2] & 0x0000FFFF) <<  0) | ((buf0[2] & 0x0000FFFF) <<  16);
  tib41[1] = ((buf0[2] & 0xFFFF0000) >> 16) | ((buf0[2] & 0xFFFF0000) >>  0);
  tib41[2] = ((buf0[3] & 0x0000FFFF) <<  0) | ((buf0[3] & 0x0000FFFF) <<  16);
  tib41[3] = ((buf0[3] & 0xFFFF0000) >> 16) | ((buf0[3] & 0xFFFF0000) >>  0);
  tib42[0] = ((buf1[0] & 0x0000FFFF) <<  0) | ((buf1[0] & 0x0000FFFF) <<  16);
  tib42[1] = ((buf1[0] & 0xFFFF0000) >> 16) | ((buf1[0] & 0xFFFF0000) >>  0);
  tib42[2] = ((buf1[1] & 0x0000FFFF) <<  0) | ((buf1[1] & 0x0000FFFF) <<  16);
  tib42[3] = ((buf1[1] & 0xFFFF0000) >> 16) | ((buf1[1] & 0xFFFF0000) >>  0);
  tib43[0] = ((buf1[2] & 0x0000FFFF) <<  0) | ((buf1[2] & 0x0000FFFF) <<  16);
  tib43[1] = ((buf1[2] & 0xFFFF0000) >> 16) | ((buf1[2] & 0xFFFF0000) >>  0);
  tib43[2] = ((buf1[3] & 0x0000FFFF) <<  0) | ((buf1[3] & 0x0000FFFF) <<  16);
  tib43[3] = ((buf1[3] & 0xFFFF0000) >> 16) | ((buf1[3] & 0xFFFF0000) >>  0);

  buf0[0] = tib40[0]; 
  buf0[1] = tib40[1];
  buf0[2] = tib40[2];
  buf0[3] = tib40[3];
  buf1[0] = tib41[0];
  buf1[1] = tib41[1];
  buf1[2] = tib41[2];
  buf1[3] = tib41[3];
  buf2[0] = tib42[0]; 
  buf2[1] = tib42[1];
  buf2[2] = tib42[2];
  buf2[3] = tib42[3];
  buf3[0] = tib43[0];
  buf3[1] = tib43[1];
  buf3[2] = tib43[2];
  buf3[3] = tib43[3];
  out_len = out_len + out_len;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (in_len < 4 ) return in_len;

  buf0[0] = ((buf0[0] & 0x0000FFFFu) << 16) | ((buf0[0] & 0xFFFF0000u) >> 16);

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  
{
  if (in_len < 4) return in_len;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  exchange_byte_optimized_utf16le (t, (in_len/2) - 2, (in_len/2) - 1);  

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;
  if (p1 >= in_len) return in_len;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  exchange_byte_optimized_utf16le (t, p0/2, p1/2);

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftl_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 mr = 0xffffu << ((p0 & 2u) * 8u);
  const u32 ml = ~mr;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  const u32 tmp = t[p0 / 4];

  t[p0 / 4] = (tmp & ml) | (((tmp & mr) << 1) & mr); 

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];
  
  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 mr = 0xffffu << ((p0 & 2u) * 8u);
  const u32 ml = ~mr;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  const u32 tmp = t[p0 / 4];

  t[p0 / 4] = (tmp & ml) | (((tmp & mr) >> 1) & mr);  

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_incr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 mr = 0xffffu << ((p0 & 2u) * 8u);
  const u32 ml = ~mr;

  const u32 n = 0x00010001 & mr; 

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

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
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_decr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 >= in_len) return in_len;

  const u32 mr = 0xffffu << ((p0 & 2u) * 8u);
  const u32 ml = ~mr;

  const u32 n = 0x00010001 & mr;  

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  const u32 tmp = t[p0 / 4];

  t[p0 / 4] = (tmp & ml) | (((tmp & mr) - n) & mr);

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_add_utf16le  (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len)  //TODO
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

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_np1_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if ((p0 + 2) >= in_len) return in_len;

  u32 tib4x[16];

  lshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, tib4x + 0, tib4x + 4, tib4x + 8, tib4x + 12);

  const u32 mr = 0xffffu << ((p0 & 2u) * 8u);
  const u32 ml = ~mr;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  const u32 tmp = t[p0 / 4];

  const u32 tmp2 = tib4x[p0 / 4];

  t[p0 / 4] = (tmp & ml) | (tmp2 & mr);

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_nm1_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 == 0) return in_len;

  if (p0 >= in_len) return in_len;

  u32 tib4x[16];

  rshift_block_optimized_utf16le (buf0, buf1, buf2, buf3, tib4x + 0, tib4x + 4, tib4x + 8, tib4x + 16);

  const u32 mr = 0xffffu << ((p0 & 2u) * 8u);
  const u32 ml = ~mr;

  u32 t[16];

  t[0] = buf0[0];
  t[1] = buf0[1];
  t[2] = buf0[2];
  t[3] = buf0[3];
  t[4] = buf1[0];
  t[5] = buf1[1];
  t[6] = buf1[2];
  t[7] = buf1[3];
  t[8] = buf2[0];
  t[9] = buf2[1];
  t[10] = buf2[2];
  t[11] = buf2[3];
  t[12] = buf3[0];
  t[13] = buf3[1];
  t[14] = buf3[2];
  t[15] = buf3[3];

  const u32 tmp = t[p0 / 4];

  const u32 tmp2 = tib4x[p0 / 4];

  t[p0 / 4] = (tmp & ml) | (tmp2 & mr);

  buf0[0] = t[0];
  buf0[1] = t[1];
  buf0[2] = t[2];
  buf0[3] = t[3];
  buf1[0] = t[4];
  buf1[1] = t[5];
  buf1[2] = t[6];
  buf1[3] = t[7];
  buf2[0] = t[8];
  buf2[1] = t[9];
  buf2[2] = t[10];
  buf2[3] = t[11];
  buf3[0] = t[12];
  buf3[1] = t[13];
  buf3[2] = t[14];
  buf3[3] = t[15];

  return in_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 > in_len) return in_len;

  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  tib40[0] = buf0[0];
  tib40[1] = buf0[1];
  tib40[2] = buf0[2];
  tib40[3] = buf0[3];
  tib41[0] = buf1[0];
  tib41[1] = buf1[1];
  tib41[2] = buf1[2];
  tib41[3] = buf1[3];
  tib42[0] = buf2[0];
  tib42[1] = buf2[1];
  tib42[2] = buf2[2];
  tib42[3] = buf2[3];
  tib43[0] = buf3[0];
  tib43[1] = buf3[1];
  tib43[2] = buf3[2];
  tib43[3] = buf3[3];

  truncate_right_optimized_utf16le (tib40, tib41, tib42, tib43, p0);

  rshift_block_optimized_N_utf16le (buf0, buf1, buf2, buf3, buf0, buf1, buf2, buf3, p0);

  buf0[0] |= tib40[0];
  buf0[1] |= tib40[1];
  buf0[2] |= tib40[2];
  buf0[3] |= tib40[3];
  buf1[0] |= tib41[0];
  buf1[1] |= tib41[1];
  buf1[2] |= tib41[2];
  buf1[3] |= tib41[3];
  buf2[0] |= tib42[0];
  buf2[1] |= tib42[1];
  buf2[2] |= tib42[2];
  buf2[3] |= tib42[3];
  buf3[0] |= tib43[0];
  buf3[1] |= tib43[1];
  buf3[2] |= tib43[2];
  buf3[3] |= tib43[3];

  out_len += p0;

  return out_len;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (p0 > in_len) return in_len;

  if ((in_len + p0) >= 64) return in_len;

  u32 out_len = in_len;

  u32 tib40[4];
  u32 tib41[4];
  u32 tib42[4];
  u32 tib43[4];

  rshift_block_optimized_N_utf16le (buf0, buf1, buf2, buf3, tib40, tib41, tib42, tib43, p0);

  truncate_left_optimized_utf16le (tib40, tib41, tib42, tib43, out_len);

  buf0[0] |= tib40[0];
  buf0[1] |= tib40[1];
  buf0[2] |= tib40[2];
  buf0[3] |= tib40[3];
  buf1[0] |= tib41[0];
  buf1[1] |= tib41[1];
  buf1[2] |= tib41[2];
  buf1[3] |= tib41[3];
  buf2[0] |= tib42[0];
  buf2[1] |= tib42[1];
  buf2[2] |= tib42[2];
  buf2[3] |= tib42[3];
  buf3[0] |= tib43[0];
  buf3[1] |= tib43[1];
  buf3[2] |= tib43[2];
  buf3[3] |= tib43[3];

  out_len += p0;

  return out_len;
}

DECLSPEC u32 toggle_on_register_utf16le (const u32 in, const u32 r) 
{
  u32 out = in;

  const u32 cmask = generate_cmask_utf16le(out);

  if (r & 1) out = out ^ (0x00000020 & cmask);
  if (r & 2) out = out ^ (0x00200000 & cmask);

  return out;
}

DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, MAYBE_UNUSED PRIVATE_AS u32 *buf1, MAYBE_UNUSED PRIVATE_AS u32 *buf2, MAYBE_UNUSED PRIVATE_AS u32 *buf3, const u32 in_len) 
{
  if (in_len == 0) return in_len;

  u32 r0 = search_on_register_utf16le (buf0[0], p0);
  u32 r1 = search_on_register_utf16le (buf0[1], p0);
  u32 r2 = search_on_register_utf16le (buf0[2], p0);
  u32 r3 = search_on_register_utf16le (buf0[3], p0);
  u32 r4 = search_on_register_utf16le (buf1[0], p0);
  u32 r5 = search_on_register_utf16le (buf1[1], p0);
  u32 r6 = search_on_register_utf16le (buf1[2], p0);
  u32 r7 = search_on_register_utf16le (buf1[3], p0);
  u32 r8 = search_on_register_utf16le (buf2[0], p0);
  u32 r9 = search_on_register_utf16le (buf2[1], p0);
  u32 r10 = search_on_register_utf16le (buf2[2], p0);
  u32 r11 = search_on_register_utf16le (buf2[3], p0);
  u32 r12 = search_on_register_utf16le (buf3[0], p0);
  u32 r13 = search_on_register_utf16le (buf3[1], p0);
  u32 r14 = search_on_register_utf16le (buf3[2], p0);
  u32 r15 = search_on_register_utf16le (buf3[3], p0);

  rule_op_mangle_lrest_ufirst_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);

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

  buf0[0] = toggle_on_register_utf16le (buf0[0], r0);
  buf0[1] = toggle_on_register_utf16le (buf0[1], r1);
  buf0[2] = toggle_on_register_utf16le (buf0[2], r2);
  buf0[3] = toggle_on_register_utf16le (buf0[3], r3);
  buf1[0] = toggle_on_register_utf16le (buf1[0], r4);
  buf1[1] = toggle_on_register_utf16le (buf1[1], r5);
  buf1[2] = toggle_on_register_utf16le (buf1[2], r6);
  buf1[3] = toggle_on_register_utf16le (buf1[3], r7);
  buf2[0] = toggle_on_register_utf16le (buf2[0], r8);
  buf2[1] = toggle_on_register_utf16le (buf2[1], r9);
  buf2[2] = toggle_on_register_utf16le (buf2[2], r10);
  buf2[3] = toggle_on_register_utf16le (buf2[3], r11);
  buf3[0] = toggle_on_register_utf16le (buf3[0], r12);
  buf3[1] = toggle_on_register_utf16le (buf3[1], r13);
  buf3[2] = toggle_on_register_utf16le (buf3[2], r14);
  buf3[3] = toggle_on_register_utf16le (buf3[3], r15);
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
       if ((u8)p0 == 'l') return rule_op_mangle_title_sep_class_l_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'u') return rule_op_mangle_title_sep_class_u_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'd') return rule_op_mangle_title_sep_class_d_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'h') return rule_op_mangle_title_sep_class_lh_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 'H') return rule_op_mangle_title_sep_class_uh_utf16le (p0, p1, buf0, buf1, buf2, buf3, in_len);
  else if ((u8)p0 == 's') return rule_op_mangle_title_sep_class_s_utf16le  (p0, p1, buf0, buf1, buf2, buf3, in_len);

  return in_len;
}
DECLSPEC u32 apply_rule_optimized_utf16le (const u32 name, const u32 p0, const u32 p1, PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, PRIVATE_AS u32 *buf2, PRIVATE_AS u32 *buf3, const u32 in_len)
{
  u32 out_len = in_len;

  if (name == RULE_OP_MANGLE_NOOP) return out_len;

  switch (name)
  {
    case RULE_OP_MANGLE_LREST:            out_len = rule_op_mangle_lrest_utf16le            (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_UREST:            out_len = rule_op_mangle_urest_utf16le            (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // revoir pour les nombre
    case RULE_OP_MANGLE_LREST_UFIRST:     out_len = rule_op_mangle_lrest_ufirst_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_UREST_LFIRST:     out_len = rule_op_mangle_urest_lfirst_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // revoir pour les nombre
    case RULE_OP_MANGLE_TREST:            out_len = rule_op_mangle_trest_utf16le            (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SHIFT_CASE:       out_len = rule_op_mangle_shift_case_utf16le                (p0, p1, buf0, buf1, buf2, buf3, out_len); break; //TODO
    case RULE_OP_MANGLE_TOGGLE_AT:        out_len = rule_op_mangle_toggle_at_utf16le        (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TOGGLE_AT_SEP:    out_len = rule_op_mangle_toggle_at_sep_utf16le    (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REVERSE:          out_len = rule_op_mangle_reverse_utf16le          (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEWORD:         out_len = rule_op_mangle_dupeword_utf16le         (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEWORD_TIMES:   out_len = rule_op_mangle_dupeword_times_utf16le   (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REFLECT:          out_len = rule_op_mangle_reflect_utf16le          (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_APPEND:           out_len = rule_op_mangle_append_utf16le           (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_PREPEND:          out_len = rule_op_mangle_prepend_utf16le          (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_ROTATE_LEFT:      out_len = rule_op_mangle_rotate_left_utf16le      (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_ROTATE_RIGHT:     out_len = rule_op_mangle_rotate_right_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_FIRST:     out_len = rule_op_mangle_delete_first_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_LAST:      out_len = rule_op_mangle_delete_last_utf16le      (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DELETE_AT:        out_len = rule_op_mangle_delete_at_utf16le        (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_EXTRACT:          out_len = rule_op_mangle_extract_utf16le          (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_OMIT:             out_len = rule_op_mangle_omit_utf16le             (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_INSERT:           out_len = rule_op_mangle_insert_utf16le           (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_INSERT_EVERY:     out_len = rule_op_mangle_insert_every_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break; // TODO
    case RULE_OP_MANGLE_OVERSTRIKE:       out_len = rule_op_mangle_overstrike_utf16le       (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TRUNCATE_AT:      out_len = rule_op_mangle_truncate_at_utf16le      (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE:          out_len = rule_op_mangle_replace_utf16le          (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE_CLASS:    out_len = rule_op_mangle_replace_class_utf16le    (p0, p1, buf0, buf1, buf2, buf3, out_len); break;// TODO
    case RULE_OP_MANGLE_PURGECHAR:        out_len = rule_op_mangle_purgechar_utf16le        (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_PURGECHAR_CLASS:  out_len = rule_op_mangle_purgechar_class_utf16le  (p0, p1, buf0, buf1, buf2, buf3, out_len); break; // TODO
    //case RULE_OP_MANGLE_TOGGLECASE_REC:   out_len = rule_op_mangle_togglecase_rec_utf16le   (p0, p1, buf0, buf1, buf2, buf3, out_len); break;
    case RULE_OP_MANGLE_DUPECHAR_FIRST:   out_len = rule_op_mangle_dupechar_first_utf16le   (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPECHAR_LAST:    out_len = rule_op_mangle_dupechar_last_utf16le    (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPECHAR_ALL:     out_len = rule_op_mangle_dupechar_all_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_FIRST:     out_len = rule_op_mangle_switch_first_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_LAST:      out_len = rule_op_mangle_switch_last_utf16le      (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_SWITCH_AT:        out_len = rule_op_mangle_switch_at_utf16le        (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_SHIFTL:       out_len = rule_op_mangle_chr_shiftl_utf16le       (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_SHIFTR:       out_len = rule_op_mangle_chr_shiftr_utf16le       (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_INCR:         out_len = rule_op_mangle_chr_incr_utf16le         (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_DECR:         out_len = rule_op_mangle_chr_decr_utf16le         (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_CHR_ADD:          out_len = rule_op_mangle_chr_add_utf16le          (p0, p1, buf0, buf1, buf2, buf3, out_len); break;//TODO
    case RULE_OP_MANGLE_REPLACE_NP1:      out_len = rule_op_mangle_replace_np1_utf16le      (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_REPLACE_NM1:      out_len = rule_op_mangle_replace_nm1_utf16le      (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEBLOCK_FIRST:  out_len = rule_op_mangle_dupeblock_first_utf16le  (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_DUPEBLOCK_LAST:   out_len = rule_op_mangle_dupeblock_last_utf16le   (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TITLE_SEP:        out_len = rule_op_mangle_title_sep_utf16le        (p0, p1, buf0, buf1, buf2, buf3, out_len); break;  // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TITLE_SEP_CLASS:  out_len = rule_op_mangle_title_sep_class_utf16le  (p0, p1, buf0, buf1, buf2, buf3, out_len); break; // TODO
    case RULE_OP_MANGLE_TITLE:            out_len = rule_op_mangle_title_sep_utf16le        (' ', p1, buf0, buf1, buf2, buf3, out_len); break; // OK UTF16, TODO Check perf
    case RULE_OP_MANGLE_TO_HEX_LOWER:     out_len = rule_op_mangle_to_hex_lower_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break; // TODO
    case RULE_OP_MANGLE_TO_HEX_UPPER:     out_len = rule_op_mangle_to_hex_upper_utf16le     (p0, p1, buf0, buf1, buf2, buf3, out_len); break; // TODO
  }

  return out_len;
}

//DECLSPEC u32 apply_rules_optimized (PRIVATE_AS const u32 *cmds, PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, const u32 len)
DECLSPEC u32 apply_rules_optimized_utf16le (CONSTANT_AS const u64 *cmds, PRIVATE_AS u32 *buf0, PRIVATE_AS u32 *buf1, PRIVATE_AS u32 *buf2, PRIVATE_AS u32 *buf3, const u32 len)
{
  u32 out_len = len;

  for (u32 i = 0; cmds[i] != 0; i++)
  {
    const u64 cmd = cmds[i];
    
    //printf(" cmd : %.16lX \n", cmd);
    const u32 name = (cmd >>  0) & 0xffff;
    const u32 p0   = (cmd >>  16) & 0xffff;
    const u32 p1   = (cmd >>  32) & 0xffff;

    //printf("name : %.8X \n", name);
    //printf("p0 : %.8X \n", p0);
    //printf("p1 : %.8X \n", p1);
 
    //printf("AV len %d : buf0[0] : %.8X buf0[1] : %.8X buf0[2] : %.8X buf0[3] : %.8X buf1[0] : %.8X buf1[1] : %.8X buf1[2] : %.8X buf1[3] : %.8X\n", out_len, *buf0,*(buf0+1),*(buf0+2),*(buf0+3),*buf1,*(buf1+1),*(buf1+2),*(buf1+3));
    //printf("AV len %d : buf2[0] : %.8X buf2[1] : %.8X buf2[2] : %.8X buf2[3] : %.8X buf3[0] : %.8X buf3[1] : %.8X buf3[2] : %.8X buf3[3] : %.8X\n", out_len, *buf2,*(buf2+1),*(buf2+2),*(buf2+3),*buf3,*(buf3+1),*(buf3+2),*(buf3+3));

    // we need to guarantee input length < 32 otherwise functions like rule_op_mangle_switch_last() and others will read out of boundary
    out_len = apply_rule_optimized_utf16le (name, p0, p1, buf0, buf1, buf2, buf3, out_len);

    //printf("AP len %d : buf0[0] : %.8X buf0[1] : %.8X buf0[2] : %.8X buf0[3] : %.8X buf1[0] : %.8X buf1[1] : %.8X buf1[2] : %.8X btn1[3] : %.8X\n", out_len, *buf0,*(buf0+1),*(buf0+2),*(buf0+3),*buf1,*(buf1+1),*(buf1+2),*(buf1+3));
    //printf("AP len %d : buf2[0] : %.8X btn2[1] : %.8X btn2[2] : %.8X btn2[3] : %.8X btn3[0] : %.8X btn3[1] : "%.8X btn3[2] : "%.8X btn3[3} ; "%.8x\n", out_len, *buf2,*(buf2+1),*(buf2+2),*(buf2+3),*btn3,*(btn3+1),*(btn3+2),*(btn3+3));

  }

  return out_len;
}

DECLSPEC u32x apply_rules_vect_optimized_utf16le (PRIVATE_AS const u32 *pw_buf0, PRIVATE_AS const u32 *pw_buf1, PRIVATE_AS const u32 *pw_buf2, PRIVATE_AS const u32 *pw_buf3, const u32 pw_len, CONSTANT_AS const kernel_rule_t *kernel_rules, const u32 il_pos, PRIVATE_AS u32x *buf0, PRIVATE_AS u32x *buf1, PRIVATE_AS u32x *buf2, PRIVATE_AS u32x *buf3)
{
  //printf("cmd : %.8lX  cmd64 : %.16lX  il_pos : %d \n", kernel_rules[il_pos].cmds[0], kernel_rules[il_pos].cmds[0], il_pos);
  #if VECT_SIZE == 1

  buf0[0] = pw_buf0[0];
  buf0[1] = pw_buf0[1];
  buf0[2] = pw_buf0[2];
  buf0[3] = pw_buf0[3];
  buf1[0] = pw_buf1[0];
  buf1[1] = pw_buf1[1];
  buf1[2] = pw_buf1[2];
  buf1[3] = pw_buf1[3];
  buf2[0] = pw_buf2[0];
  buf2[1] = pw_buf2[1];
  buf2[2] = pw_buf2[2];
  buf2[3] = pw_buf2[3];
  buf3[0] = pw_buf3[0];
  buf3[1] = pw_buf3[1];
  buf3[2] = pw_buf3[2];
  buf3[3] = pw_buf3[3];
  

  return apply_rules_optimized_utf16le (kernel_rules[il_pos].cmds, buf0, buf1, buf2, buf3, pw_len);

  #else

  u32x out_len = 0;

  #ifdef _unroll
  #pragma unroll
  #endif
  for (int i = 0; i < VECT_SIZE; i++)
  {
    u32 tmp0[4];
    u32 tmp1[4];
    u32 tmp2[4];
    u32 tmp3[4];

    tmp0[0] = pw_buf0[0];
    tmp0[1] = pw_buf0[1];
    tmp0[2] = pw_buf0[2];
    tmp0[3] = pw_buf0[3];
    tmp1[0] = pw_buf1[0];
    tmp1[1] = pw_buf1[1];
    tmp1[2] = pw_buf1[2];
    tmp1[3] = pw_buf1[3];
    tmp2[0] = pw_buf2[0];
    tmp2[1] = pw_buf2[1];
    tmp2[2] = pw_buf2[2];
    tmp2[3] = pw_buf2[3];
    tmp3[0] = pw_buf2[0];
    tmp3[1] = pw_buf3[1];
    tmp3[2] = pw_buf3[2];
    tmp3[3] = pw_buf3[3];
    const u32 tmp_len = apply_rules_optimized_utf16le (kernel_rules[il_pos + i].cmds, tmp0, tmp1, tmp2, tmp3, pw_len);

    switch (i)
    {
      #if VECT_SIZE >= 2
      case 0:
        buf0[0].s0 = tmp0[0];
        buf0[1].s0 = tmp0[1];
        buf0[2].s0 = tmp0[2];
        buf0[3].s0 = tmp0[3];
        buf1[0].s0 = tmp1[0];
        buf1[1].s0 = tmp1[1];
        buf1[2].s0 = tmp1[2];
        buf1[3].s0 = tmp1[3];
        buf2[0].s0 = tmp2[0];
        buf2[1].s0 = tmp2[1];
        buf2[2].s0 = tmp2[2];
        buf2[3].s0 = tmp2[3];
        buf3[0].s0 = tmp3[0];
        buf3[1].s0 = tmp3[1];
        buf3[2].s0 = tmp3[2];
        buf3[3].s0 = tmp3[3];
        out_len.s0 = tmp_len;
        break;

      case 1:
        buf0[0].s1 = tmp0[0];
        buf0[1].s1 = tmp0[1];
        buf0[2].s1 = tmp0[2];
        buf0[3].s1 = tmp0[3];
        buf1[0].s1 = tmp1[0];
        buf1[1].s1 = tmp1[1];
        buf1[2].s1 = tmp1[2];
        buf1[3].s1 = tmp1[3];
        buf2[0].s1 = tmp2[0];
        buf2[1].s1 = tmp2[1];
        buf2[2].s1 = tmp2[2];
        buf2[3].s1 = tmp2[3];
        buf3[0].s1 = tmp3[0];
        buf3[1].s1 = tmp3[1];
        buf3[2].s1 = tmp3[2];
        buf3[3].s1 = tmp3[3];
        out_len.s1 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 4
      case 2:
        buf0[0].s2 = tmp0[0];
        buf0[1].s2 = tmp0[1];
        buf0[2].s2 = tmp0[2];
        buf0[3].s2 = tmp0[3];
        buf1[0].s2 = tmp1[0];
        buf1[1].s2 = tmp1[1];
        buf1[2].s2 = tmp1[2];
        buf1[3].s2 = tmp1[3];
        buf2[0].s2 = tmp2[0];
        buf2[1].s2 = tmp2[1];
        buf2[2].s2 = tmp2[2];
        buf2[3].s2 = tmp2[3];
        buf3[0].s2 = tmp3[0];
        buf3[1].s2 = tmp3[1];
        buf3[2].s2 = tmp3[2];
        buf3[3].s2 = tmp3[3];
        out_len.s2 = tmp_len;
        break;

      case 3:
        buf0[0].s3 = tmp0[0];
        buf0[1].s3 = tmp0[1];
        buf0[2].s3 = tmp0[2];
        buf0[3].s3 = tmp0[3];
        buf1[0].s3 = tmp1[0];
        buf1[1].s3 = tmp1[1];
        buf1[2].s3 = tmp1[2];
        buf1[3].s3 = tmp1[3];
        buf2[0].s3 = tmp2[0];
        buf2[1].s3 = tmp2[1];
        buf2[2].s3 = tmp2[2];
        buf2[3].s3 = tmp2[3];
        buf3[0].s3 = tmp3[0];
        buf3[1].s3 = tmp3[1];
        buf3[2].s3 = tmp3[2];
        buf3[3].s3 = tmp3[3];
        out_len.s3 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 8
      case 4:
        buf0[0].s4 = tmp0[0];
        buf0[1].s4 = tmp0[1];
        buf0[2].s4 = tmp0[2];
        buf0[3].s4 = tmp0[3];
        buf1[0].s4 = tmp1[0];
        buf1[1].s4 = tmp1[1];
        buf1[2].s4 = tmp1[2];
        buf1[3].s4 = tmp1[3];
        buf2[0].s4 = tmp2[0];
        buf2[1].s4 = tmp2[1];
        buf2[2].s4 = tmp2[2];
        buf2[3].s4 = tmp2[3];
        buf3[0].s4 = tmp3[0];
        buf3[1].s4 = tmp3[1];
        buf3[2].s4 = tmp3[2];
        buf3[3].s4 = tmp3[3];
        out_len.s4 = tmp_len;
        break;

      case 5:
        buf0[0].s5 = tmp0[0];
        buf0[1].s5 = tmp0[1];
        buf0[2].s5 = tmp0[2];
        buf0[3].s5 = tmp0[3];
        buf1[0].s5 = tmp1[0];
        buf1[1].s5 = tmp1[1];
        buf1[2].s5 = tmp1[2];
        buf1[3].s5 = tmp1[3];
        buf2[0].s5 = tmp2[0];
        buf2[1].s5 = tmp2[1];
        buf2[2].s5 = tmp2[2];
        buf2[3].s5 = tmp2[3];
        buf3[0].s5 = tmp3[0];
        buf3[1].s5 = tmp3[1];
        buf3[2].s5 = tmp3[2];
        buf3[3].s5 = tmp3[3];
        out_len.s5 = tmp_len;
        break;

      case 6:
        buf0[0].s6 = tmp0[0];
        buf0[1].s6 = tmp0[1];
        buf0[2].s6 = tmp0[2];
        buf0[3].s6 = tmp0[3];
        buf1[0].s6 = tmp1[0];
        buf1[1].s6 = tmp1[1];
        buf1[2].s6 = tmp1[2];
        buf1[3].s6 = tmp1[3];
        buf2[0].s6 = tmp2[0];
        buf2[1].s6 = tmp2[1];
        buf2[2].s6 = tmp2[2];
        buf2[3].s6 = tmp2[3];
        buf3[0].s6 = tmp3[0];
        buf3[1].s6 = tmp3[1];
        buf3[2].s6 = tmp3[2];
        buf3[3].s6 = tmp3[3];
        out_len.s6 = tmp_len;
        break;

      case 7:
        buf0[0].s7 = tmp0[0];
        buf0[1].s7 = tmp0[1];
        buf0[2].s7 = tmp0[2];
        buf0[3].s7 = tmp0[3];
        buf1[0].s7 = tmp1[0];
        buf1[1].s7 = tmp1[1];
        buf1[2].s7 = tmp1[2];
        buf1[3].s7 = tmp1[3];
        buf2[0].s7 = tmp2[0];
        buf2[1].s7 = tmp2[1];
        buf2[2].s7 = tmp2[2];
        buf2[3].s7 = tmp2[3];
        buf3[0].s7 = tmp3[0];
        buf3[1].s7 = tmp3[1];
        buf3[2].s7 = tmp3[2];
        buf3[3].s7 = tmp3[3];
        out_len.s7 = tmp_len;
        break;
      #endif

      #if VECT_SIZE >= 16
      case 8:
        buf0[0].s8 = tmp0[0];
        buf0[1].s8 = tmp0[1];
        buf0[2].s8 = tmp0[2];
        buf0[3].s8 = tmp0[3];
        buf1[0].s8 = tmp1[0];
        buf1[1].s8 = tmp1[1];
        buf1[2].s8 = tmp1[2];
        buf1[3].s8 = tmp1[3];
        buf2[0].s8 = tmp2[0];
        buf2[1].s8 = tmp2[1];
        buf2[2].s8 = tmp2[2];
        buf2[3].s8 = tmp2[3];
        buf3[0].s8 = tmp3[0];
        buf3[1].s8 = tmp3[1];
        buf3[2].s8 = tmp3[2];
        buf3[3].s8 = tmp3[3];
        out_len.s8 = tmp_len;
        break;

      case 9:
        buf0[0].s9 = tmp0[0];
        buf0[1].s9 = tmp0[1];
        buf0[2].s9 = tmp0[2];
        buf0[3].s9 = tmp0[3];
        buf1[0].s9 = tmp1[0];
        buf1[1].s9 = tmp1[1];
        buf1[2].s9 = tmp1[2];
        buf1[3].s9 = tmp1[3];
        buf2[0].s9 = tmp2[0];
        buf2[1].s9 = tmp2[1];
        buf2[2].s9 = tmp2[2];
        buf2[3].s9 = tmp2[3];
        buf3[0].s9 = tmp3[0];
        buf3[1].s9 = tmp3[1];
        buf3[2].s9 = tmp3[2];
        buf3[3].s9 = tmp3[3];
        out_len.s9 = tmp_len;
        break;

      case 10:
        buf0[0].sa = tmp0[0];
        buf0[1].sa = tmp0[1];
        buf0[2].sa = tmp0[2];
        buf0[3].sa = tmp0[3];
        buf1[0].sa = tmp1[0];
        buf1[1].sa = tmp1[1];
        buf1[2].sa = tmp1[2];
        buf1[3].sa = tmp1[3];
        buf2[0].sa = tmp2[0];
        buf2[1].sa = tmp2[1];
        buf2[2].sa = tmp2[2];
        buf2[3].sa = tmp2[3];
        buf3[0].sa = tmp3[0];
        buf3[1].sa = tmp3[1];
        buf3[2].sa = tmp3[2];
        buf3[3].sa = tmp3[3];
        out_len.sa = tmp_len;
        break;

      case 11:
        buf0[0].sb = tmp0[0];
        buf0[1].sb = tmp0[1];
        buf0[2].sb = tmp0[2];
        buf0[3].sb = tmp0[3];
        buf1[0].sb = tmp1[0];
        buf1[1].sb = tmp1[1];
        buf1[2].sb = tmp1[2];
        buf1[3].sb = tmp1[3];
        buf2[0].sb = tmp2[0];
        buf2[1].sb = tmp2[1];
        buf2[2].sb = tmp2[2];
        buf2[3].sb = tmp2[3];
        buf3[0].sb = tmp3[0];
        buf3[1].sb = tmp3[1];
        buf3[2].sb = tmp3[2];
        buf3[3].sb = tmp3[3];
        out_len.sb = tmp_len;
        break;

      case 12:
        buf0[0].sc = tmp0[0];
        buf0[1].sc = tmp0[1];
        buf0[2].sc = tmp0[2];
        buf0[3].sc = tmp0[3];
        buf1[0].sc = tmp1[0];
        buf1[1].sc = tmp1[1];
        buf1[2].sc = tmp1[2];
        buf1[3].sc = tmp1[3];
        buf2[0].sc = tmp2[0];
        buf2[1].sc = tmp2[1];
        buf2[2].sc = tmp2[2];
        buf2[3].sc = tmp2[3];
        buf3[0].sc = tmp3[0];
        buf3[1].sc = tmp3[1];
        buf3[2].sc = tmp3[2];
        buf3[3].sc = tmp3[3];
        out_len.sc = tmp_len;
        break;

      case 13:
        buf0[0].sd = tmp0[0];
        buf0[1].sd = tmp0[1];
        buf0[2].sd = tmp0[2];
        buf0[3].sd = tmp0[3];
        buf1[0].sd = tmp1[0];
        buf1[1].sd = tmp1[1];
        buf1[2].sd = tmp1[2];
        buf1[3].sd = tmp1[3];
        buf2[0].sd = tmp2[0];
        buf2[1].sd = tmp2[1];
        buf2[2].sd = tmp2[2];
        buf2[3].sd = tmp2[3];
        buf3[0].sd = tmp3[0];
        buf3[1].sd = tmp3[1];
        buf3[2].sd = tmp3[2];
        buf3[3].sd = tmp3[3];
        out_len.sd = tmp_len;
        break;

      case 14:
        buf0[0].se = tmp0[0];
        buf0[1].se = tmp0[1];
        buf0[2].se = tmp0[2];
        buf0[3].se = tmp0[3];
        buf1[0].se = tmp1[0];
        buf1[1].se = tmp1[1];
        buf1[2].se = tmp1[2];
        buf1[3].se = tmp1[3];
        buf2[0].se = tmp2[0];
        buf2[1].se = tmp2[1];
        buf2[2].se = tmp2[2];
        buf2[3].se = tmp2[3];
        buf3[0].se = tmp3[0];
        buf3[1].se = tmp3[1];
        buf3[2].se = tmp3[2];
        buf3[3].se = tmp3[3];
        out_len.se = tmp_len;
        break;

      case 15:
        buf0[0].sf = tmp0[0];
        buf0[1].sf = tmp0[1];
        buf0[2].sf = tmp0[2];
        buf0[3].sf = tmp0[3];
        buf1[0].sf = tmp1[0];
        buf1[1].sf = tmp1[1];
        buf1[2].sf = tmp1[2];
        buf1[3].sf = tmp1[3];
        buf2[0].sf = tmp2[0];
        buf2[1].sf = tmp2[1];
        buf2[2].sf = tmp2[2];
        buf2[3].sf = tmp2[3];
        buf3[0].sf = tmp3[0];
        buf3[1].sf = tmp3[1];
        buf3[2].sf = tmp3[2];
        buf3[3].sf = tmp3[3];
        out_len.sf = tmp_len;
        break;
      #endif
    }
  }

  return out_len;

  #endif
}

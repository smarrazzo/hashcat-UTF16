/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

#ifndef INC_RP_OPTIMIZED_H_UTF16LE_V3
#define INC_RP_OPTIMIZED_H_UTF16LE_V3

#include "inc_rp_common.h"

DECLSPEC void truncate_right_optimized_utf16le (PRIVATE_AS u32 *buf0, const u32 offset);
DECLSPEC void truncate_left_optimized_utf16le (PRIVATE_AS u32 *buf0, const u32 offset);
DECLSPEC void lshift_block_optimized_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0);
DECLSPEC void rshift_block_optimized_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0);
DECLSPEC void lshift_block_optimized_N_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0, const u32 num);
DECLSPEC void rshift_block_optimized_N_utf16le (PRIVATE_AS const u32 *in0, PRIVATE_AS u32 *out0, const u32 num);
DECLSPEC void append_block1_optimized_utf16le (const u32 offset, PRIVATE_AS u32 *buf0, const u32 src_r0);
DECLSPEC void append_block8_optimized_utf16le (const u32 offset, PRIVATE_AS u32 *buf0, PRIVATE_AS const u32 *src_l0, PRIVATE_AS const u32 *src_r0);
DECLSPEC void reverse_block_optimized_utf16le (PRIVATE_AS u32 *in0, PRIVATE_AS u32 *out0, const u32 len);
DECLSPEC void exchange_byte_optimized_utf16le (PRIVATE_AS u32 *buf, const int off_src, const int off_dst);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_lrest_ufirst_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_urest_lfirst_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_trest_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_shift_case_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_toggle_at_sep_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reverse_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeword_times_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_reflect_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_append_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_prepend_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_left_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_rotate_right_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_delete_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_extract_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_omit_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_insert_every_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_overstrike_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_truncate_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC u32 search_on_register_utf16le (const u32 in, const u32 p0);
DECLSPEC u32 replace_on_register_utf16le (const u32 in, const u32 r, const u32 p1);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_class_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_purgechar_class_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupechar_all_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_switch_at_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftl_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_shiftr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_incr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_decr_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_chr_add_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_np1_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_replace_nm1_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_first_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_dupeblock_last_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC u32 toggle_on_register_utf16le (const u32 in, const u32 r);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_title_sep_class_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_to_hex_lower_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC HC_INLINE_RP u32 rule_op_mangle_to_hex_upper_utf16le (MAYBE_UNUSED const u32 p0, MAYBE_UNUSED const u32 p1, MAYBE_UNUSED PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC u32 apply_rule_optimized_utf16le (const u32 name, const u32 p0, const u32 p1, PRIVATE_AS u32 *buf0, const u32 in_len);
DECLSPEC u32 apply_rules_optimized_utf16le (CONSTANT_AS const u64 *cmds, PRIVATE_AS u32 *buf0, const u32 len);
DECLSPEC u32x apply_rules_vect_optimized_utf16le (PRIVATE_AS const u32 *pw_buf0, const u32 pw_len, CONSTANT_AS const kernel_rule_t *kernel_rules, const u32 il_pos, PRIVATE_AS u32x *buf0 );

#endif // INC_RP_OPTIMIZED_H_UTF16LE_V3


/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

#ifndef INC_RP_H_UTF16LE
#define INC_RP_H_UTF16LE

#include "inc_rp_common.h"

DECLSPEC void append_four_byte_utf16le (PRIVATE_AS const u32 *buf_src, const int off_src, PRIVATE_AS u32 *buf_dst, const int off_dst);
DECLSPEC void append_three_byte_utf16le (PRIVATE_AS const u32 *buf_src, const int off_src, PRIVATE_AS u32 *buf_dst, const int off_dst);
DECLSPEC void append_two_byte_utf16le (PRIVATE_AS const u32 *buf_src, const int off_src, PRIVATE_AS u32 *buf_dst, const int off_dst);
DECLSPEC void append_one_byte_utf16le (PRIVATE_AS const u32 *buf_src, const int off_src, PRIVATE_AS u32 *buf_dst, const int off_dst);
DECLSPEC void append_block_utf16le (PRIVATE_AS const u32 *buf_src, const int off_src, PRIVATE_AS u32 *buf_dst, const int off_dst, const int len);
DECLSPEC void exchange_byte_utf16le (PRIVATE_AS u32 *buf, const int off_src, const int off_dst);
DECLSPEC int mangle_lrest_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_lrest_ufirst_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_urest_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_urest_lfirst_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_trest_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_shift_case_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_toggle_at_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_toggle_at_sep_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_reverse_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_dupeword_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_dupeword_times_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_reflect_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_append_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_prepend_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_rotate_left_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_rotate_right_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_delete_at_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_delete_first_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_delete_last_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_extract_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_omit_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_insert_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_insert_every_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_overstrike_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_truncate_at_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_replace_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_replace_class_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_purgechar_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_purgechar_class_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_dupechar_first_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_dupechar_last_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_dupechar_all_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_switch_first_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_switch_last_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_switch_at_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_chr_shiftl_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_chr_shiftr_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_chr_incr_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_chr_decr_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_chr_add_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_replace_np1_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_replace_nm1_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_dupeblock_first_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_dupeblock_last_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_title_sep_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_title_sep_class_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int len);
DECLSPEC int mangle_to_hex_lower_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int mangle_to_hex_upper_utf16le (MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u16 *buf, const int len);
DECLSPEC int apply_rule_utf16le (const u32 name, MAYBE_UNUSED const u16 p0, MAYBE_UNUSED const u16 p1, PRIVATE_AS u32 *buf, const int in_len);
DECLSPEC int apply_rules_utf16le (CONSTANT_AS const u64 *cmds, PRIVATE_AS u32 *buf, const int in_len);

#endif // INC_RP_H

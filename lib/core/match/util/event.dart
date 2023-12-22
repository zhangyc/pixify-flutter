enum MatchEvent{
  match_like,
  match_arrow_send,
  match_gopay,
  match_report,
  match_like_limit,
  match_popup_sona,
  //20231222 add
  match_like_wishlist,
  match_like_justlike,
  match_dislike
}
enum ChatEvent{
  pay_page_open,
  pay_profile,
  pay_chatlist_likedme,
  pay_chatlist_blur,
  pay_chat_sonamsg,
  pay_chat_suggest,
  pay_match_arrow,
  pay_match_likelimit,
  pay_continue,
  pay_manage,
  pay_cancel,
}
enum PayEvent{
  pay_continue,
  pay_manage,
  pay_cancel
}
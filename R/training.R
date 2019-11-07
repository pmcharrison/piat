training <- function(media_dir, num_items, dict) {
  psychTestR::new_timeline(psychTestR::join(
    intro(media_dir),
    repeatable_practice(media_dir),
    psychTestR::one_button_page(
      psychTestR::i18n("PIAT_016",
                       sub = c(num_items = num_items)),
      button_text = psychTestR::i18n("PIAT_024"))
  ), dict = dict)
}

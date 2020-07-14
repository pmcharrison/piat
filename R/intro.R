intro <- function(media_dir) {
  shiny::withTags(c(
    psychTestR::one_button_page(psychTestR::i18n("PIAT_002"),
                                button_text = psychTestR::i18n("PIAT_024")),
    psychTestR::one_button_page(psychTestR::i18n("PIAT_003"),
                                button_text = psychTestR::i18n("PIAT_024")),
    psychTestR::video_NAFC_page(
      label = "example_context",
      prompt = psychTestR::i18n("PIAT_004"),
      choices = psychTestR::i18n("PIAT_024"),
      url = file.path(media_dir, "Scale_C_ton.mp4"),
      save_answer = FALSE
    ),
    psychTestR::one_button_page(psychTestR::i18n("PIAT_005"),
                                button_text = psychTestR::i18n("PIAT_024")),
    psychTestR::video_NAFC_page(
      label = "example_arrows",
      prompt = psychTestR::i18n("PIAT_006"),
      choices = psychTestR::i18n("PIAT_024"),
      url = file.path(media_dir, "Example_Trial_sounded_arr.mp4"),
      save_answer = FALSE
    ),
    psychTestR::one_button_page(
      psychTestR::i18n("PIAT_007"),
      button_text = psychTestR::i18n("PIAT_024")
    ),
    psychTestR::video_NAFC_page(
      label = "example_silent_arrow",
      prompt = psychTestR::i18n("PIAT_008"),
      choices = psychTestR::i18n("PIAT_024"),
      url = file.path(media_dir, "Example_Trial_all_arr.mp4"),
      save_answer = FALSE
    ),
    psychTestR::one_button_page(
      psychTestR::i18n("PIAT_009"),
      button_text = psychTestR::i18n("PIAT_024")
    ),
    psychTestR::video_NAFC_page(
      label = "example_complete_trial",
      prompt = psychTestR::i18n("PIAT_010"),
      choices = c("match", "no_match"),
      labels = c(psychTestR::i18n("PIAT_020"),
                 psychTestR::i18n("PIAT_021")),
      url = file.path(media_dir, "Example_Trial_complete.mp4"),
      save_answer = FALSE
    ),
    psychTestR::one_button_page(psychTestR::i18n("PIAT_011"),
                                button_text = psychTestR::i18n("PIAT_024")),
    psychTestR::one_button_page(psychTestR::i18n("PIAT_012"),
                                button_text = psychTestR::i18n("PIAT_024"))
  ))
}

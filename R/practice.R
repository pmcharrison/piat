practice <- function(media_dir) {
  unlist(lapply(
    list(list(id = "Prac_Trial_Lvl1",
              answer = "match"),
         list(id = "Prac_Trial_Lvl2",
              answer = "no_match"),
         list(id = "Prac_Trial_Lvl3",
              answer = "match")
    ),
    function(x) {
      list(
        psychTestR::video_NAFC_page(
          label = "practice_question",
          prompt = psychTestR::i18n("PIAT_013"),
          url = file.path(media_dir, paste0(x$id, ".mp4")),
          choices = c("match", "no_match"),
          labels = c(psychTestR::i18n("PIAT_020"),
                     psychTestR::i18n("PIAT_021")),
          save_answer = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(
            if (answer == x$answer) psychTestR::i18n("PIAT_014") else
              psychTestR::i18n("PIAT_025"),
            button_text = psychTestR::i18n("PIAT_024")
          )}))}))
}

repeatable_practice <- function(media_dir) {
  c(
    psychTestR::code_block(function(state, ...) {
      psychTestR::set_local("do_practice", TRUE, state)
    }),
    psychTestR::while_loop(
      test = function(state, ...) psychTestR::get_local("do_practice", state),
      logic = c(
        practice(media_dir),
        psychTestR::NAFC_page(
          label = "check_repeat",
          prompt = psychTestR::i18n("PIAT_015"),
          choices = c("Yes", "No"),
          labels = c(psychTestR::i18n("PIAT_022"),
                     psychTestR::i18n("PIAT_023")),
          save_answer = FALSE,
          arrange_vertically = FALSE,
          on_complete = function(state, answer, ...) {
            psychTestR::set_local("do_practice", identical(answer, "Yes"), state)
          }
        )
      )))}

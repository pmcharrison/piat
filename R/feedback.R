#' PIAT feedback (no score)
#'
#' Here the participant is given no feedback at the end of the test.
#' @inheritParams piat
#' @export
piat.feedback.no_score <- function(dict = piat::piat_dict) {
  psychTestR::new_timeline(list(psychTestR::one_button_page(
    psychTestR::i18n("PIAT_018"),
    button_text = psychTestR::i18n("PIAT_024")
  )), dict = dict)
}

#' PIAT feedback (simple score)
#'
#' Here the participant's score is reported at the end of the test.
#' @inheritParams piat
#' @export
piat.feedback.simple_score <- function(dict = piat::piat_dict) {
  psychTestR::new_timeline(list(psychTestR::reactive_page(function(answer, ...) {
    psychTestR::one_button_page(shiny::div(
      shiny::p(psychTestR::i18n("PIAT_018")),
      shiny::p("Your score was:",
               shiny::strong(round(answer$ability, digits = 2)))
    ),
    button_text = psychTestR::i18n("PIAT_024"))
  })), dict = dict)
}

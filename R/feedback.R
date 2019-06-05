#' PIAT feedback (no score)
#'
#' Here the participant is given no feedback at the end of the test.
#' @export
piat.feedback.no_score <- function() {
  psychTestR::one_button_page("You finished the test!")
}

#' PIAT feedback (simple score)
#'
#' Here the participant's score is reported at the end of the test.
#' @export
piat.feedback.simple_score <- function() {
  psychTestR::reactive_page(function(answer, ...) {
    psychTestR::one_button_page(shiny::div(
      shiny::p("You finished the test!"),
      shiny::p("Your score was:",
               shiny::strong(round(answer$ability, digits = 2)))
    ))
  })
}

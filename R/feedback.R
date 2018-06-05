#' @export
piat.feedback.no_score <- function() {
  psychTest::one_button_page("You finished the test!")
}

#' @export
piat.feedback.simple_score <- function() {
  psychTest::reactive_page(function(answer, ...) {
    psychTest::one_button_page(shiny::div(
      shiny::p("You finished the test!"),
      shiny::p("Your score was:",
               shiny::strong(round(answer$ability, digits = 2)))
    ))
  })
}

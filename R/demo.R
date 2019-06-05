#' Demo PIAT
#'
#' This function launches a demo for the PIAT.
#'
#' @param num_items (Integer scalar) Number of items in the test.
#' @param take_training (Logical scalar) Whether to take the training phase.
#' @param feedback (Function) Defines the feedback to give the participant
#' at the end of the test. Defaults to a graph-based feedback page.
#' @param admin_password (Scalar character) Password for accessing the admin panel.
#' Defaults to \code{"demo"}.
#' @param researcher_email (Scalar character)
#' If not \code{NULL}, this researcher's email address is displayed
#' at the bottom of the screen so that online participants can ask for help.
#' @param ... Further arguments to be passed to \code{\link{piat}()}.
#' @export
demo_piat <- function(num_items = 10L,
                      take_training = TRUE,
                      feedback = psychTestRCAT::cat.feedback.graph("PIAT"),
                      admin_password = "demo",
                      researcher_email = NULL,
                      ...) {
  elts <- c(
    psychTestR::one_button_page("Welcome to the PIAT demo!"),
    piat::piat(num_items = num_items,
               take_training = take_training,
               feedback = feedback,
               ...),
    psychTestR::final_page("You may now close the browser window.")
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::pt_options(title = "PIAT demo",
                                admin_password = admin_password,
                                researcher_email = researcher_email,
                                demo = TRUE))
}

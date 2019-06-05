#' Standalone PIAT
#'
#' This function launches a standalone testing session for the PIAT.
#' This can be used for data collection, either in the laboratory or online.
#' @param title (Scalar character) Title to display during testing.
#' @param admin_password (Scalar character) Password for accessing the admin panel.
#' @param researcher_email (Scalar character)
#' If not \code{NULL}, this researcher's email address is displayed
#' at the bottom of the screen so that online participants can ask for help.
#' @param ... Further arguments to be passed to \code{\link{piat}()}.
#' @export
standalone_piat <- function(title = "Pitch imagery ability test",
                            admin_password = "replace-with-secure-password",
                            researcher_email = NULL,
                            ...) {
  elts <- c(
    psychTestR::new_timeline(
      psychTestR::get_p_id(),
    ),
    piat(...),
    psychTestR::elt_save_results_to_disk(complete = TRUE),
    psychTestR::new_timeline(
      psychTestR::final_page(shiny::p(
        "Your results have now been saved.",
        "You may close the browser window."
      ))
    ))

  psychTestR::make_test(
    elts,
    opt = psychTestR::pt_options(title = title,
                                 admin_password = admin_password,
                                 researcher_email = researcher_email,
                                 demo = FALSE)
  )
}

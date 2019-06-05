#' PIAT
#'
#' This function defines an pitch imagery ability test (PIAT)
#' module for incorporation into a psychTestR timeline.
#' Use this function if you want to include the PIAT in a
#' battery of other tests, or if you want to add custom psychTestR
#' pages to your test timeline.
#' For demoing the PIAT, consider using \code{\link{demo_piat}()}.
#' For a standalone implementation of the PIAT,
#' consider using \code{\link{standalone_piat}()}.
#'
#' @param num_items (Integer scalar) Number of items in the test.
#' @param take_training (Logical scalar) Whether to include the training phase.
#' @param label (Character scalar) Label to give the PIAT results in the output file.
#' @param feedback (Function) Defines the feedback to give the participant
#' at the end of the test. By default no feedback is given.
#' @param media_dir (Character scalar) File path to the directory
#' hosting the test's media files (typically a publicly accessible web directory).
#'
#' @export
piat <- function(num_items = 25L,
                 take_training = TRUE,
                 label = "PIAT",
                 feedback = piat.feedback.no_score(),
                 media_dir = "http://media.gold-msi.org/test_materials/PIAT/1-0-1/mp4") {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(media_dir),
            is.null(feedback) || is(feedback, "test_element") || is.list(feedback))
  media_dir <- gsub("/$", "", media_dir)

  c(
    if (take_training) training(media_dir, num_items),
    main_test(label, media_dir, num_items),
    feedback
  )
}

practice <- function(media_dir) {
  lapply(
    list(list(id = "Prac_Trial_Lvl1",
              answer = "Match"),
         list(id = "Prac_Trial_Lvl2",
              answer = "No match"),
         list(id = "Prac_Trial_Lvl3",
              answer = "Match")
    ),
    function(x) {
      list(
        psychTest::video_NAFC_page(
          label = "practice_question",
          prompt = "Did the final tone match the note you were imagining?",
          url = file.path(media_dir, paste0(x$id, ".mp4")),
          choices = c("Match", "No match")
        ),
        psychTest::reactive_page(function(answer, ...) {
          psychTest::one_button_page(
            if (answer == x$answer) "You answered correctly!" else
              "You answered incorrectly."
          )}))}) %>%
    unlist
}

repeatable_practice <- function(media_dir) {
  c(
    psychTest::code_block(function(state, ...) {
      psychTest::set_local("do_practice", TRUE, state)
    }),
    psychTest::loop_while(
      test = function(state, ...) psychTest::get_global("do_practice", state),
      logic = c(
        practice(media_dir),
        psychTest::NAFC_page(
          label = "check_repeat",
          prompt = "Would you like to try the practice examples again?",
          choices = c("Yes", "No"),
          save_answer = FALSE,
          arrange_vertically = FALSE,
          on_complete = function(state, answer, ...) {
            psychTest::set_local("do_practice", identical(answer, "Yes"))
          }
        )
      )))}

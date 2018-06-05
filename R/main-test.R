main_test <- function(label, media_dir, num_items) {
  psychTestCAT::adapt_test(
    label = label,
    item_bank = get_item_bank(),
    show_item = show_item(media_dir),
    stopping_rule = psychTestCAT::stopping_rule.num_items(n = num_items),
    opt = piat.options()
  )
}

show_item <- function(media_dir) {
  function(item) {
    stopifnot(is(item, "item"), nrow(item) == 1L)
    item_number <- psychTestCAT::get_item_number(item)
    num_items_in_test <- psychTestCAT::get_num_items_in_test(item)
    psychTest::video_NAFC_page(
      label = paste0("q", item_number),
      prompt = get_prompt(item_number, num_items_in_test),
      choices = get_choices(),
      url = get_item_path(item, media_dir)
    )
  }
}

get_item_path <- function(item, media_dir) {
  stopifnot(is(item, "item"), nrow(item) == 1L)
  file.path(media_dir, paste0(item$Filename, ".mp4"))
}

get_prompt <- function(item_number, num_items_in_test) {
  shiny::div(
    shiny::p(
      "Question ",
      shiny::strong(item_number),
      " out of ",
      shiny::strong(if (is.null(num_items_in_test)) "?" else num_items_in_test)),
    shiny::p(
      "Did the final tone match the note you were imagining?"
    ))
}

get_choices <- function() {
  c(`Match` = "1", `No match` = "0")
}

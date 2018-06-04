test_modules$main_piat <- list(
  new("code_block",
      fun = function(rv, input) {
        rv$results$piat <- list(items = getStimuli(num_items = rv$admin$num_items))
      }),
  new("reactive_test_element",
      fun = function(rv) {
        new("one_btn_page",
            body = tags$p(sprintf("You are about to proceed to the main test, where you will answer %i questions similar to the ones you just tried. You won't receive any feedback on these questions. Some might be very difficult, but don't worry, you're not expected to get everything right. If you really don't know the answer, just give your best guess.",
                                  nrow(rv$results$piat$items))))
      }),
  PIATitems
)

PIATitems <- new(
  "reactive_test_element",
  fun = function(rv) {
    items_df <- rv$results$piat$items
    item_position <- rv$piat_item_index
    new("video_stimulus_NAFC",
        prompt = tags$div(
          tags$strong(sprintf("Question %i out of %i:",
                              item_position, nrow(items_df))),
          tags$p("Did the final tone match the note you were imagining?")),
        source = file.path(media_dir,
                           paste0("main/mp4/",
                                  items_df$Filename[item_position], ".mp4")),
        type = "mp4",
        response_options = c("Match", "No match"),
        wait = TRUE,
        on_complete = function(rv, input) {
          ParticipantResponse <- if (input$Match == 1) {
            "Match"
          } else if (input$`No match` == 1) {
            "No match"
          } else stop("This shouldn't happen!")
          correct_answer <- if (items_df$ProbeAcc[item_position] == 1) {
            "Match"
          } else if (items_df$ProbeAcc[item_position] == 0) {
            "No match"
          } else stop()
          ParticipantCorrect <- ParticipantResponse == correct_answer
          rv$results$piat$items$ParticipantResponse[item_position] <- ParticipantResponse
          rv$results$piat$items$ParticipantCorrect[item_position] <- ParticipantCorrect
          if (item_position < nrow(items_df)) {
            decrementPageIndex(rv)
            rv$piat_item_index <- rv$piat_item_index + 1
          }
        })
  }
)

stop("Finish this page")

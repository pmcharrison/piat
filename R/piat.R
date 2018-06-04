piat <- function(label = "piat",
                 num_items = 10L,
                 take_training = TRUE,
                 label = "PIAT",
                 feedback = piat.feedback_no_score(),
                 media_dir = ) {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(item_bank_audio))
            # is.scalar.character(practice_items))
  media_dir <- gsub("/$", "", media_dir)

  c(
    if (take_training) training(),
    main_test(label, item_bank_audio, num_items),
    feedback
  )
  # item_bank <-
}

training <- function() {
  NULL
}

main_test <- function(label, item_bank_audio, num_items) {
  psychTestCAT::adapt_test(
    label = label,
    item_bank = read.csv(system.file("item-bank.csv", package = "piat",
                                     mustWork = TRUE),
                         stringsAsFactors = FALSE),
    show_item = show_item(item_bank_audio),
    stopping_rule = psychTestCAT::stopping_rule.num_items(n = num_items),
    opt = piat.options()
  )
}

piat.feedback.no_score <- function() {
  psychTest::one_button_page("You finished the test!")
}

piat.options <- function() {
  psychTestCAT::adapt_test_options(
    next_item.criterion = "bOpt",
    next_item.estimator = "BM",
    next_item.prior_dist = "norm",
    next_item.prior_par = c(0, 1),
    final_ability.estimator = "WL"
  )
}

show_item <- function(item_bank_audio) {
  function(item) {
    stopifnot(is(item, "item"), nrow(item) == 1L)
    item_number <- psychTestCAT::get_item_number(item)
    num_items_in_test <- psychTestCAT::get_num_items_in_test(item)
    prompt <- get_prompt(item_number, num_items_in_test)
    choices <- get_choices()
    psychTest::audio_NAFC_page(
      label = paste0("q", item_number),
      prompt = prompt,
      choices = choices,
      url = file.path(item_bank_audio, item$file_name),
      wait = FALSE,
      on_complete = NULL
    )
  }
}

get_prompt <- function(item_number, num_items_in_test) {
  shiny::div(
    shiny::p(
      "Question ",
      shiny::strong(item_number),
      " out of ",
      shiny::strong(if (is.null(num_items_in_test)) "?" else num_items_in_test)),
    shiny::p(
      "In which extract was the beep-track on the beat?"
    ))
}

get_choices <- function() {
  c(`First was on the beat` = "1", `Second was on the beat` = "2")
}

test_modules$repeatable_practice_questions <-
  c(test_modules$practice_questions,
    new("page_NAFC",
        prompt = tags$p("Would you like to try the practice examples again?"),
        response_options = c("Yes", "No"),
        on_complete = function(rv, input) {
          try_again <- if (input$Yes == 1) {
            TRUE
          } else if (input$No == 1) {
            FALSE
          } else stop()
          if (try_again) {
            decrementPageIndex(rv, by = 1 + length(test_modules$practice_questions))
          }
        }))

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

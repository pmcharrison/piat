#Automated testing for PIAT
library(psychTestR)
library(testthat)

dir <- system.file("", package = "piat", mustWork = TRUE)

number_items <- 20 #number of items

app <<- AppTester$new(dir)

# ID
app$expect_ui_text("Please enter your participant ID. Next")
app$set_inputs(p_id = "abcde")
app$click_next()

# Training
app$expect_ui_text("The Pitch Imagery Arrow Task has been designed to teach you to successfully imagine musical tones from a visual prompt. Next")
app$click_next()

app$expect_ui_text("Each trial starts with the word “Begin” on the screen, and you will hear an ascending major scale, which provides the key or context for that trial. You will then see a dot on the screen and hear a start note. Press “Next” for an example of this. Next")
app$click_next()

app$expect_ui_text("Here is an example context: Click here to play Next")
app$click("Next")

app$expect_ui_text("A variable number of up and/or down arrows will then appear in a sequence, with a corresponding tone, that is stepping up or down the scale. Press “Next” for an example of these arrows appearing after the ascending scale and start note. Next")
app$click_next()

app$expect_ui_text("Here is an example of arrows appearing after the ascending scale and start note: Click here to play Next")
app$click("Next")

app$expect_ui_text("At some point in the trial, an arrow is shown with no tone heard. Your job is to imagine that exact missing tone. The number of tones to be imagined in each trial will vary from 1 to 5 tones. The word “hold” will appear with the last silent arrow of the sequence. Hold in your mind the sound of this last tone as you prepare to hear a test tone. Press “Next” for an example of a single silent arrow added to our trial example. Next")
app$click_next()

app$expect_ui_text("Here is an example: Click here to play Next")
app$click("Next")

app$expect_ui_text("To test the accuracy of your imagery, a test tone will be sounded and a white fixation cross will display. The tone will either match the note you are imagining or it won't match. Your task will be to determine which is the case. Press 'Next' for the full example trial and try to respond correctly. Next")
app$click_next()

app$expect_ui_text("Here is an example complete trial: Click here to play Match No match")
app$click("match")

app$expect_ui_text("We encourage you to just use your imagery to play the missing notes in your head, and don’t hum or move as you imagine. From earlier tests we know that using only your imagery gives the best results on the test. Next")
app$click_next()

app$expect_ui_text("There are 3 practice trials in which you will receive feedback. You are free to attempt these as many times as you wish to familiarise yourself with the task. Next")
app$click_next()

app$expect_ui_text(paste("Did the final tone match the note you were imagining? Click here to play Match No match"))
app$click("match")

app$expect_ui_text("You answered correctly! Next")
app$click_next()

app$expect_ui_text(paste("Did the final tone match the note you were imagining? Click here to play Match No match"))
app$click("match")

app$expect_ui_text("You answered incorrectly. Next")
app$click_next()

app$expect_ui_text(paste("Did the final tone match the note you were imagining? Click here to play Match No match"))
app$click("no_match") # ??? "No match" throws an error.

app$expect_ui_text("You answered incorrectly. Next")
app$click_next()

app$expect_ui_text("Would you like to try the practice examples again? Yes No")
app$click("No")

app$expect_ui_text("You are about to proceed to the main test, where you will answer 20 questions similar to the ones you just tried. You won't receive any feedback on these questions. Some might be very difficult, but don't worry, you're not expected to get everything right. If you really don't know the answer, just give your best guess. Next")
app$click_next()

# Main test
q <- 1 # Number of question
for (i in sample(0:1, number_items, replace=TRUE)){
  app$expect_ui_text(paste("Question", q, "out of", number_items, "Did the final tone match the note you were imagining? Click here to play Match No match"))
  app$click(i) #0 = No match
  print(paste0("answer", i))
  q <- q + 1
}

app$expect_ui_text("You finished the test! Next")
app$click_next()

# Results
results <- app$get_results() %>% as.list()
print(j)
PIAT_SEM[j] <<- results[["PIAT"]][["ability_sem"]]
PIAT_ability[j] <<- results[["PIAT"]][["ability"]]

print(paste("Standard error of measurement of PIAT", PIAT_SEM[j]))
app$stop()

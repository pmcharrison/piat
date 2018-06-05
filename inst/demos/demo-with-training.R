elts <- c(
  psychTest::one_button_page("Welcome to the PIAT demo!"),
  piat::piat(num_items = 20L,
             take_training = TRUE,
             feedback = piat::piat.feedback.simple_score()),
  psychTest::final_page("You may now close the browser window.")
)

test <- psychTest::make_test(
  elts,
  opt = psychTest::pt_options(title = "PIAT",
                              admin_password = "conifer",
                              researcher_email = "p.m.c.harrison@qmul.ac.uk",
                              demo = TRUE))
shiny::runApp(test)

input <- read.csv("data-raw/piat-dict.csv", stringsAsFactors = FALSE, encoding = "utf-8")

# names(input)[[1]] <- "key"

# russian <- read.csv("data-raw/dict-russian.csv", stringsAsFactors = FALSE)
# names(russian)[[1]] <- "key"
# stopifnot(!anyDuplicated(input$key),
#           all(input$key == russian$key))
# input$RU <- russian$RU

latvian <- read.csv("data-raw/dict-latvian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(latvian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == latvian$key))
input$LV <- latvian$LV

piat_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(piat_dict, overwrite = TRUE)

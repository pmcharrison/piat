library(waldo)

input_path <- "data-raw/piat-dict.csv"
input <- read.csv(input_path, stringsAsFactors = FALSE, encoding = "utf-8")

# Check against archive versions
archive_versions_to_check <- c("data-raw/piat-dict-archive-2.csv")
for (path in archive_versions_to_check) {
  archive_version <- read.csv(path, stringsAsFactors = FALSE, encoding = "utf-8")

  test <-
    waldo::compare(
      archive_version,
      input[names(archive_version)]
    )

  if (length(test) > 0) {
    print(test)
    stop("Inconsistency found between ", input_path, " and ", path,
         ", see above for details.")
  }
}

latvian <- read.csv("data-raw/dict-latvian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(latvian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == latvian$key))
input$LV <- latvian$LV

piat_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(piat_dict, overwrite = TRUE)

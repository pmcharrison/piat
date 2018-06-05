get_item_bank <- function() {
  x <- read.csv(system.file("item-bank.csv", package = "piat",
                            mustWork = TRUE),
                stringsAsFactors = FALSE)
  x$answer <- x$ProbeAcc
  stopifnot(is.numeric(x$answer))
  x
}

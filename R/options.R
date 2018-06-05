piat.options <- function() {
  psychTestCAT::adapt_test_options(
    next_item.criterion = "bOpt",
    next_item.estimator = "BM",
    next_item.prior_dist = "Jeffreys",
    # next_item.prior_par = c(0, 2),
    final_ability.estimator = "WL"
  )
}

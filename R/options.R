piat.options <- function() {
  psychTestCAT::adapt_test_options(
    next_item.criterion = "bOpt",
    next_item.estimator = "BM",
    next_item.prior_dist = "norm",
    next_item.prior_par = c(0, 1),
    final_ability.estimator = "WL"
  )
}

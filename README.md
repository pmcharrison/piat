# Pitch Imagery Arrow Test (PIAT)

Work in progress - contact us if you are interested in using the PIAT in a study.

You can try the [online demo](http://shiny.pmcharrison.com/piat-demo) here!

## Installation instructions (local use)

1. If you don't have R installed, install it from here: https://cloud.r-project.org/

2. Open R.

3. Install the ‘devtools’ package with the following command:

`install.packages('devtools')`

4. Install the PIAT:

`devtools::install_github('pmcharrison/piat')`

## Usage

### Quick demo 

You can demo the PIAT at the R console, as follows:

``` r
# Load the piat package
library(piat)

# Run a demo test, with feedback as you progress through the test,
# and not saving your data
demo_piat()

# Run a demo test, skipping the training phase, and only asking 5 questions
demo_piat(num_items = 5, take_training = FALSE)
```

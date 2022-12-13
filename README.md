# Adaptive Pitch Imagery Arrow Test (aPIAT)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3239098.svg)](https://doi.org/10.5281/zenodo.3239098)
[![Travis build status](https://travis-ci.com/pmcharrison/piat.svg?branch=master)](https://travis-ci.com/pmcharrison/piat)

The aPIAT is an adaptive test of pitch imagery abilities.
We invite you to try the test [here](http://shiny.pmcharrison.com/piat-demo).

## Citation

You can cite the aPIAT as follows:

Gelding, R., Harrison, P. M. C., Silas, S., Johnson, B. W., Thompson, W. F., and Müllensiefen, D., 2020. Developing an efficient test of musical imagery ability: Applying modern psychometric techniques to the Pitch Imagery Arrow Task. *Psychological Research*. https://doi.org/10.1007/s00426-020-01322-3

We also advise mentioning the software versions you used,
in particular the versions of the `piat`, `psychTestR`, and `psychTestRCAT` packages.
You can find these version numbers from R by running the following commands:

``` r
library(piat)
library(psychTestR)
library(psychTestRCAT)
if (!require(devtools)) install.packages("devtools")
x <- devtools::session_info()
x$packages[x$packages$package %in% c("piat", "psychTestR", "psychTestRCAT"), ]
```

You can cite psychTestR as follows:

> Harrison, Peter M. C. (2020).
> psychTestR: An R package for designing and
> conducting behavioural psychological experiments.
> *Journal of Open Source Software*. https://doi.org/10.21105/joss.02088

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

### Testing a participant

The `standalone_piat()` function is designed for real data collection.
In particular, the participant doesn't receive feedback during this version.

``` r
# Load the piat package
library(piat)

# Run the test as if for a participant, using default settings,
# saving data, and with a custom admin password
standalone_piat(admin_password = "put-your-password-here")
```

You will need to enter a participant ID for each participant.
This will be stored along with their results.

Each time you test a new participant,
rerun the `standalone_piat()` function,
and a new participation session will begin.

You can retrieve your data by starting up a participation session,
entering the admin panel using your admin password,
and downloading your data.
For more details on the psychTestR interface, 
see http://psychtestr.com/.

The PIAT uses video files that are currently stored on our media servers.
As a result, it requires an internet connection to function properly.

The PIAT currently supports English (EN), German (DE), and Turkish (TR).
If you would like to add a new language to this list, please contact us.
You can select one of these languages by passing a language code as 
an argument to `standalone_piat()`, e.g. `standalone_piat(languages = "DE")`,
or alternatively by passing it as a URL parameter to the test browser,
eg. http://127.0.0.1:4412/?language=DE (note that the `p_id` argument must be empty).
Please note that the demo version of the test (`demo_piat`)
currently only supports English.

### Results

The main output from the PIAT is an `ability` score,
corresponding to the ability estimate for the participant.
It is computed from the underlying item response model and ranges approximately from -4 to +4.
A secondary output is an `ability_sem` score, 
corresponding to the standard error of measurement for the ability estimate;
again, it is computed from the underlying IRT model.
For most applications you would only use the `ability` value,
unless using a statistical analysis technique that allows you to specify measurement error explicitly.
For more information about item response theory, see the [Wikipedia](https://en.wikipedia.org/wiki/Item_response_theory) article.

psychTestR provides several ways of retrieving test results (see http://psychtestr.com/).
Most are accessed through the test's admin panel.

* If you are just interested in the participants' final scores,
the easiest solution is usually to download the results in CSV format from the admin panel.
* If you are interested in trial-by-trial results, you can run the command
`compile_trial_by_trial_results()` from the R console
(having loaded the MDT package using `library(piat)`).
Type `?compile_trial_by_trial_results()` for more details.
* If you want still more detail, you can examine the individual RDS output files using `readRDS()`. 
Detailed results are stored as the 'metadata' attribute for the ability field. 
You can access it something like this: 

``` r
x <- readRDS("output/results/id=1&p_id=test&save_id=1&pilot=false&complete=true.rds")
attr(x$PIAT$ability, "metadata")
```

## Installation instructions (Shiny Server)

1. Complete the installation instructions described under 'Local use'.
2. If not already installed, install Shiny Server Open Source:
https://www.rstudio.com/products/shiny/download-server/
3. Navigate to the Shiny Server app directory.

`cd /srv/shiny-server`

4. Make a folder to contain your new Shiny app.
The name of this folder will correspond to the URL.

`sudo mkdir piat`

5. Make a text file in this folder called `app.R`
specifying the R code to run the app.

- To open the text editor: `sudo nano piat/app.R`
- Write the following in the text file:

``` r
library(piat)
standalone_piat(admin_password = "put-your-password-here")
```

- Save the file (CTRL-O).

6. Change the permissions of your app directory so that `psychTestR`
can write its temporary files there.

`sudo chown -R shiny piat`

where `shiny` is the username for the Shiny process user
(this is the usual default).

7. Navigate to your new shiny app, with a URL that looks like this:
http://my-web-page.org:3838/piat

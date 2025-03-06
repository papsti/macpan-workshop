Workshop on `macpan2` – Technical Preparation
================

<!-- omit from toc -->

## Table of Contents

-   [The Most Important Things](#the-most-important-things)
-   [Installing a Sufficiently Recent Version of
    R](#installing-a-sufficiently-recent-version-of-r)
-   [Installing Supporting R
    Packages](#installing-supporting-r-packages)
-   [Installing `macpan2`](#installing-macpan2)
-   [Verify that Everything Worked](#verify-that-everything-worked)

This document describes what you will need to do to have your computer
ready for the [`macpan2`](https://canmod.github.io/macpan2/) workshop.

## The Most Important Things

If you have trouble or questions about any of the technical instructions
below, please contact [Steve Walker](mailto:swalk@mcmaster.ca) (the
instructor) as soon as possible so that we can focus on the material
during the workshop without technical distractions.

Ideally you will be able to install open source software from the
internet, both before and during the workshop. If this is not possible,
please contact [Steve](mailto:swalk@mcmaster.ca) as soon as possible.

Everything we do in the workshop will involve
[R](https://www.r-project.org/). If you do not use R, please email
[Steve](mailto:swalk@mcmaster.ca) and briefly describe your coding
background.

## Installing a Sufficiently Recent Version of R

If you are familiar with [R](https://www.r-project.org/) and have it
installed, you just need to make sure that you have a sufficiently
recent version. Please start R and print out the R version using the
following command.

``` r
print(R.version.string)
```

    ## [1] "R version 4.4.2 (2024-10-31)"

This shows that I am using version R version 4.4.2 (2024-10-31). The
version you get will likely be different. You need to have an R version
greater than or equal to `4.1.0`. If your version is too old, please
install the most recent version of R following instructions
[here](https://cran.rstudio.com/).

If you do not have R installed already, I recommend following the
installation instructions for
[RStudio](https://posit.co/download/rstudio-desktop/). These
instructions involve first installing [R](https://cran.rstudio.com/) and
then RStudio itself, which is the program that I will use to interact
with R during the workshop.

It is fine if you would rather use R without RStudio, but if you do not
have a strong preference I recommend using RStudio.

## Installing Supporting R Packages

The [`macpan2`](https://canmod.github.io/macpan2/) package is designed
to be used with a set of packages known as the
[tidyverse](https://www.tidyverse.org/). To get these packages, and one
more that we will also be using, please open R and issue the following
command.

``` r
install.packages(c("tidyverse", "broom.mixed"))
```

## Installing `macpan2`

To install [`macpan2`](https://canmod.github.io/macpan2/) itself, please
issue the following commands.

``` r
repos = c('https://canmod.r-universe.dev', 'https://cloud.r-project.org')
install.packages('macpan2', repos = repos)
```

## Verify that Everything Worked

A good test of the above instructions is to copy and paste the following
lines of code, and make sure that you get the same graph printed out
below.

``` r
library(macpan2); library(tidyverse)
```

    ## ── Attaching core tidyverse packages ─────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ───────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::all_equal() masks macpan2::all_equal()
    ## ✖ dplyr::filter()    masks stats::filter()
    ## ✖ dplyr::lag()       masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
("starter_models"
 |> mp_tmb_library("sir", package = "macpan2")
 |> mp_simulator(time_steps = 50, outputs = "infection")
 |> mp_trajectory()
 |> mutate(incidence = value)
 |> ggplot() 
 + geom_line(aes(time, incidence))
 + theme_bw()
)
```

![](figures/sir-1.png)<!-- -->

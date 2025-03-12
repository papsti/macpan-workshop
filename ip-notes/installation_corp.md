# Installation notes

``` r
install.packages(c("tidyverse", "broom.mixed"))

repos = c('https://canmod.r-universe.dev', 'https://cloud.r-project.org')
install.packages('macpan2', repos = repos)
```

worked with no issues. Running the code in `installation_check.R`...

``` r
> library(macpan2); library(tidyverse)
Warning messages:
1: package ‘macpan2’ was built under R version 4.3.3 
2: In checkMatrixPackageVersion(getOption("TMB.check.Matrix", TRUE)) :
  Package version inconsistency detected.
TMB was built with Matrix ABI version 0
Current Matrix ABI version is 1
Please re-install 'TMB' from source using install.packages('TMB', type = 'source') or ask CRAN for a binary version of 'TMB' matching CRAN's 'Matrix' package
── Attaching core tidyverse packages ───────────────────────────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.0     ✔ tibble    3.2.1
✔ lubridate 1.9.3     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ─────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::all_equal() masks macpan2::all_equal()
✖ dplyr::filter()    masks stats::filter()
✖ dplyr::lag()       masks stats::lag()
ℹ Use the conflicted package to force all conflicts to become errors
Warning messages:
1: package ‘tidyverse’ was built under R version 4.3.3 
2: package ‘ggplot2’ was built under R version 4.3.3 
3: package ‘tibble’ was built under R version 4.3.3 
4: package ‘tidyr’ was built under R version 4.3.3 
5: package ‘readr’ was built under R version 4.3.3 
6: package ‘purrr’ was built under R version 4.3.3 
7: package ‘stringr’ was built under R version 4.3.3 
8: package ‘forcats’ was built under R version 4.3.3 
9: package ‘lubridate’ was built under R version 4.3.3
```

Trying `install.packages('TMB', type = 'source')` to fix the TBM warning...

``` r
> install.packages('TMB', type = 'source')
# Downloading packages -------------------------------------------------------
- Downloading TMB from CRAN ...                 OK [744 Kb in 0.59s]
Successfully downloaded 1 package in 1.2 seconds.

The following package(s) will be installed:
- TMB [1.9.17]
These packages will be installed into "~/git-repos/macpan-workshop/renv/library/R-4.3/x86_64-w64-mingw32".

Do you want to proceed? [Y/n]: 
# Installing packages --------------------------------------------------------
- Installing TMB ...                            OK [built from source and cached in 1.4m]
Successfully installed 1 package in 1.5 minutes.

The following loaded package(s) have been updated:
- TMB
Restart your R session to use the new versions.
> rstudioapi::restartSession()

Restarting R session...
> library(macpan2)
Warning messages:
1: package ‘macpan2’ was built under R version 4.3.3 
2: package ‘tidyverse’ was built under R version 4.3.3 
3: package ‘ggplot2’ was built under R version 4.3.3 
4: package ‘tibble’ was built under R version 4.3.3 
5: package ‘tidyr’ was built under R version 4.3.3 
6: package ‘readr’ was built under R version 4.3.3 
7: package ‘purrr’ was built under R version 4.3.3 
8: package ‘stringr’ was built under R version 4.3.3 
9: package ‘forcats’ was built under R version 4.3.3 
10: package ‘lubridate’ was built under R version 4.3.3 
```

Success! Now to address the other warnings, Steve suggested `remotes::install_github("canmod/macpan2")` (presumably to install from source and not a pre-built binary). Restart R session to unload `{macpan2}` and then...

``` r
remotes::install_github("canmod/macpan2")
Downloading GitHub repo canmod/macpan2@HEAD
These packages have more recent versions available.
It is recommended to update all of them.
Which would you like to update?

1: All                                      
2: CRAN packages only                       
3: None                                     
4: Rcpp      (1.0.12    -> 1.0.14   ) [CRAN]
5: fastmap   (1.1.1     -> 1.2.0    ) [CRAN]
6: rlang     (1.1.3     -> 1.1.5    ) [CRAN]
7: RcppEigen (0.3.4.0.0 -> 0.3.4.0.2) [CRAN]
8: cachem    (1.0.8     -> 1.1.0    ) [CRAN]
9: jsonlite  (1.8.8     -> 1.9.1    ) [CRAN]

Enter one or more numbers, or an empty line to skip updates: 3
── R CMD build ──────────────────────────────────────────────────────────────────────────────────────
✔  checking for file 'C:\Users\IPAPST\AppData\Local\Temp\RtmpMJSVAJ\remotes6a98ac9631\canmod-macpan2-306859b/DESCRIPTION' (899ms)
─  preparing 'macpan2': (6.4s)
✔  checking DESCRIPTION meta-information
─  cleaning src
─  checking for LF line-endings in source and make files and shell scripts (3.1s)
─  checking for empty or unneeded directories (824ms)
   Removed empty directory 'macpan2/misc'
   Omitted 'LazyData' from DESCRIPTION
─  building 'macpan2_1.15.3.tar.gz'
   
Installing package into ‘C:/Users/IPAPST/git-repos/macpan-workshop/renv/library/R-4.3/x86_64-w64-mingw32’
(as ‘lib’ is unspecified)
...
installing to C:/Users/IPAPST/git-repos/macpan-workshop/renv/library/R-4.3/x86_64-w64-mingw32/00LOCK-macpan2/00new/macpan2/libs/x64
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (macpan2)
Warning messages:
1: In untar2(tarfile, files, list, exdir, restore_times) :
  skipping pax global extended headers
2: In untar2(tarfile, files, list, exdir, restore_times) :
  skipping pax global extended headers
```

Loading `{macpan2}` again, there are no warnings, hooray! Loading the `{tidyverse}`, however, does yield similar warnings, along with a bunch of conflicts. I could clear the warnings with source installs, but I won't bother for now. For the conflicts, we have:

``` r
── Conflicts ─────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::all_equal() masks macpan2::all_equal()
✖ dplyr::filter()    masks stats::filter()
✖ dplyr::lag()       masks stats::lag()
```

I won't bother with this for now either.

Executing the test code from `technical-preparation.md` (see `ip-notes/installation_check.R`), I manage to produce the expected result.
# Installation notes

Following `technical-preparation.md`.

```
repos = c('https://canmod.r-universe.dev', 'https://cloud.r-project.org')
install.packages('macpan2', repos = repos)
```

yeilds the following on the Science Network RStudio server

```
The following required system packages are not installed:
- libcurl4-openssl-dev  [required by curl]
- libfontconfig1-dev    [required by systemfonts]
- libfreetype6-dev      [required by systemfonts, textshaping, ragg]
- libfribidi-dev        [required by textshaping]
- libharfbuzz-dev       [required by textshaping]
- libjpeg-dev           [required by ragg]
- libpng-dev            [required by ragg]
- libtiff-dev           [required by ragg]
- libx11-dev            [required by clipr]
- pandoc                [required by knitr, rmarkdown, reprex]
The R packages depending on these system packages may fail to install.

An administrator can install these packages with:
- sudo apt install libcurl4-openssl-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev libharfbuzz-dev libjpeg-dev libpng-dev libtiff-dev libx11-dev pandoc

Do you want to proceed? [Y/n]:
```

Selecting Y, everything goes well until

```
- Installing curl ...                           FAILED
Error: Error installing package 'curl':
================================

* installing *source* package 'curl' ...
** package 'curl' successfully unpacked and MD5 sums checked
** using staged installation
Using PKG_CFLAGS=
Using PKG_LIBS=-lcurl
--------------------------- [ANTICONF] --------------------------------
Configuration failed because libcurl was not found. Try installing:
 * deb: libcurl4-openssl-dev (Debian, Ubuntu, etc)
 * rpm: libcurl-devel (Fedora, CentOS, RHEL)
If libcurl is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a libcurl.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
-------------------------- [ERROR MESSAGE] ---------------------------
<stdin>:1:10: fatal error: curl/curl.h: No such file or directory
compilation terminated.
--------------------------------------------------------------------
ERROR: configuration failed for package 'curl'
* removing '/home/CSCScience.ca/ipapst/git-repos/macpan-workshop/renv/staging/1/curl'
install of package 'curl' failed [error code 1]
```



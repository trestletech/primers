ARG R_VERSION=3.6.2
FROM rstudio/r-base:${R_VERSION}-bionic

# TODO: collapse all of these lines into one
RUN R -e "options(repos=c(CRAN='https://demo.rstudiopm.com/all/__linux__/bionic/latest')); install.packages(c('remotes')); remotes::install_github('rstudio/connectapi')"
RUN R -e "remotes::install_github('rstudio/renv')"
RUN R -e "options(repos=c(CRAN='https://demo.rstudiopm.com/all/__linux__/bionic/latest')); install.packages(c('rsconnect'));"


## Reticulate isn't showing up in renv for some reason.
RUN R -e "options(repos=c(CRAN='https://demo.rstudiopm.com/all/__linux__/bionic/latest')); install.packages(c('reticulate'));"

RUN apt-get update && apt-get install -yq libssl-dev libpng-dev libnetcdf-dev libxml2-dev

# Expected to be mounted in
WORKDIR /primers
CMD R -f "utils/updateManifests.R"


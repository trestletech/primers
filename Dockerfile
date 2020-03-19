ARG R_VERSION=3.6.2
FROM rstudio/r-base:${R_VERSION}-bionic

RUN R -e "options(repos=c(CRAN='https://demo.rstudiopm.com/all/__linux__/bionic/latest')); install.packages(c('remotes', 'rsconnect')); remotes::install_github('rstudio/connectapi'); remotes::install_github('rstudio/renv'); remotes::install_github('rstudio/connectapi')"

## Reticulate isn't showing up in renv for some reason.
RUN R -e "options(repos=c(CRAN='https://demo.rstudiopm.com/all/__linux__/bionic/latest')); install.packages(c('reticulate'));"

RUN apt-get update && apt-get install -yq libssl-dev libpng-dev libnetcdf-dev libxml2-dev

# Expected to be mounted in
WORKDIR /primers
CMD R -f "utils/updateManifests.R"

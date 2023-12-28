FROM rocker/r2u:22.04

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libglpk-dev \
    libxt-dev

RUN R -e "install.packages(c('dplyr', 'purrr', 'curl', 'readr', 'stringr', 'ggplot2', 'janitor', 'targets'))"

RUN mkdir /output

COPY _targets.R /_targets.R

COPY functions.R /functions.R

CMD R -e "targets::tar_make()"

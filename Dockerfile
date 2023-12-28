FROM rocker/r-ver:4.2.1

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libglpk-dev \
    libxt-dev

RUN R -e "install.packages(c('dplyr', 'purrr', 'readr', 'stringr', 'ggplot2', 'janitor', 'targets'))"

RUN mkdir /home/fig

COPY _targets.R /_targets.R

COPY functions.R /functions.R

CMD R -e "targets::tar_make()"

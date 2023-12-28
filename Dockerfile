FROM rocker/r2u:22.04

RUN R -e "install.packages(c('dplyr', 'purrr', 'curl', 'readr', 'stringr', 'ggplot2', 'janitor', 'targets'))"

RUN mkdir /output

COPY _targets.R functions.R /

CMD R -e "sessionInfo(); targets::tar_make();"

FROM rocker/r-ver:4.3

WORKDIR /workspace

RUN R -e "install.packages('pak');pak::pak(c('dplyr', 'purrr', 'curl', 'readr', 'stringr', 'ggplot2', 'janitor', 'targets'))"

COPY _targets.R functions.R /workspace

CMD R -e "sessionInfo(); \
list.files(); \
targets::tar_make();"
FROM rocker/r2u:22.04

WORKDIR /workspace

RUN R -e "install.packages(c('dplyr', 'purrr', 'curl', 'readr', 'stringr', 'ggplot2', 'janitor', 'targets', 'renv'))"

COPY _targets.R functions.R /workspace

CMD R -e "sessionInfo(); \
list.files(); \
# options(renv.config.dependencies.limit = Inf);  \
renv::snapshot(lockfile = 'output/renv.lock'); \
targets::tar_make();"
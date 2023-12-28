FROM rocker/r2u:22.04

RUN R -e "\ 
    remotes::install_version('curl', version = '5.2.0') \
    remotes::install_version('dplyr', version = '1.1.4') \
    remotes::install_version('purrr', version = '1.0.2') \
    remotes::install_version('readr', version = '2.1.4') \
    remotes::install_version('stringr', version = '1.5.1') \
    remotes::install_version('ggplot2', version = '3.4.4') \
    remotes::install_version('janitor', version = '2.2.0') \
    remotes::install_version('targets', version = '1.4.0') \
"

RUN mkdir /output

COPY _targets.R /_targets.R

COPY functions.R /functions.R

CMD R -e "targets::tar_make()"

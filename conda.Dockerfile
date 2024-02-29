FROM python:3.12-slim-bookworm

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/* \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && conda install r-base r-dplyr r-purrr r-purrr r-readr r-stringr r-ggplot2 r-janitor r-targets r-curl -y --quiet --channel=conda-forge

WORKDIR /workspace
COPY _targets.R functions.R

CMD R -e "sessionInfo(); \
list.files(); \
targets::tar_make();"
FROM python:3.12-slim-bookworm

RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && PATH="/root/miniconda/bin:$PATH" \
    && conda install r-base r-dplyr r-purrr r-readr r-stringr r-ggplot2 r-janitor r-targets r-curl -y --quiet --channel=conda-forge \
    && conda config --set auto_activate_base true

WORKDIR /workspace
COPY _targets.R functions.R /workspace/

CMD bash -c "R -e 'sessionInfo(); list.files(); targets::tar_make();'"

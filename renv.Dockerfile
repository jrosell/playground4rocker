FROM rocker/r2u:22.04

WORKDIR /workspace

RUN R -e "install.packages(c('renv'))"
COPY renv.lock renv.lock
RUN mkdir -p renv

RUN echo 'source("renv/activate.R")' >> .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
RUN mkdir renv/cache
ENV RENV_PATHS_CACHE renv/cache
RUN R -e "renv::restore()"

COPY _targets.R functions.R /workspace/

CMD R -e "sessionInfo(); \
list.files(); \
# options(renv.config.dependencies.limit = Inf);  \
renv::snapshot(lockfile = 'output/renv.lock'); \
targets::tar_make();"
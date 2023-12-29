# playground4rocker

Here I'm interested in the github actions and docker deployment workflows. So, for the functions.R and _targets.R files, I used and updated the code from https://www.brodrigues.co/blog/2022-11-19-raps/ by @b-rodrigues An example can also be seen here https://github.com/b-rodrigues/dockerized_pipeline_demo

## Github Actions

With [.github/workflows/last.yml](.github/workflows/last.yml) last R package versions are used. ETA 1 min (faster but unsafer).

With [.github/workflows/renv.yml](.github/workflows/renv.yml) locked R packave versions are used. ETA 16 min (slower but more reproducible).

The output files will be uploaded as an artifact zip of the executed jobs.

## Run in local Docker container

First clone the repository in your computer:

```         
$ git clone git@github.com:jrosell/playground4rocker.git

$ cd playground4rocker
```

Then build the image and run the container.

-   Last R package versions in a local computer (faster but unsafer):

```         
$ docker build -t my-image-name . && docker run --rm -u $(id -u):$(id -g) --name my_pipeline_container -v $(pwd)/output:/workspace/output/:rw my-image-name
```

-   Run specific R package versions in a local computer (slower but reproducible):

```         
$ docker build -f renv.Dockerfile -t my-renv-name . && docker run --rm -u $(id -u):$(id -g) --name my_renv_container -v $(pwd)/output:/workspace/output/:rw my-renv-name
```

It will use the renv.lock in your root folder.

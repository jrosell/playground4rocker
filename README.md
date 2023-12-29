# playground

## Run last R package versions in Github Actions (faster but unsafer)

Look the [.github/workflows/main.yml](.github/workflows/main.yml) file.

The output files will be uploaded as an artifact zip of the executed job.


## Run last R package versions in a local computer (faster but unsafer)

```         
$ git clone https://github.com/jrosell/playground

$ cd playground

$ docker build -t my-image-name . && docker run --rm -u $(id -u):$(id -g) --name my_pipeline_container -v $(pwd)/output:/workspace/output/:rw my-image-name
```


## Run specific R package versions in a local computer (slower but reproducible)

Add renv.lock in your root folder and run:

```     
$ docker build -f renv.Dockerfile -t my-renv-name . && docker run --rm -u $(id -u):$(id -g) --name my_renv_container -v $(pwd)/output:/workspace/output/:rw my-renv-name
```     


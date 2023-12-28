# playground

## Run in a local computer

```         
$ git clone https://github.com/jrosell/playground

$ cd playground

$ docker build -t my-image-name . && docker run --rm --name my_pipeline_container -v $(pwd)/output:/output/:rw my-image-name
```

## Run in Github Actions

Look the [.github/workflows/main.yml](.github/workflows/main.yml) file.

The output will be uploaded as artifact of the github action job.

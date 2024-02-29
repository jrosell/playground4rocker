# playground4rocker

In this repo there are multiple github actions and docker deployment workflows available. 

I tested to run [R code](https://www.brodrigues.co/blog/2022-11-19-raps/) using different approaches. The output files are uploaded as an artifact zip of the executed jobs.

## Github Actions

Results:

* With [.github/workflows/r2u.yml](.github/workflows/r2u.yml), last R package versions with r2u are used. ETA 49s.

* With [.github/workflows/pak.yml](.github/workflows/pak.yml), last R package versions with pak are used. ETA 1m 18s.

* With [.github/workflows/conda.yml](.github/workflows/conda.yml), last R package versions with conda are used. ETA 1m 25s.

* With [.github/workflows/renv.yml](.github/workflows/renv.yml), locked R package versions with renv are used. ETA 12m 24s (slower but more reproducible).

Conclusions:

* When using Ubuntu, r2u is the fastest approach to run the code with the last R package versions. 
* When not using Ubuntu, pak or conda approaches can be used to run the code with the last R package versions. 
* When requiring specific versions, renv approach can be used. It will be slower but more reproducible.


## How to build images and run containers locally

First clone the repository in your computer:

```         
$ git clone git@github.com:jrosell/playground4rocker.git

$ cd playground4rocker
```

Then run the R code with the fastest approach this way:

```         
$ docker build -f r2u.Dockerfile -t my-r2u-name . \
  && docker run --name my_r2u_container --rm  -v $(pwd)/output:/workspace/output/:rw  my-r2u-name
```

Alternatively, you can run R code with the more reproducible but slow approach this way:

```         
$ docker build -f renv.Dockerfile -t my-renv-name .  \
  && docker run --name my_renv_container --rm -v $(pwd)/output:/workspace/output/:rw my-renv-name
```

If you have added Python code and need to run both R and Python code, you can use this version:

```  
$ docker build -f conda.Dockerfile -t my-conda-name . \
  && docker run --name my_conda_container --rm -v $(pwd)/output:/workspace/output/:rw my-conda-name
```  

## Follow up

Feedback is welcome:

* Suggestions? Bugs? You can open an issue.
* You can fork this repo an reuse it. I'm open to PR too.
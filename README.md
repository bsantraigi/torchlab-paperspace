# {PyTorch 1.0.0dev & friends} + CUDA 9.2 + cuDNN 7.1.4
## Purpose
Get a Jupyterlab up and running in seconds for interactive exploration (hence the data wrangling and visualization packages).

## Included packages
Included packages (see `Dockerfile` for the full list):
  - miniconda3 w/ python 3.6
  - PyTorch 1.0.0dev-20181009
  - torchvision, torchsummary, tensorboardX
  - pandas, scipy
  - scikit-learn, scikit-image
  - xgboost,
  - jupyterlab
  - tf 1.11, tensorboard
  - ...

## Usage
If you do not have `nvidia-docker` installed:

    docker run --rm \
        $(ls /dev/nvidia* | xargs -I{} echo '--device={}') \
        $(ls /usr/lib/x86_64-linux-gnu/{libcuda,libnvidia}* | xargs -I{} echo '-v {}:{}:ro') \
        -e CUDA_VISIBLE_DEVICES=0 \
        -v code:/code
        bosr/pytorch

or using `nvidia-docker`

    nvidia-docker run --rm \
        -v ${PWD}/code:/code \
        -p 8888:8888 \
        bosr/pytorch
            /usr/local/bin/jupyter lab --no-browser --ip 0.0.0.0 --allow-root

Note: on debian, installing `nvidia-docker` is currently painful, so what I recommend is defining an executable script in `/usr/local/bin/nvidia-docker`:

    #! /usr/bin/env bash

    /usr/bin/docker $1 \
        $(ls /dev/nvidia* | xargs -I{} echo '--device={}') \
        $(ls /usr/lib/x86_64-linux-gnu/{libcuda,libnvidia}* | xargs -I{} echo '-v {}:{}:ro') \
        -e CUDA_VISIBLE_DEVICES=0 \
        ${@:2}

and run it as shown above.

## Details
Miniconda3 is installed in `/usr/local/miniconda`. When the container is started, a Jupyterlab is launched and exposed on the standard port 8888.

As a personal preference, I save the model coefficients and dump the logs in `/output`.

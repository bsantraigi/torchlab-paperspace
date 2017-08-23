# Dockerized Pytorch 0.2.0 (personal use)
version 0.2.0.post1

To run it:

    docker run -it --rm $(ls /dev/nvidia* | xargs -I{} echo '--device={}') $(ls /usr/lib/x86_64-linux-gnu/{libcuda,libnvidia}* | xargs -I{} echo '-v {}:{}:ro') -e CUDA_VISIBLE_DEVICES=0 bosr/pytorch

# FROM ubuntu:18.04
FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

# Based on "https://github.com/bosr/docker-pytorch"
LABEL maintainer="bsantraigi"
LABEL description="🐳 Docker environment for Paperspace GPU Accelerated Machine Learning"
LABEL url="https://github.com/bsantraigi/torchlab-paperspace"

RUN apt-get update -qq \
  && apt-get install -y apt-utils \
  && apt-get upgrade -y \
  #
  # python
  # && apt-get install -y python3-pip python3-tk \
  && apt-get install -y sudo curl git \
      build-essential \
      clang libpython-dev libblocksruntime-dev \
      libpython3.6 libxml2 \
  #
  # cleanup
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8 \
    SHELL=/bin/bash \
    NB_USER=bishal \
    NB_UID=1000 \
    NB_GID=100 \
    HOME=/home/$NB_USER

# latest stable: https://storage.googleapis.com/swift-tensorflow-artifacts/releases/v0.7/rc2/swift-tensorflow-RELEASE-0.7-cuda10.1-cudnn7-ubuntu18.04.tar.gz
# nightly: https://storage.googleapis.com/swift-tensorflow-artifacts/releases/v0.9/rc1/swift-tensorflow-RELEASE-0.9-cuda10.1-cudnn7-ubuntu18.04.tar.gz

ADD fix-permissions /usr/bin/fix-permissions

RUN \
  #
  # create user
  groupadd $NB_USER && useradd -d $HOME -ms /bin/bash -g $NB_GID -G sudo,video -p $NB_USER $NB_USER \
  && chmod g+w /etc/passwd /etc/group \
  && chown -R $NB_USER:$NB_USER /usr/local

WORKDIR $HOME

COPY install-python-packages.sh .

# Miniconda
RUN \
  curl -L https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
  # curl -L https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh -o miniconda.sh \
  && bash miniconda.sh -b -p /usr/local/miniconda \
  && rm -f miniconda.sh \
  && echo 'export PATH="/usr/local/miniconda/bin:$PATH"' >> $HOME/.bashrc \
  && /bin/bash -c "\
  export PATH='/usr/local/miniconda/bin:$PATH' \
  && echo 'installing for $NB_USER ($NB_GID) $HOME' \
  #
  && conda update -n base conda \
  #
  #
  && source install-python-packages.sh \
  #
  #
  && echo '** cleaning caches...' \
  && conda clean --all -y \
  && rm -rf $HOME/.cache/pip \
  && echo '** cleaning caches done.' \
  #
  && rm -f install-python-packages.sh \
  #
  && chown -R $NB_USER:$NB_USER $HOME \
  && chown -R $NB_USER:$NB_USER /usr/local/miniconda \
  "

USER $NB_USER

RUN /usr/local/miniconda/conda init

WORKDIR /storage

EXPOSE 8888

# jupyter lab --ip 0.0.0.0 --no-browser --allow-root
CMD ["/usr/local/miniconda/bin/jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]

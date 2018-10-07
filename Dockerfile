FROM debian:jessie
MAINTAINER bosr <romain.bossart@fastmail.com>

RUN apt update -qq \
  && apt install -y apt-utils \
  && apt upgrade -y \
  #
  && apt install -y curl \
  # nodejs for jupyterlab
  && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt install -y nodejs \
  #
  # python
  # && apt install -y python3-pip python3-tk \
  && apt install -y build-essential   # gcc for xgboost \
  #
  # cleanup
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

# Miniconda
RUN \
  curl -L https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
  && bash miniconda.sh -b -p /usr/local/miniconda \
  && rm -f miniconda.sh \
  && echo 'export PATH="/usr/local/miniconda/bin:$PATH"' >> ~/.bashrc \
  && /bin/bash -c "\
  source ~/.bashrc \
  #
  # should be dropped when conda-forge packages are avail on 3.7
  && conda create -n myenv python=3.6 -y \
  && echo 'source activate myenv' >> ~/.bashrc \
  && source activate myenv \
  #
  #
  && conda install -y \
    cython numpy scipy \
    pandas \
    scikit-learn scikit-image \
    nltk \
    tensorflow-gpu tensorboard \
    #
    jupyterlab ipywidgets \
    tqdm \
    #
    matplotlib seaborn \
    #
  && python -c \"import nltk; nltk.download('stopwords')\" \
  && conda install -y -c conda-forge \
    #
    hyperopt \
    plotnine \
    # py36 only
    xgboost \
    tpot \
    #
    #
    # torch
  && conda install -y -c pytorch \
    pytorch-nightly cuda92 torchvision \
  #
  && pip install plydata tensorboardX \
  #
  #
  && jupyter serverextension enable --py jupyterlab --sys-prefix \
  && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
  && jupyter labextension install @jupyter-widgets/jupyterlab-manager \
  #
  && conda clean --all -y \
  "


EXPOSE 8888 6006

CMD ["/usr/local/miniconda/envs/myenv/bin/jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

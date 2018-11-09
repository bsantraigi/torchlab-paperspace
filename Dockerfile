FROM debian:stretch
MAINTAINER bosr <romain.bossart@fastmail.com>

RUN apt-get update -qq \
  && apt-get install -y apt-utils \
  && apt-get upgrade -y \
  #
  # python
  # && apt-get install -y python3-pip python3-tk \
  && apt-get install -y curl \
      build-essential   # gcc for xgboost \
  #
  # cleanup
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


COPY install-python-packages.sh .


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
  && source install-python-packages.sh \
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

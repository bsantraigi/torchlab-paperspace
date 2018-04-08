FROM gw000/debian-cuda
MAINTAINER bosr <romain.bossart@fastmail.com>

RUN apt-get update -qq \
  && apt-get upgrade -y \
  #
  # nodejs
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get install -y nodejs \
  #
  # python
  && apt-get install -y python3-pip python3-tk \
  && apt-get install -y build-essential   # gcc for xgboost \
  #
  # cleanup
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN /usr/bin/pip3 install \
      #
      # pytorch
      http://download.pytorch.org/whl/cu91/torch-0.3.1-cp35-cp35m-linux_x86_64.whl \
      torchvision \
      #
      # scikit & classics
      scikit-learn xgboost \
      hyperopt tpot \
      #
      # graphics
      matplotlib seaborn\
      plotnine plydata \
      #
      # interactivity
      notebook yapf \
      jupyterlab \
      tqdm ipywidgets \
  #
  # nltk
  && /usr/bin/pip3 install nltk \
  && /usr/bin/python3 -c "import nltk; nltk.download('stopwords')"

RUN \
  /usr/local/bin/jupyter serverextension enable --py jupyterlab --sys-prefix \
  && /usr/local/bin/jupyter nbextension enable --py widgetsnbextension --sys-prefix \
  && /usr/local/bin/jupyter labextension install @jupyter-widgets/jupyterlab-manager

EXPOSE 8888

CMD ["/usr/local/bin/jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

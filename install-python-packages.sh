#!/usr/bin/env bash
set -euxo pipefail


conda install -y \
	cython numpy scipy \
	pandas \
	scikit-learn scikit-image \
	nltk \
	tensorflow-gpu tensorboard \
	\
	jupyterlab ipywidgets \
	tqdm \
	\
	matplotlib seaborn \


python -c "import nltk; nltk.download('stopwords')"


# xgboost & tpot currently require py36
conda install -y -c conda-forge \
	nodejs \
	\
	tensorboardx \
	hyperopt \
	\
	xgboost \
	tpot \


# torch
conda install -y -c pytorch \
	pytorch-nightly cuda92 \
	torchvision ignite \


#
pip install plydata \
	torchsummary torchtext \
	sacred

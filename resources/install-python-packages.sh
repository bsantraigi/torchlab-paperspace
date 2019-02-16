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
	\
	matplotlib seaborn \


python -c "import nltk; nltk.download('stopwords')"


# xgboost & tpot currently require py36
conda install -y -c conda-forge \
	nodejs \
	jupyter_contrib_nbextensions \
	nbdime \
	\
	tensorboardx \
	hyperopt \
	\
	xgboost \
	tpot \


# torch
conda install -y -c pytorch \
	torchvision ignite \

# fastai
conda install -y -c fastai \
	fastai

#
pip install plydata \
	torchsummary torchtext \
	sacred \
	\
	tqdm \
	\
	python-language-server \
	ptpython

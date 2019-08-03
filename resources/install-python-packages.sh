#!/usr/bin/env bash
set -euo pipefail

conda install -y \
	cython numpy scipy \
	pandas \
	scikit-learn scikit-image \
	nltk \
	\
	jupyterlab ipywidgets \
	\
	matplotlib seaborn \


python -c "import nltk; nltk.download('stopwords')"

# torch
conda install -y -c pytorch \
	pytorch==1.1.0 torchvision ignite \


# xgboost & tpot currently require py36
conda install -y -c conda-forge \
	nodejs \
	jupyter_contrib_nbextensions \
	nbdime \
	\
	tensorboard tensorboardx \
	hyperopt \
	\
	# xgboost \
	# tpot \


# fastai
# conda install -y -c fastai \
# 	fastai

#
pip install plydata \
	torchtext \
	\
	tqdm \
	\
	python-language-server \
	ptpython

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
	pytorch==1.2.0 ignite \
	torchvision torchtext torchaudio \
	# botorch

pip install gpytorch
conda install -y botorch -c pytorch


# xgboost & tpot currently require py36
conda install -y -c conda-forge \
	nodejs \
	jupyter_contrib_nbextensions \
	nbdime \
	\
	tensorboard \
	hyperopt \
	\
	# xgboost \
	# tpot \


# fastai
# conda install -y -c fastai \
# 	fastai

#
pip install \
	pytorch-transformers \
	pyro-ppl allennlp flair \
	# torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
	fairseq \
	syft

#
pip install plydata \
	tqdm \
	\
	python-language-server \
	ptpython \

git clone https://github.com/facebookresearch/ParlAI.git ~/ParlAI \
	&& cd ~/ParlAI && python setup.py develop \
	&& cd ~/

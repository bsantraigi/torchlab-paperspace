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

conda install -y -c pytorch -c gpytorch botorch
pip install ax-platform

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

jupyter serverextension enable --py jupyterlab --sys-prefix \
  && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
  && jupyter contrib nbextension install --user \
  && jupyter labextension install @jupyter-widgets/jupyterlab-manager \
  && jupyter labextension install @oriolmirosa/jupyterlab_materialdarker \

conda install -y -c conda-forge black
jupyter labextension install @ryantam626/jupyterlab_code_formatter
conda install -y -c conda-forge jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter

# fastai
# conda install -y -c fastai \
# 	fastai

#
pip install \
	pytorch-transformers \
	pyro-ppl allennlp flair \
	fairseq \
	syft \
	# torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \

pip install \
	test_tube \

pip install plydata \
	tqdm \
	\
	python-language-server \
	ptpython \
	faker babel

git clone https://github.com/facebookresearch/ParlAI.git ${HOME}/ParlAI \
	&& cd ${HOME}/ParlAI && python setup.py develop \
	&& cd ${HOME}

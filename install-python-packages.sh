#!/usr/bin/env bash
set -euo pipefail

conda install -y cython numpy pandas scikit-learn nltk matplotlib


python -c "import nltk; nltk.download('stopwords')"

# latest torch
conda install -y -c pytorch pytorch cudatoolkit=10.1 torchvision

# conda install -y -c pytorch -c gpytorch botorch
# pip install ax-platform

conda install -c conda-forge jupyterlab ipywidgets

jupyter serverextension enable --py jupyterlab --sys-prefix \
  && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
  && jupyter contrib nbextension install --sys-prefix \
  && jupyter labextension install @jupyter-widgets/jupyterlab-manager \
  && jupyter labextension install @oriolmirosa/jupyterlab_materialdarker \
  && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
  && jupyter labextension install @aquirdturtle/collapsible_headings

jupyter labextension install @jupyterlab/toc

# conda install -y -c conda-forge jupyterlab_code_formatter
pip install jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter --sys-prefix

# git clone https://github.com/fastai/swiftai

# fastai
conda install -y -c fastai fastai

#
pip install transformers mosestokenizer sacremoses blingfire
# 	spacy \
# 	pyro-ppl \
# 	allennlp flair \
# 	fairseq \
	# syft \
	# torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \

pip install plydata tqdm
# 	python-language-server \
# 	ptpython \
# 	faker babel

# git clone https://github.com/facebookresearch/ParlAI.git ${HOME}/ParlAI \
# 	&& cd ${HOME}/ParlAI && python setup.py develop \
# 	&& cd ${HOME}

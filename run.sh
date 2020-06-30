#!/bin/bash
whoami
/usr/local/miniconda/bin/conda init
source ~/.bashrc
/usr/local/miniconda/bin/conda activate base
which python
which jupyter
which conda
jupyter lab --ip=0.0.0.0 --no-browser --allow-root
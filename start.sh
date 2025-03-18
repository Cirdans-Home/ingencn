#!/bin/sh
export PATH=~/anaconda3/bin:$PATH
if [ ! -d jupyterbook ]; then 
  python3 -m pip install --user virtualenv
  python3 -m venv jupyterbook
  source jupyterbook/bin/activate
  python3 -m pip install -r requirements.txt
else
  echo "jupyterbook directory already exists. Sourcing the virtual environment."
  source jupyterbook/bin/activate
fi

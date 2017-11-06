#!/bin/bash

# ipyrad software installation
# adapted from this tutorial: http://ipyrad.readthedocs.io/tutorial_intro_cli.html
# optimized for running on BioLinux 8 cloud instance through Jetstream
# instance details here: https://use.jetstream-cloud.org/application/images/55

# download script to install miniconda
# wget is a command to download files from an online URL (works on Mac, Linux, GitBash)
# curl is an alternative command used in the tutorial
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh

# install miniconda. You will be prompted to answer a few questions:
# press ENTER to review the license agreement, then q to exit the agreement screen
# type yes followed by ENTER to accept the license terms
# press ENTER to confirm installation to the home directory, e.g., `/home/user/miniconda2`
# type yes then ENTER "to prepend the Miniconda2 install location to PATH"
bash Miniconda2-latest-Linux-x86_64.sh

# reload your profile to include miniconda in your path
source ~/.bashrc

## test that conda is installed. This will print info about your conda install.
conda info

# install latest release of ipyrad
conda install -c ipyrad ipyrad     

# manually load jupyter (a dependency of ipyrad)
pip install jupyter

# test install
ipyrad -v

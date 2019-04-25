#!/usr/bin/env bash
# The purpose here is to install automation technology of choice and then handover rest over to it

set -o errexit

echo "Install PiP3 ...."
apt --yes install python3-pip

echo "Set Pyrhon3 as default ...."
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

echo "Install required ansible version ...."
# https://stackoverflow.com/questions/49918859/import-error-module-object-has-no-attribute-check-specifier-error
# pip install -I setuptools
pip install ansible==2.7.10

echo "Cleanup packages ...."
apt --yes autoremove


#!/bin/bash

set -o xtrace

# Install basic packages for this script.
apt-get -y install git software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# GIT clone our playbook to CWD.
git clone https://github.com/pantarei/ansible-playbook-bitbucket.git ansible-playbook-bitbucket
cd ansible-playbook-bitbucket
git checkout master

# Bootstrap Ansible then run all playbooks.
scripts/bootstrap-ansible.sh
scripts/run-playbooks.sh

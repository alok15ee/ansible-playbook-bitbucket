#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/bitbucket playbooks/setup-everything.yml

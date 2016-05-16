#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/bitbucket.aio playbooks/setup-everything.yml

#!/bin/bash

set -o xtrace

rm -rf host_vars/bitbucket.aio
rm -rf inventory/bitbucket.aio

scripts/bootstrap-inventory.sh
scripts/bootstrap-bitbucket.sh

cat host_vars/bitbucket.aio | egrep -v -e '^^#\w' | perl -p -e "s/^(apt_upgrade):.*/\1: \"no\"/g" > tests/group_vars/all
cat inventory/bitbucket.aio | perl -p -e "s/^.*127.0.0.1/localhost.localdomain\tansible_connection=local/g" > tests/hosts

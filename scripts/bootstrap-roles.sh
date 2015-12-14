#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Fetch all roles with latest version.
rm -rf roles
mkdir -p roles
git submodule init
cat .roles.yml | grep src | while read line;
do
    role=`echo $line | sed 's/^.*: \(.*\)\s*$/\1/g'`
    repo=`echo $line | sed 's/^.*: hswong3i.\(.*\)\s*$/\1/g;s/_/-/g;s/\(.*\)/https:\/\/github.com\/pantarei\/ansible-role-\1.git/g'`
    git submodule add --force -b master $repo roles/$role
done
git submodule update --remote

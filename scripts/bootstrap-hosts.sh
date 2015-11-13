#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Copy hosts files from template.
echo -e "# Updated on `date`" >> hosts
cat >> hosts <<-EOF
[bitbucket]
localhost   ansible_connection=local

[postgresql]
localhost   ansible_connection=local

#[mysql]
#localhost   ansible_connection=local

#[apache2_all]
#localhost   ansible_connection=local

EOF

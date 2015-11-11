#!/bin/bash

set -o xtrace

PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Fetch all roles with latest version.
rm -rf roles
ansible-galaxy install --force -r tests/roles.yml

# Generate the group_vars/all with all default role variables.
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g' > group_vars/all
sed -i "s/^#\(bitbucket_pass\):.*/\1: "$PASSWD"/g" group_vars/all
sed -i "s/^#\(postgresql_db_encoding\):.*/\1: UTF8/g" group_vars/all
sed -i "s/^#\(postgresql_db_name\):.*/\1: bitbucket/g" group_vars/all
sed -i "s/^#\(postgresql_db_owner\):.*/\1: bitbucket/g" group_vars/all
sed -i "s/^#\(postgresql_db_template\):.*/\1: template0/g" group_vars/all
sed -i "s/^#\(postgresql_user_name\):.*/\1: bitbucket/g" group_vars/all
sed -i "s/^#\(postgresql_user_password\):.*/\1: "$PASSWD"/g" group_vars/all

# Copy hosts files from template.
cat > hosts <<-EOF
[bitbucket]
localhost   ansible_connection=local

[postgresql]
localhost   ansible_connection=local
EOF

#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Generate a random password.
PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
SALT=`date | shasum -a 256 | sed 's/^\(\w*\).*$/\1/g'`

# Prepare group_vars/all.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_server_name):.*/\1: \"{{ bitbucket_proxy_name }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apt_cache_valid_time):.*/\1: 3600/g" $TMP_VARS
perl -i -p -e "s/^#(bitbucket_hash_salt):.*/\1: "$SALT"/g" $TMP_VARS
perl -i -p -e "s/^#(bitbucket_pass):.*/\1: "$PASSWD"/g" $TMP_VARS
perl -i -p -e "s/^#(bitbucket_proxy_name):.*/\1: bitbucket.example.com/g" $TMP_VARS
perl -i -p -e "s/^#(bitbucket_user):.*/\1: bitbucket/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_db_name):.*/\1: \"{{ bitbucket_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_user_name):.*/\1: \"{{ bitbucket_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_user_password):.*/\1: \"{{ bitbucket_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_db_name):.*/\1: \"{{ bitbucket_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_db_owner):.*/\1: \"{{ bitbucket_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_user_name):.*/\1: \"{{ bitbucket_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_user_password):.*/\1: \"{{ bitbucket_pass }}\"/g" $TMP_VARS
cat $TMP_VARS >> group_vars/all

# Prepare group_vars/mysql.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | egrep -e '^(apt|ufw|mysql).*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(mysql_db_collation):.*/#\1: utf8_bin/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_db_encoding):.*/#\1: utf8/g" $TMP_VARS
perl -i -p -e "s/^#(ufw_to_port):.*/\1: [\n  { to_port: '22', proto: 'tcp', rule: 'allow' },\n  { to_port: '3306', proto: 'tcp', rule: 'allow' },\n  { to_port: '1024:65535', proto: 'tcp', rule: 'allow' },\n]/g" $TMP_VARS
cat $TMP_VARS >> group_vars/mysql

# Prepare group_vars/postgresql.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | egrep -e '^(apt|ufw|postgresql).*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(postgresql_db_encoding):.*/\1: UTF8/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_db_template):.*/\1: template0/g" $TMP_VARS
perl -i -p -e "s/^#(ufw_to_port):.*/\1: [\n  { to_port: '22', proto: 'tcp', rule: 'allow' },\n  { to_port: '5432', proto: 'tcp', rule: 'allow' },\n  { to_port: '1024:65535', proto: 'tcp', rule: 'allow' },\n]/g" $TMP_VARS
cat $TMP_VARS >> group_vars/postgresql

# Prepare group_vars/bitbucket.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | egrep -e '^(apt|ufw|bitbucket|mysql_connector_java).*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(mysql_connector_java_dest):.*/\1: \/usr\/share\/bitbucket\/lib/g" $TMP_VARS
perl -i -p -e "s/^#(ufw_to_port):.*/\1: [\n  { to_port: '22', proto: 'tcp', rule: 'allow' },\n  { to_port: '8006', proto: 'tcp', rule: 'allow' },\n  { to_port: '7990', proto: 'tcp', rule: 'allow' },\n  { to_port: '1024:65535', proto: 'tcp', rule: 'allow' },\n]/g" $TMP_VARS
cat $TMP_VARS >> group_vars/bitbucket

# Prepare group_vars/apache2.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | egrep -e '^(apt|ufw|apache2).*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_document_root):.*/\1: ~/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_pass):.*/#\1: \/   http:\/\/localhost:7990\//g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_pass_reverse):.*/#\1: \/   http:\/\/localhost:7990\//g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_preserve_host):.*/\1: 'Off'/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_request):.*/\1: 'On'/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_via):.*/\1: 'On'/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_server_alias):.*/\1: []/g" $TMP_VARS
perl -i -p -e "s/^#(ufw_to_port):.*/\1: [\n  { to_port: '22', proto: 'tcp', rule: 'allow' },\n  { to_port: '80', proto: 'tcp', rule: 'allow' },\n  { to_port: '443', proto: 'tcp', rule: 'allow' },\n  { to_port: '1024:65535', proto: 'tcp', rule: 'allow' },\n]/g" $TMP_VARS
cat $TMP_VARS >> group_vars/apache2

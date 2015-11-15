#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Generate the group_vars/all with all default role variables.
PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
TMP_VARS=`mktemp`

echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS

sed -i "s/^#\(apache2_proxy_pass\):.*/#\1: \/   http:\/\/localhost:7990\//g" $TMP_VARS
sed -i "s/^#\(apache2_proxy_pass_reverse\):.*/#\1: \/   http:\/\/localhost:7990\//g" $TMP_VARS
sed -i "s/^#\(apache2_proxy_scheme\):.*/#\1: https/g" $TMP_VARS
sed -i "s/^#\(apache2_proxy_server_name\):.*/#\1: bitbucket.example.com/g" $TMP_VARS
sed -i "s/^#\(apt_cache_valid_time\):.*/\1: 0/g" $TMP_VARS
sed -i "s/^#\(bitbucket_pass\):.*/\1: "$PASSWD"/g" $TMP_VARS
sed -i "s/^#\(bitbucket_proxy_name\):.*/#\1: bitbucket.example.com/g" $TMP_VARS
sed -i "s/^#\(bitbucket_scheme\):.*/#\1: https/g" $TMP_VARS
sed -i "s/^#\(mysql_connector_java_dest\):.*/\1: \/usr\/share\/bitbucket\/lib/g" $TMP_VARS
sed -i "s/^#\(mysql_db_collation\):.*/#\1: utf8_bin/g" $TMP_VARS
sed -i "s/^#\(mysql_db_encoding\):.*/#\1: utf8/g" $TMP_VARS
sed -i "s/^#\(mysql_db_name\):.*/#\1: bitbucket/g" $TMP_VARS
sed -i "s/^#\(mysql_user_name\):.*/#\1: bitbucket/g" $TMP_VARS
sed -i "s/^#\(mysql_user_password\):.*/#\1: "$PASSWD"/g" $TMP_VARS
sed -i "s/^#\(postgresql_db_encoding\):.*/\1: UTF8/g" $TMP_VARS
sed -i "s/^#\(postgresql_db_name\):.*/\1: bitbucket/g" $TMP_VARS
sed -i "s/^#\(postgresql_db_owner\):.*/\1: bitbucket/g" $TMP_VARS
sed -i "s/^#\(postgresql_db_template\):.*/\1: template0/g" $TMP_VARS
sed -i "s/^#\(postgresql_user_name\):.*/\1: bitbucket/g" $TMP_VARS
sed -i "s/^#\(postgresql_user_password\):.*/\1: "$PASSWD"/g" $TMP_VARS

cat $TMP_VARS >> group_vars/all

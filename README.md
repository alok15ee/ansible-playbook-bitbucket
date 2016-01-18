Ansible Playbook for BitBucket
==============================

[![Build Status](https://travis-ci.org/pantarei/ansible-playbook-bitbucket.svg?branch=master)](https://travis-ci.org/pantarei/ansible-playbook-bitbucket)
[![GitHub tag](https://img.shields.io/github/tag/pantarei/ansible-playbook-bitbucket.svg)](https://github.com/pantarei/ansible-playbook-bitbucket)
[![GitHub license](https://img.shields.io/github/license/pantarei/ansible-playbook-bitbucket.svg)](https://github.com/pantarei/ansible-playbook-bitbucket)

Ansible Playbook for Atlassian BitBucket Installation.

Requirements
------------

This playbook require Ansible 2.0 or higher.

This playbook was designed for Ubuntu Server 14.04 LTS.

Quick Start
-----------

All-in-one (AIO) builds are a great way to perform an BitBucket build
for

-   A development environment
-   An overview of how all of the BitBucket services fit together
-   A simple lab deployment

Although AIO builds aren’t recommended for large production deployments,
they’re great for smaller proof-of-concept deployments.

AIO in One Step
---------------

For a one-step build, there is a [convenient
script](https://raw.githubusercontent.com/pantarei/ansible-playbook-bitbucket/master/scripts/run-aio-build.sh)
within the ansible-playbook-bitbucket repository that will run a AIO
build with defaults:

    bash <(curl -sL https://raw.githubusercontent.com/pantarei/ansible-playbook-bitbucket/master/scripts/run-aio-build.sh)

It’s advised to run this build within a terminal muxer, like tmux or
screen, so that you don’t lose your progress if you’re disconnected from
your terminal session.

AIO with Customization
----------------------

There are four main steps for running a customized AIO build:

-   Install Ansible
-   Initial roles, vars and hosts bootstrap
-   Configuration *(this step is optional)*
-   Run playbooks

Start by cloning the ansible-playbook-bitbucket repository and changing
into the repository root directory:

    $ git clone --recursive https://github.com/pantarei/ansible-playbook-bitbucket.git \
        /opt/ansible-playbook-bitbucket
    $ cd /opt/ansible-playbook-bitbucket

Next bootstrap Ansible by executing:

    $ scripts/bootstrap-ansible.sh

Now we can bootstrap Ansible's roles, vars and hosts by executing:

    $ scripts/bootstrap-roles.sh
    $ scripts/bootstrap-vars.sh
    $ scripts/bootstrap-hosts.sh

By default the scripts deploy only BitBucket and PostgreSQL. At this
point you may optionally adjuct which services are deployed within your
AIO build. Look at the `group_vars/all` and `hosts` for more details.
For example, if you'd like to upgrade your Ubuntu set the
`apt_upgrade` as `full` at `group_vars/all`:

    apt_upgrade: full

Finally, run the plabooks by executing:

    $ ansible-playbook -i inventory/localhost playbooks/run-aio-build.yml

Dependencies
------------

-   [hswong3i.apache2](https://github.com/pantarei/ansible-role-apache2)
-   [hswong3i.apache2\_vhosts](https://github.com/pantarei/ansible-role-apache2-vhosts)
-   [hswong3i.apt](https://github.com/pantarei/ansible-role-apt)
-   [hswong3i.java](https://github.com/pantarei/ansible-role-java)
-   [hswong3i.mysql](https://github.com/pantarei/ansible-role-mysql)
-   [hswong3i.mysql\_connector\_java](https://github.com/pantarei/ansible-role-mysql-connector-java)
-   [hswong3i.mysql\_vhosts](https://github.com/pantarei/ansible-role-mysql-vhosts)
-   [hswong3i.postgresql](https://github.com/pantarei/ansible-role-postgresql)
-   [hswong3i.postgresql\_vhosts](https://github.com/pantarei/ansible-role-postgresql-vhosts)
-   [hswong3i.ufw](https://github.com/pantarei/ansible-role-ufw)
-   [hswong3i.bitbucket](https://github.com/pantarei/ansible-role-bitbucket)

License
-------

-   Code released under [MIT](https://github.com/hswong3i/ansible-playbook-bitbucket/blob/master/LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <https://twitter.com/hswong3i>
    -   <https://github.com/hswong3i>


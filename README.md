BitBucket Ansible Playbook
==========================

[![Build
Status](https://travis-ci.org/pantarei/ansible-playbook-bitbucket.svg?branch=master)](https://travis-ci.org/pantarei/ansible-playbook-bitbucket)
[![GitHub
tag](https://img.shields.io/github/tag/pantarei/ansible-playbook-bitbucket.svg)](https://github.com/pantarei/ansible-playbook-bitbucket)
[![GitHub
license](https://img.shields.io/github/license/pantarei/ansible-playbook-bitbucket.svg)](https://github.com/pantarei/ansible-playbook-bitbucket)

Ansible Playbook for Atlassian BitBucket Installation.

Requirements
============

This playbook require Ansible 1.9 or higher.

This playbook was designed for Ubuntu Server 14.04 LTS.

Deployment
==========

This stack can be on a single node or multiple nodes. The inventory file
'hosts' defines the nodes in which the stack should be configured.

    [bitbucket]
    bitbucket.localdomain

    [postgresql]
    postresql.localdomain

    [apache2_all]
    apache2.localdomain

Install roles depedency with following command:

    ansible-galaxy install -r roles.yml

The stack can be deployed using the following command:

    ansible-playbook -i hosts playbooks/setup-bitbucket.yml

License
-------

-   Code released under
    [MIT](https://github.com/hswong3i/ansible-playbook-bitbucket/blob/master/LICENSE)
-   Docs released under [CC BY
    4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <https://twitter.com/hswong3i>
    -   <https://github.com/hswong3i>


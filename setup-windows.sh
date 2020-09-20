#!/bin/bash
set -e
ansible-playbook -i inventory.ini setup.yml $1
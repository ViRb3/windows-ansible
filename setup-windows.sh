#!/bin/bash
set -e
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

ansible-playbook -i inventory.ini setup.yml "$@"

#!/bin/bash

# vyos-build-ami.sh: ansible-playbook wrapper for vyos-build-ami project
# Copyright 2017 VyOS maintainers and contributors <maintainers@vyos.net>
# Portions copyright 2014 hydrajump <wave@hydrajump.com>
# Distributed under the terms of the MIT license

# Playbooks are located in 'playbooks/' directory by default and have an .yml
# extension.

# Check dependencies

which aws 2>&1 >/dev/null
if [ $? -ne 0 ]; then
    echo "awscli is not installed or is not in your $PATH"
    exit 1
fi

which ansible 2>&1 >/dev/null
if [ $? -ne 0 ]; then
    echo "ansible is not installed or is not in your $PATH"
    exit 1
fi

# Get arguments

if [ $# -lt 1 ]; then
    echo "Usage: $0 <ISO URL>"
    exit 1
fi

ISO_URL=$1

# Do the job

cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ANSIBLE_ARGS="-e iso=$ISO_URL --skip-tags verify"

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbooks/vyos-build-ami.yml -vvv -i hosts --private-key=playbooks/files/ssh-keys/vyos-build-ami.pem  $ANSIBLE_ARGS $2

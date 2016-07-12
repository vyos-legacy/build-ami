#!/bin/bash

# vyos-build-ami.sh: ansible-playbook wrapper for vyos-build-ami project
# Copyright 2014 hydrajump <wave@hydrajump.com>
# Portions copyright 2015, 2016, VyOS maintainers and contributors <maintainers@vyos.net>
# Homepage: https://github.com/vyos/vyos-build-ami

# Playbooks are located in 'playbooks/' directory by default and have an .yml
# extension.

cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ansible-playbook playbooks/vyos-build-ami.yml -i hosts --private-key=playbooks/files/ssh-keys/vyos-build-ami.pem $@

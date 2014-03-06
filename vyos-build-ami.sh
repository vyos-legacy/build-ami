#!/bin/bash

# vyos-build-ami.sh: ansible-playbook wrapper for vyos-build-ami project
# Copyright 2014 hydrajump <wave@hydrajump.com>
# Homepage: https://github.com/hydrajump/vyos-build-ami

# Playbooks are located in 'playbooks/' directory by default and have an .yml
# extension.

ansible-playbook playbooks/vyos-build-ami.yml -i hosts --private-key=playbooks/files/ssh-keys/vyos-build-ami.pem

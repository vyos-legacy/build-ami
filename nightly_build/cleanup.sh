#!/usr/bin/env bash

set -u
set -e

cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ -d env ]; then
    set +u
    source env/bin/activate
    set -u
fi

nightly_iso_dir=http://dev.packages.vyos.net/iso/helium/amd64/
nightly_iso_dir_formatted="${nightly_iso_dir}?F=0"

oldest_iso=$(curl -s $nightly_iso_dir_formatted | grep "^<li>" | cut -d\" -f2 | head -n 1)

oldest_build_stamp=$(echo $oldest_iso | cut -d- -f3)

IFS=$'\n'
for result in $(aws ec2 describe-images --owners self --filters "Name=tag:build_controller_host,Values=hg,Name=name,Values=*999.*" --output text --query "Images[*].{id:ImageId,iso:Tags[?Key==\`iso\`].Value}" | awk '{print $2, $1}' | sort); do
    current_build_stamp=$(echo $result | cut -d- -f3)
    if [ $current_build_stamp -lt $oldest_build_stamp ]; then
        echo "Delete: $result"
        aws ec2 deregister-image --image-id $(echo $result | awk '{print $2}')
    fi
done

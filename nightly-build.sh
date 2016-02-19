#!/usr/bin/env bash

set -u
set -e

cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ -d env ]; then
    set +u
    source env/bin/activate
    set -u
fi

if [ $# -eq 1 ]; then
    branch=$1
else
    branch=helium
fi

nightly_iso_dir=http://dev.packages.vyos.net/iso/$branch/amd64/
nightly_iso_dir_formatted="${nightly_iso_dir}?F=0"

recent_iso=$(curl -s $nightly_iso_dir_formatted | grep "^<li>" | cut -d\" -f2 | tail -n 1)

recent_iso_url="${nightly_iso_dir}${recent_iso}"
echo "ISO: $recent_iso_url"

matching_images=$(aws ec2 describe-images --filters "Name=tag:iso,Values=$recent_iso" | wc -l)
if [ $matching_images -eq 0 ]; then
    ./vyos-build-ami.sh -e iso=$recent_iso_url
else
    echo "Already have an AMI for $recent_iso."
fi

#!/bin/bash

# vim: filetype=sh:tabstop=2:shiftwidth=2:expandtab

readonly PROGNAME=$(basename $0)
readonly PROGDIR="$( cd "$(dirname "$0" )" ; pwd -P )"
readonly TERRFORM_CMD=`which terraform`
readonly ANSIBLE_CMD=`which ansible`

# BOOLEAN CONSTANTS
declare -r TRUE=0
declare -r TRUE_LITERAL="true"
declare -r FALSE=1
declare -r FALSE_LITERAL="false"

cp /opt/templates/README.md.feh /tmp/README.md

target="/etc/ansible/roles"
let count=0
for f in "$target"/*
do
	sed -i "s/###-->ZZZ_ANSIBLE_ROLES<--###/$(basename $f)\n###-->ZZZ_ANSIBLE_ROLES<--###/g" /tmp/README.md
	let count=count+1
done
echo ""
echo "Count: $count"

#sed -i "s/###-->ZZZ_ANSIBLE_ROLES<--###/$(cat \/tmp\/ansible-roles)/g" /tmp/README.md
sed -i 's/###-->ZZZ_ANSIBLE_ROLES<--###//g' /tmp/README.md

DATE=`date "+%Y-%m-%dT%H:%M:%S%z"`
SYS_MSG="System generated on $DATE" 
sed -i "s/###-->ZZZ_SYSTEM_NOTE<--###/$SYS_MSG/g" /tmp/README.md

cp /tmp/README.md /data/README.md


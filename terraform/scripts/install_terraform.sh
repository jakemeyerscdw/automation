#!/bin/bash
set -e

## Terribly simplistic Terraform install script

## NOTE: This script assumes your $TERRAFORM_BIN_DIR is already in your PATH

TERRAFORM_VERSION=${TERRAFORM_VERSION:-0.6.12}
TERRAFORM_BIN_DIR=${TERRAFORM_BIN_DIR:-$HOME/bin}
TERRAFORM_TEMP=${TERRAFORM_TEMP:-/tmp/terraform.zip}

WGET_BIN=`which wget`
UNZIP_BIN=`which unzip`
DOCKER_BIN=`which docker`

"$WGET_BIN" -q -O "$TERRAFORM_TEMP" "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
"$UNZIP_BIN" "$TERRAFORM_TEMP" -d "$TERRAFORM_BIN_DIR"
rm -rf "$TERRAFORM_TEMP"

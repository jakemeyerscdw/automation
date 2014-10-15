#!/bin/bash

# vim: filetype=sh:tabstop=2:shiftwidth=2:expandtab

readonly PROGNAME=$(basename $0)
readonly PROGDIR="$( cd "$(dirname "$0" )" ; pwd -P )"
readonly TERRFORM_CMD=`which terraform`
readonly ANSIBLE_CMD=`which ansible`
readonly TEARDOWN_PLAN_NAME=destroy.tfplan

declare -r TRUE=0
declare -r FALSE=1

# Get to where we need to be.
cd $PROGDIR

# Globals could be overridden as command line arguments
TERRAFORM_CONFIGS_DIR=/tf
TERRAFORM_PLANS_DIR=${TERRAFORM_CONFIGS_DIR}/plans

prerequisites()
{
  if [ -z "$TERRFORM_CMD"  ]; then
    echo -e "\t\033[33mTerraform does not appear to be installed. Please rebuild this Docker image with Terraform installed and re-run this script."
    exit 1
  fi  
  
  if [ -z "$ANSIBLE_CMD"  ]; then
    echo -e "\t\033[33mAnsible does not appear to be installed. Please rebuild this Docker image with Ansible installed and re-run this script."
    exit 1
  fi  
                  
}

valid()
{
	if [ ! -d "$TERRAFORM_CONFIGS_DIR"  ]; then
    echo -e "\033[31mERROR: terraform directory \"$TERRAFORM_CONFIGS_DIR\" does not exist.  This directory is expected to use Terraform for provisioning."
    echo -e "\e[0m"
    exit 1
  fi

	if [ ! -d "$TERRAFORM_PLANS_DIR"  ]; then
    echo -e "\033[31mERROR: terraform directory \"$TERRAFORM_PLANS_DIR\" does not exist.  This directory is expected to use Terraform for provisioning."
    echo -e "\e[0m"
    exit 1
  fi
}

destroy()
{
  cd $TERRAFORM_CONFIGS_DIR && $TERRFORM_CMD plan -destroy -out=$TERRAFORM_PLANS_DIR/$TEARDOWN_PLAN_NAME -state=$TERRAFORM_PLANS_DIR/terraform.tfstate -refresh=true -backup=$TERRAFORM_PLANS_DIR//terraform.tfstate.backup && $TERRFORM_CMD apply -state=$TERRAFORM_PLANS_DIR/terraform.tfstate -backup=$TERRAFORM_PLANS_DIR//terraform.tfstate.backup $TERRAFORM_PLANS_DIR/$TEARDOWN_PLAN_NAME
}

main()
{ 
  # Verify that our executables exist 
  prerequisites 
  
  # Perform sanity checks
  valid

  # Teardown using Terraform
  destroy 
}

main

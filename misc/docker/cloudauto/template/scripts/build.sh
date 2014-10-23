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

# plan names
readonly BUILD_PLAN_NAME=build.tfplan

# Globals could be overridden as command line arguments
TERRAFORM_CONFIGS_DIR=/tf
TERRAFORM_PLANS_DIR=${TERRAFORM_CONFIGS_DIR}/plans


usage()
{
  echo -e "\033[33mHere's how to provision your infrastructure:"
  echo ""
  echo -e "\033[33mUsage: $PROGNAME [flag]"
  echo -e "\t\033[33m-h --help\t\t\tDisplay this message."
  echo -e "\t\033[33m-p --plan\t\t\tPlan your execution plan only.  No provisioning is performed."
  echo -e "\033[0m"
                                      
}


parse_args()
{
  while [ "$1" != ""  ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
      -h | --help)
        usage
        exit
        ;;
      -p | --plan)
        PLAN_LABEL=TRUE_LITERAL
        ;;
      *)
        echo -e "\033[31mERROR: unknown parameter \"$PARAM\""
        echo -e "\e[0m"
        usage
        exit 1
        ;;
    esac
    shift
  done
}


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


planonly()
{
  # cd /tf && terraform plan -state=/tf/plans/terraform.tfstate -refresh=true -backup=/tf/plans/terraform.tfstate.backup
  cd $TERRAFORM_CONFIGS_DIR && $TERRFORM_CMD plan -state=$TERRAFORM_PLANS_DIR/terraform.tfstate -refresh=true -backup=$TERRAFORM_PLANS_DIR/terraform.tfstate.backup
}


provision()
{
	
  # cd /tf && terraform apply -state=/tf/plans/terraform.tfstate -refresh=true -backup=/tf/plans/terraform.tfstate.backup
  cd $TERRAFORM_CONFIGS_DIR && $TERRFORM_CMD apply -state=$TERRAFORM_PLANS_DIR/terraform.tfstate -refresh=true -backup=$TERRAFORM_PLANS_DIR/terraform.tfstate.backup
}

main()
{ 
  # Verify that our executables exist 
  prerequisites 
  
  # Perform sanity checks
  valid

  # Plan 
  if [[ -n "$PLAN_LABEL"   ]] ; then
   planonly
  else
   # or provision
    provision
  fi  

}

parse_args "$@"
main

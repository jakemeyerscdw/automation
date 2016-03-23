variable "name"     { }
variable "location" { }
variable "env"      { default = "" }

variable "storage_type" { default = "Standard_GRS" }


provider "azurerm" {
}

module "resource_group" {
  source = "../../../modules/azure/util/resourcegrp"

  name     = "${var.name}-resourcegrp"
  location = "${var.location}"
  tag_env  = "${var.env}"
}

module "storage_account" {
  source = "../../../modules/azure/util/storageacct"

  name          = "${var.name}"
  rsrc_grp_name = "${module.resource_group.name}"
  account_type  = "${var.storage_type}"
  location      = "${var.location}"
  tag_env       = "${var.env}"
}


output "configuration" {
  value = <<CONFIGURATION

Cloud Provider:
  Name: Azure

  Resource Group:
    ID: ${module.resource_group.id}
    Name: ${module.resource_group.name}
    Location: ${module.resource_group.location}
    Tags:
      env: ${module.resource_group.env}
  
  Storage Account:
    ID: ${module.storage_account.id}
    Name: ${module.storage_account.name}
    Location: ${module.storage_account.location}
    Tags:
      env: ${module.storage_account.env}

CONFIGURATION
}

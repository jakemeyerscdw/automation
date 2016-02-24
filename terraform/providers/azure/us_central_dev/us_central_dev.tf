variable "name"              { }
variable "region"            { }
variable "tag_env"           { default = "dev" }

#variable "feh_client_id" { }
#variable "feh_client_secret" { } 
#variable "feh_tenant_id" { } 

provider "azurerm" {
}

#provider "azurerm" {
#  client_id       = "${var.feh_client_id}"
#  client_secret   = "${var.feh_client_secret}"
#  tenant_id       = "${var.feh_tenant_id}"
#}



module "resource_group" {
  source = "../../../modules/azure/util/resourcegrp"

  name     = "${var.name}"
  location = "${var.region}"
  tag_env  = "${var.tag_env}"
}


output "configuration" {
  value = <<CONFIGURATION

Cloud Provider:
  Name: Azure
  Resource Group: ${module.resource_group.name}

CONFIGURATION
}
variable "name"              { }
variable "region"            { }
variable "tag_env"           { default = "dev" }

provider "azurerm" {
}

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

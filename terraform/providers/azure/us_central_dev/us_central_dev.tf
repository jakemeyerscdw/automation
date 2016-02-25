variable "name"              { }

provider "azurerm" {
}

module "resource_group" {
  source = "../../../modules/azure/util/resourcegrp"

  name     = "${var.name}"
  location = "Central US"
  tag_env  = "dev"
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

CONFIGURATION
}

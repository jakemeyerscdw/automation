#--------------------------------------------------------------
# This module is used to create an Azure resource group 
#--------------------------------------------------------------

variable "name"   { default = "azure_default_rsrc_grp" }
variable "location"   { default = "azure_default_rsrc_grp" }
variable "tag_env" { default = "n/a" }

resource "azurerm_resource_group" "group" {
  name = "${var.name}"
  location = "${var.location}"

  tags {
    environment = "${var.tag_env}"
  }
}

output "name" { value = "${azurerm_resource_group.group.name}" }
output "location" { value = "${azurerm_resource_group.group.location}" }
output "id" { value = "${azurerm_resource_group.group.id}" }

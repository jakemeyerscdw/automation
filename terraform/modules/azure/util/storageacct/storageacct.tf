#--------------------------------------------------------------
# This module is used to create an Azure storage account 
#--------------------------------------------------------------

variable "name"          { default = "azure_default_storage_acct" }
variable "rsrc_grp_name" { default = "azure_default_rsrc_grp" }
variable "location"      { default = "westus" }
variable "account_type"  { default = "Standard_LRS" }
variable "tag_env"       { default = "n/a" }

resource "azurerm_storage_account" "defaultsa" {
  name = "${var.name}"
  resource_group_name = "${var.rsrc_grp_name}"

  location = "${var.location}"
  account_type = "${var.account_type}"
  
  tags {
    environment = "${var.tag_env}"
  }
}

output "id"           { value = "${azurerm_storage_account.defaultsa.id}" }
output "name"         { value = "${azurerm_storage_account.defaultsa.name}" }
output "location"     { value = "${azurerm_storage_account.defaultsa.location}" }
output "account_type" { value = "${azurerm_storage_account.defaultsa.account_type}" }
output "env"          { value = "${azurerm_storage_account.defaultsa.tags.environment}" }

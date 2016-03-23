## Azure Notes
[Azure][1] users can quickly develop a love/hate relationship with the product offering. Here are some notes 
to make your experience using [Terraform][2] to manage Azure resources less painful.


### Authentication
The first pain point you run into with using Terraform on Azure is authentication. Some of the crazy, and sadly erroneous, assumptions I made:
* I could use the Azure portal to set up all the credential information I needed to use Terraform.
* I could expect feature parity between the *[classic][3]* and *[new][4]* Azure portals.
* While not ideal, I could install the [Azure CLI][5] and follow the [presribed instructions][6] for creating credentials.

All the above only got me partial success:
```bash
Refreshing Terraform state prior to plan...

Error refreshing state: 1 error(s) occurred:

* autorest:DoErrorUnlessStatusCode 403 POST https://management.azure.com/subscriptions/<subscription_id>/providers/Microsoft.Network/register?api-version=2014-04-01-preview failed with 403 Forbidden
````

#### What *Should* I Do?
* Again not ideal, but go ahead and install the [Azure CLI][5].
* Learn Japanese.  Okay, just kidding.  The secret sauce was found in this Azure [tutorial][7].  The key is that your service principal needs a "conributor" role:

```bash
$ azure role assignment create --objectId SpObjId-SpObjId-SpObjId-SpObjId-SpObjId -o Contributor -c /subscriptions/SubId-SubId-SubId-SubId-SubId/
info:    Executing command role assignment create
+ Finding role with specified name
/data:    RoleAssignmentId     : /subscriptions/SubId-SubId-SubId-SubId-SubId/providers/Microsoft.Authorization/roleAssignments/RoleAsId-RoleAsId-RoleAsId-RoleAsId
data:    RoleDefinitionName   : Contributor
data:    RoleDefinitionId     : RoleDefId-RoleDefId-RoleDefId-RoleDefId-RoleDefId
data:    Scope                : /subscriptions/SubId-SubId-SubId-SubId-SubId
data:    Display Name         : My Terraform
data:    SignInName           :
data:    ObjectId             : SpObjId-SpObjId-SpObjId-SpObjId-SpObjId
data:    ObjectType           : ServicePrincipal
data:
+
info:    role assignment create command OK
````


### Storage Accounts
Another rabbit hole to avoid is naming of [storage accounts][8]: 

```bash
Error applying plan:

1 error(s) occurred:

* azurerm_storage_account.defaultsa: Error creating Azure Storage Account 'sandbox': autorest:DoErrorUnlessStatusCode 409 PUT https://management.azure.com/subscriptions/<subscription_id>/resourceGroups/sandbox-resourcegrp/providers/Microsoft.Storage/storageAccounts/sandbox?api-version=2015-06-15 failed with 409 Conflict

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.
````

My incorrect assumption was that storage account names needed to be unique across your subscription.  There is a uniqueness constraint, but it's across ***all*** of Azure!



[1]: https://azure.microsoft.com/en-us/
[2]: https://www.terraform.io
[3]: https://manage.windowsazure.com
[4]: https://portal.azure.com/#
[5]: https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/
[6]: https://azure.microsoft.com/en-us/documentation/articles/resource-group-authenticate-service-principal/#authenticate-with-password---azure-cli
[7]: http://torumakabe.github.io/post/azure_tf_arm_sp/
[8]: https://azure.microsoft.com/en-us/documentation/articles/storage-create-storage-account/

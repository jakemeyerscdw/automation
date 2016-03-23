## Azure Notes
[Azure][1] users can quickly develop a love/hate relationship with the product offering. Here are some notes 
to make your experience using [Terraform][2] to manage Azure resources less painful.


### Authentication
The first pain point you run into with using [Terraform][2] on Azure is authentication. Some of the crazy, and sadly erroneous, assumptions I made:
* I could use the Azure portal to set up all the credential information I needed to use Terraform.
* I could expect feature parity between the *[classic][3]* and *[new][4]* Azure portals.
* While not ideal, I could install the [Azure CLI][5] and follow the [presribed instructions][6] for creating credentials.


[1]: https://azure.microsoft.com/en-us/
[2]: https://www.terraform.io
[3]: https://manage.windowsazure.com
[4]: https://portal.azure.com/#
[5]: https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/
[6]: https://azure.microsoft.com/en-us/documentation/articles/resource-group-authenticate-service-principal/#authenticate-with-password---azure-cli

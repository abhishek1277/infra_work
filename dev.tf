
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan123"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-app-service3245"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
  }

resource "azurerm_template_deployment" "example" {
  name                = "acctesttemplate-01"
  resource_group_name = azurerm_resource_group.example.name

  template_body =<<DEPLOY
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
        "sites_example_app_service3245_name": {
            "defaultValue": "example-app-service3245",
            "type": "String"
        },
        "serverfarms_example_appserviceplan123_externalid": {
             "defaultValue": "/subscriptions/3457d5d0-1535-40c6-85fb-cb1919104698/resourceGroups/example-resources/providers/Microsoft.Web/serverfarms/example-appserviceplan123",
            "type": "String"
        }
    },
  "resources":[
    {
            "type": "Microsoft.Web/sites/siteextensions",
            "apiVersion": "2018-11-01",
            "name": "[concat(parameters('sites_example_app_service3245_name'), '/NewRelic.Azure.WebSites.Extension')]",
            "location": "West Europe",
#             "dependsOn": [
#                 "[resourceId('Microsoft.Web/sites', parameters('sites_example_app_service3245_name'))]"
#             ]
    }
  ]
}
DEPLOY
   deployment_mode = "Incremental"
}


data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "Prod112"
    workspaces = {
      name = "infra_work"
    }
  }
}
provider "azurerm" {
  version = "~>2.46.0"
    features {}
  }

 

 
variable "location_name" {
  type = string
  description = "Resource location"
  default = "westeurope"
}
 
 
resource "azurerm_resource_group" "rg1" {
  name = "devrg"
  location = var.location_name
}

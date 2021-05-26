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

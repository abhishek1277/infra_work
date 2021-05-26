
resource "azurerm_resource_group" "rg1" {
  name = "devrg"
  location = "eastus"
}

resource "azurerm_virtual_network" "example" {
  name                = "example1-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

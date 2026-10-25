resource "azurerm_virtual_network" "myvnet" {
    for_each = var.vnet
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    address_space       = ["10.0.0.0/16"]


}
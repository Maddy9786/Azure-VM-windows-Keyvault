output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.my_subnet :
    key => subnet.id
  }
}
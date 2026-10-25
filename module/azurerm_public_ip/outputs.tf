output "public_ip_ids" {
  value = {
    for key, pip in azurerm_public_ip.my_public_ip :
    key => pip.id
  }
}
resource "azurerm_network_interface" "mynic" {
  for_each = var.vm  
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "my-nic-configuration"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_allocation
    public_ip_address_id = each.value.public_ip_id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_association" {
  for_each = var.vm  
  network_interface_id      = azurerm_network_interface.mynic[each.key].id
  network_security_group_id = each.value.network_security_group_id
}


resource "azurerm_windows_virtual_machine" "myvm" {
  for_each = var.vm  
  name                  = each.value.vm_name
  admin_username        = each.value.admin_username
  admin_password        = data.azurerm_key_vault_secret.myvmsecret[each.key].value
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.mynic[each.key].id]
  size                  = each.value.vm_size

  os_disk {
    name                 = each.value.os_disk_name
    caching              = each.value.caching
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}
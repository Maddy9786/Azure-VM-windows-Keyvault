data "azurerm_key_vault" "mykv" {
  for_each = var.vm
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "myvmsecret" {
  for_each = var.vm  
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.mykv[each.key].id
}
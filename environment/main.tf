module "rg" {
  source = "../module/azurerm-resource-group"
  rgs    = var.rgs
}


module "myvnet" {
  depends_on = [module.rg]
  source     = "../module/azurerm-virtual-network"
  vnet       = var.vnet
}

module "subnets" {
  depends_on = [module.rg, module.myvnet]
  source     = "../module/azurerm_subnets"
  subnets    = var.subnets
}


module "pip" {
  depends_on = [module.rg]
  source     = "../module/azurerm_public_ip"
  pips       = var.pips
}

module "nsgs" {
  depends_on = [module.rg]
  source     = "../module/azurerm_nsg"
  nsgs       = var.nsgs
}

module "kv" {
  depends_on = [module.rg]
  source     = "../module/azurerm-keyvault"
  kv         = var.kv
}

module "vm" {
  depends_on = [module.rg, module.kv, module.myvnet, module.nsgs, module.pip, module.subnets]
  source     = "../module/azurerm-virtual-machine"
  vm = {
    for key, config in var.vm : key => merge(config, {
      subnet_id                 = module.subnets.subnet_ids["sub1"]
      network_security_group_id = module.nsgs.nsg_ids["nsg1"]
      public_ip_id              = module.pip.public_ip_ids["pip1"]
    })
  }

}


rgs = {
  rg1 = {
    name     = "demo-rg"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "myvnet"
    address_space       = ["10.0.0.0/16"]
    location            = "centralindia"
    resource_group_name = "demo-rg"
  }
}

subnets = {
  sub1 = {
    subnet_name          = "fromntend-vm-subnet"
    address_prefixes     = ["10.0.1.0/24"]
    location             = "centralindia"
    resource_group_name  = "demo-rg"
    virtual_network_name = "myvnet"
  }
}

pips = {
  pip1 = {
    pip_name            = "frontend-public-ip"
    location            = "centralindia"
    resource_group_name = "demo-rg"
    allocation_method   = "Static"
  }
}

nsgs = {
  nsg1 = {
    nsg_name            = "frontend-nsg"
    location            = "centralindia"
    resource_group_name = "demo-rg"

    security_rule = [
      {
        name                       = "RDP"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "YOUR_PUBLIC_IP/32"
        destination_address_prefix = "*"
      },
      {
        name                       = "web"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

kv = {
  kv1 = {
    name                        = "my-key-vaulteksat"
    location                    = "centralindia"
    resource_group_name         = "demo-rg"
    rbac_authorization_enabled  = false
    enabled_for_disk_encryption = false
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    secret_name                 = "adminuser"
    secret                      = "Test@123456789"
  }
}

vm = {
  vm1 = {
    nic_name                  = "frontend_vm_nic_name"
    location                  = "centralindia"
    resource_group_name       = "demo-rg"
    private_ip_allocation     = "Dynamic"
    network_security_group_id = "frontend-nsg"
    vm_name                   = "fontend-vm"
    vm_size                   = "Standard_D2ls_v6"
    os_disk_name              = "myOsDisk"
    caching                   = "ReadWrite"
    publisher                 = "MicrosoftWindowsServer"
    offer                     = "WindowsServer"
    sku                       = "2025-datacenter-g2"
    version                   = "latest"

    key_vault_name = "my-key-vaulteksat"
    secret_name    = "adminuser"
    admin_username = "azureadmin"
  }
}


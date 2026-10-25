terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.11.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "48f7ba91-6439-4c9d-a5b9-94a68189cfba"
    resource_group_name  = "Backend_resource_group"
    storage_account_name = "backendremotesatesa"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"

  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
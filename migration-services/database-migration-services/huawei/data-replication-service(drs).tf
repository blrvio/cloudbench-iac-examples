
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use o recurso mais recente
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "drs_resource_group" {
  name     = "drs-resource-group"
  location = "eastus"
}

# Crie uma conta de recuperação
resource "azurerm_site_recovery_vault" "drs_vault" {
  name                = "drs-vault"
  resource_group_name = azurerm_resource_group.drs_resource_group.name
  location            = azurerm_resource_group.drs_resource_group.location
  sku {
    name = "Standard"
  }
}

# Crie um servidor de gerenciamento
resource "azurerm_site_recovery_management_server" "drs_management_server" {
  name                = "drs-management-server"
  resource_group_name = azurerm_resource_group.drs_resource_group.name
  location            = azurerm_resource_group.drs_resource_group.location
  vault_name           = azurerm_site_recovery_vault.drs_vault.name
  vm_size              = "Standard_A2_v2"
  os_type              = "Windows"
  vm_disk_size_gb     = 1023
  properties {
    protection_source         = "On-premises"
    license_type             = "BringYourOwnLicense"
    install_method            = "Manual"
    network_credential_name  = "drs-network-credential"
    run_as_account           = "LocalSystem"
    server_version          = "Latest"
    source_id                 = "drs-source-id"
    fabric_region            = "East US"
    fabric_location          = "West Europe"
    fabric_name             = "drs-fabric"
    management_server_role   = "Primary"
  }
}
    
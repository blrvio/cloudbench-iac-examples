
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use o recurso `features` para habilitar recursos beta
}

# Crie um vault de recuperação de sítio
resource "azurerm_site_recovery_vault" "example" {
  name                = "example-vault"
  resource_group_name = "example-resources"
  location            = "westus"
}

# Crie um grupo de proteção
resource "azurerm_site_recovery_protection_group" "example" {
  name                = "example-pg"
  resource_group_name = "example-resources"
  vault_name          = azurerm_site_recovery_vault.example.name
}

# Adicione uma máquina virtual à proteção
resource "azurerm_site_recovery_protection_container" "example" {
  name                = "example-pc"
  resource_group_name = "example-resources"
  vault_name          = azurerm_site_recovery_vault.example.name
  fabric_type         = "Azure"
}

# Crie um plano de recuperação
resource "azurerm_site_recovery_recovery_plan" "example" {
  name                = "example-rp"
  resource_group_name = "example-resources"
  vault_name          = azurerm_site_recovery_vault.example.name
}

# Adicione o grupo de proteção ao plano de recuperação
resource "azurerm_site_recovery_recovery_plan_group" "example" {
  name                = "example-rpg"
  resource_group_name = "example-resources"
  vault_name          = azurerm_site_recovery_vault.example.name
  recovery_plan_name  = azurerm_site_recovery_recovery_plan.example.name
  protection_group_id = azurerm_site_recovery_protection_group.example.id
}
    
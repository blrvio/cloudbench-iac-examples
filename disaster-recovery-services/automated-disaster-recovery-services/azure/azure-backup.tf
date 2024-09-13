
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use este bloco para habilitar recursos pré-lançados
}

# Crie um cofre de backup
resource "azurerm_backup_vault" "example" {
  name                = "example-vault"
  resource_group_name = "example-resource-group"
  location            = "westus"
  # Configure o armazenamento associado ao cofre de backup
  # storage_model       = "LocallyRedundant"
  # storage_type        = "Standard"
}

# Crie uma política de backup
resource "azurerm_backup_policy" "example" {
  name                = "example-policy"
  resource_group_name = "example-resource-group"
  vault_name          = azurerm_backup_vault.example.name

  # Configure a programação de backup
  # schedule_policy {
  #   schedule_frequency = "Daily"
  #   retention_policy {
  #     daily_retention_range = 10
  #   }
  # }
}

# Crie um backup para um recurso Azure
resource "azurerm_backup_protection" "example" {
  name                = "example-protection"
  resource_group_name = "example-resource-group"
  vault_name          = azurerm_backup_vault.example.name
  # Configure o recurso a ser protegido, como uma máquina virtual
  # source_vm {
  #   virtual_machine_name = "example-vm"
  # }
  # Configure a política de backup associada
  policy_name = azurerm_backup_policy.example.name
}
    
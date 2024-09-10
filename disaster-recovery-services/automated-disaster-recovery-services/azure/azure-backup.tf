
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Optional: Enable specific Azure features
}

# Create a Recovery Services Vault
resource "azurerm_recovery_services_vault" "main" {
  name                = "my-recovery-services-vault"
  resource_group_name = "my-resource-group"
  location             = "westus2"
  # Optional: Add tags to the vault
  tags = {
    Environment = "Production"
  }
}

# Create a Backup Policy
resource "azurerm_backup_policy" "main" {
  name                = "my-backup-policy"
  resource_group_name = "my-resource-group"
  vault_name          = azurerm_recovery_services_vault.main.name
  # Define backup schedule
  schedule {
    frequency = "Daily"
    retention_duration = 365  # Retention policy
  }
}

# Create a Backup Protection Container
resource "azurerm_backup_protection_container" "main" {
  name                = "my-backup-container"
  resource_group_name = "my-resource-group"
  vault_name          = azurerm_recovery_services_vault.main.name
  # Define the type of resource to backup
  backup_management_type = "AzureIaasVM"
}

# Create a Backup Policy Assignment
resource "azurerm_backup_policy_assignment" "main" {
  name                = "my-backup-policy-assignment"
  resource_group_name = "my-resource-group"
  vault_name          = azurerm_recovery_services_vault.main.name
  container_name      = azurerm_backup_protection_container.main.name
  policy_name         = azurerm_backup_policy.main.name
}

# Create a Backup Job
resource "azurerm_backup_job" "main" {
  name                = "my-backup-job"
  resource_group_name = "my-resource-group"
  vault_name          = azurerm_recovery_services_vault.main.name
  # Define the container and policy to use
  container_name = azurerm_backup_protection_container.main.name
  policy_name     = azurerm_backup_policy.main.name
}

  
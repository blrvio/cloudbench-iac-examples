
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create an Azure Site Recovery Vault
resource "azurerm_site_recovery_vault" "main" {
  name                = "my-vault"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  # This is required to register the provider
  # as a feature in the Vault.
  provider_details {
    azure_region = "westus2"
    # If you are using a service principal to authenticate,
    # make sure to set the Service Principal ID
    # using the `client_id` variable
    client_id = "my-service-principal-id"
    # If you are using a service principal to authenticate,
    # make sure to set the Service Principal Secret
    # using the `client_secret` variable
    client_secret = "my-service-principal-secret"
  }
}

# Create a Recovery Services Fabric
resource "azurerm_site_recovery_fabric" "main" {
  name                = "my-fabric"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  vault_id            = azurerm_site_recovery_vault.main.id
}

# Create a Protection Container
resource "azurerm_site_recovery_protection_container" "main" {
  name                = "my-container"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  fabric_id            = azurerm_site_recovery_fabric.main.id
  vault_id            = azurerm_site_recovery_vault.main.id
}

# Create a Protection Profile
resource "azurerm_site_recovery_protection_profile" "main" {
  name                = "my-profile"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  vault_id            = azurerm_site_recovery_vault.main.id
  # This is required for replicating the VM to the secondary region.
  recovery_plan_id = azurerm_site_recovery_recovery_plan.main.id
}

# Create a Recovery Plan
resource "azurerm_site_recovery_recovery_plan" "main" {
  name                = "my-plan"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  vault_id            = azurerm_site_recovery_vault.main.id
}

# Create a Replication Policy
resource "azurerm_site_recovery_replication_policy" "main" {
  name                = "my-policy"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  vault_id            = azurerm_site_recovery_vault.main.id
}

# Create a Protected VM
resource "azurerm_site_recovery_protected_vm" "main" {
  name                = "my-vm"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  vault_id            = azurerm_site_recovery_vault.main.id
  # This is required for the VM to be protected.
  protection_container_id = azurerm_site_recovery_protection_container.main.id
  protection_profile_id   = azurerm_site_recovery_protection_profile.main.id
  replication_policy_id   = azurerm_site_recovery_replication_policy.main.id
  # Use a valid ARM ID of a VM
  source_vm_id = "my-vm-arm-id"
}

  
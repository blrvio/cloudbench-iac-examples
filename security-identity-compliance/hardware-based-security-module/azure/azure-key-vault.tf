
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Key Vault
resource "azurerm_key_vault" "example" {
  name                 = "example-key-vault"
  location             = "westus2"
  resource_group_name = "example-resources"
  # Soft-delete protection prevents accidental deletion
  enabled_for_soft_delete = true
  # Enable purge protection to prevent permanent deletion
  enabled_for_purge_protection = true
}

# Create a Secret in Key Vault
resource "azurerm_key_vault_secret" "example" {
  name                = "my-secret"
  key_vault_name      = azurerm_key_vault.example.name
  resource_group_name = azurerm_key_vault.example.resource_group_name
  value               = "my-secret-value"
  # Enable secret rotation
  enabled_for_deployment = true
  # Set the content type for the secret
  content_type          = "application/json"
}

# Access the secret value using the `data` resource
# This can be used within other resources or in your scripts
data "azurerm_key_vault_secret" "example" {
  name                = "my-secret"
  key_vault_name      = azurerm_key_vault.example.name
  resource_group_name = azurerm_key_vault.example.resource_group_name
}

output "secret_value" {
  value = data.azurerm_key_vault_secret.example.value
}
  
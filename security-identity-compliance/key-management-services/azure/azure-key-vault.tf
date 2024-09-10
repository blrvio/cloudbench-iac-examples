
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Use AzureRM features
}

# Create a Key Vault
resource "azurerm_key_vault" "example" {
  name                = "my-key-vault"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Use existing vault access policy
  enable_soft_delete = true
  # Enable purging of deleted objects
  enable_purge_protection = false
  # Specify the tenant id to associate with the key vault
  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
}

# Create a Key Vault Secret
resource "azurerm_key_vault_secret" "example" {
  name                = "my-secret"
  value               = "my-secret-value"
  key_vault_id        = azurerm_key_vault.example.id
  content_type         = "application/json"
}

# Create a Key Vault Certificate
resource "azurerm_key_vault_certificate" "example" {
  name                    = "my-certificate"
  key_vault_id            = azurerm_key_vault.example.id
  subject                 = "example.com"
  dns_names              = ["example.com", "*.example.com"]
  duration_in_months      = 12
  deletion_protection_enabled = false
}

# Create a Key Vault Key
resource "azurerm_key_vault_key" "example" {
  name                = "my-key"
  key_vault_id        = azurerm_key_vault.example.id
  key_type            = "RSA"
  key_size             = 2048
  key_ops              = ["sign", "verify", "wrapKey", "unwrapKey"]
  # Create the key in a specific version
  key_version           = "2.0.0"
  deletion_protection_enabled = false
  # Set the key usage to a custom value
  key_usage           = "My Key Usage"
}

  
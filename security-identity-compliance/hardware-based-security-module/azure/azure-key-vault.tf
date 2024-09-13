
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Se necessário, configure os recursos aqui
}

# Crie um Key Vault
resource "azurerm_key_vault" "example" {
  name = "example-key-vault"
  location = "westus2"
  resource_group_name = "example-resources"

  # Aqui pode adicionar configurações adicionais, como tags, enabled_for_deployment, etc.
}

# Crie um segredo no Key Vault
resource "azurerm_key_vault_secret" "example" {
  name = "example-secret"
  key_vault_id = azurerm_key_vault.example.id
  value = "secret-value"

  # Aqui pode adicionar configurações adicionais, como content_type, enabled, etc.
}
    
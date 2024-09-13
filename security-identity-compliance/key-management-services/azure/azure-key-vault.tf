
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Substitua pelas características desejadas
}

# Crie um Key Vault
resource "azurerm_key_vault" "example" {
  name                = "example-keyvault"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku_name            = "standard"
  soft_delete_enabled  = true
}

# Crie uma chave
resource "azurerm_key_vault_key" "example" {
  name         = "example-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048
  key_operations = ["sign", "verify", "wrapKey", "unwrapKey", "encrypt", "decrypt"]
}

# Crie um segredo
resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  key_vault_id = azurerm_key_vault.example.id
  value        = "secret-value"
}

# Crie um certificado
resource "azurerm_key_vault_certificate" "example" {
  name              = "example-certificate"
  key_vault_id       = azurerm_key_vault.example.id
  password          = "secret-password"
  subject            = "CN=example-cert"
  valid_from         = "2023-01-01T00:00:00Z"
  valid_to           = "2024-01-01T00:00:00Z"
  certificate_policy {
    issuer_parameters {
      name = "Self"
    }
    key_properties {
      exportable             = true
      key_type               = "RSA"
      key_size               = 2048
      key_usage_properties {
        digital_signature = true
        key_encipherment   = true
      }
    }
  }
}
    
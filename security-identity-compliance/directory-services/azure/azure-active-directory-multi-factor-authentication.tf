
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Configurações de recursos opcionais
}

# Crie uma diretiva de autenticação multifator
resource "azurerm_mfa_server" "example" {
  name = "example"
  enabled = true
  # ...
}

# Crie um usuário e configure a MFA
resource "azurerm_user" "example" {
  # ...
}

# ...
resource "azurerm_user_mfa" "example" {
  user_id    = azurerm_user.example.id
  state       = "Enabled"
  enabled     = true
  # ...
}
    
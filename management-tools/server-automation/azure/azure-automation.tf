
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use as features disponíveis
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie uma conta de automação
resource "azurerm_automation_account" "example" {
  name                = "example-automation"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # ... outras configurações da conta de automação ...
}

# Crie um módulo de automação
resource "azurerm_automation_module" "example" {
  name                = "example-module"
  account_name       = azurerm_automation_account.example.name
  resource_group_name = azurerm_resource_group.example.name

  # ... outras configurações do módulo ...
}

# Crie um runbook de automação
resource "azurerm_automation_runbook" "example" {
  name                = "example-runbook"
  account_name       = azurerm_automation_account.example.name
  resource_group_name = azurerm_resource_group.example.name

  # ... outras configurações do runbook ...
}

# Crie uma credencial de automação
resource "azurerm_automation_credential" "example" {
  name                = "example-credential"
  account_name       = azurerm_automation_account.example.name
  resource_group_name = azurerm_resource_group.example.name

  # ... outras configurações da credencial ...
}

# Crie uma variável de automação
resource "azurerm_automation_variable" "example" {
  name                = "example-variable"
  account_name       = azurerm_automation_account.example.name
  resource_group_name = azurerm_resource_group.example.name

  # ... outras configurações da variável ...
}
    
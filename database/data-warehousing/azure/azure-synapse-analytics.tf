
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use a versão mais recente do provedor
}

# Crie um workspace do Azure Synapse Analytics
resource "azurerm_synapse_workspace" "example" {
  name                = "example-workspace"
  location            = "westus2"
  resource_group_name = "example-resources"
  sql_administrator_login = "admin"
  sql_administrator_login_password = "examplepassword"
  # Outros atributos podem ser configurados conforme necessário
}

# Crie um pool dedicado do Azure Synapse Analytics
resource "azurerm_synapse_sql_pool" "example" {
  name                = "example-pool"
  location            = "westus2"
  resource_group_name = "example-resources"
  workspace_name     = azurerm_synapse_workspace.example.name
  # Outros atributos podem ser configurados conforme necessário
}

# Crie uma tabela no pool dedicado
resource "azurerm_synapse_sql_table" "example" {
  name                = "example-table"
  schema              = "dbo"
  location            = "westus2"
  resource_group_name = "example-resources"
  workspace_name     = azurerm_synapse_workspace.example.name
  sql_pool_name      = azurerm_synapse_sql_pool.example.name
  # Outros atributos podem ser configurados conforme necessário
}
    
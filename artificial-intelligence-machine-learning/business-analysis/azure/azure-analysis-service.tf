
      # Configure o provedor do Azure
provider "azurerm" {
  features {} #  Para usar recursos mais recentes
}

# Crie um servidor do Azure Analysis Services
resource "azurerm_analysis_services_server" "example" {
  name                = "example-aas-server"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku                  = "Standard"
  administrator_contact_email = "admin@example.com"
}

# Crie uma base de dados do Azure Analysis Services
resource "azurerm_analysis_services_database" "example" {
  name                = "example-aas-database"
  server_name          = azurerm_analysis_services_server.example.name
  resource_group_name = azurerm_analysis_services_server.example.resource_group_name
  edition              = "Enterprise"
  compatibility_level  = "1400"
}

# Crie uma tabela dentro da base de dados
resource "azurerm_analysis_services_table" "example" {
  name                = "example-table"
  database_name        = azurerm_analysis_services_database.example.name
  server_name          = azurerm_analysis_services_server.example.name
  resource_group_name = azurerm_analysis_services_server.example.resource_group_name
}

    
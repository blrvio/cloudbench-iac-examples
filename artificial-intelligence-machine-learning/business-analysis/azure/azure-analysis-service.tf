
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features, you can select specific features if needed.
}

# Create an Azure Analysis Services Server
resource "azurerm_analysis_services_server" "main" {
  name                     = "my-analysis-services-server"
  location                 = "westus2"
  resource_group_name     = "my-resource-group"
  sku {
    name = "Standard"
    tier = "Standard"
  }
  # Use `azurerm_analysis_services_server_admin` to manage server admins.
}

# Create an Azure Analysis Services Database
resource "azurerm_analysis_services_database" "main" {
  name                 = "my-analysis-services-database"
  location             = "westus2"
  resource_group_name = "my-resource-group"
  server_name         = azurerm_analysis_services_server.main.name
  # Use `azurerm_analysis_services_database_admin` to manage database admins.
}

# You can create other resources like storage accounts, key vaults and other Azure resources that interact with your Analysis Services server.

  
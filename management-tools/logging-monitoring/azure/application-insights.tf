
      # Configure o provedor do Azure
provider "azurerm" {
  features {}
}

# Crie um recurso de Application Insights
resource "azurerm_application_insights" "example" {
  name                = "example-insights"
  location            = "westus2"
  resource_group_name = "example-resources"
  application_type     = "web"
}

# Configure um workspace Log Analytics
resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-workspace"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku                 = "PerGB2018"
}

# Crie um recurso de Application Insights conectado a um workspace Log Analytics
resource "azurerm_application_insights" "example" {
  name                = "example-insights"
  location            = "westus2"
  resource_group_name = "example-resources"
  application_type     = "web"
  workspace_id         = azurerm_log_analytics_workspace.example.id
}
    
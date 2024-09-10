
    # Configure the Azure Provider
provider "azurerm" {
  features {} 
}

# Create an Application Insights resource
resource "azurerm_application_insights" "example" {
  name                 = "example-insights"
  location             = "westus2"
  resource_group_name  = "example-resources"
  application_type     = "web"
  # Optional settings
  # tags                  = {
  #   environment = "dev"
  # }
}

# Create a Log Analytics Workspace for Application Insights
resource "azurerm_log_analytics_workspace" "example" {
  name                 = "example-workspace"
  location             = "westus2"
  resource_group_name  = "example-resources"
  sku                  = "pergb"
  # Optional settings
  # retention_in_days = 730
  # tags              = {
  #   environment = "dev"
  # }
}

# Connect the Application Insights resource to the Log Analytics Workspace
resource "azurerm_application_insights_workspace_association" "example" {
  application_insights_id = azurerm_application_insights.example.id
  workspace_id           = azurerm_log_analytics_workspace.example.id
}

  
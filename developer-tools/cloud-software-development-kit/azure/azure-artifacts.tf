
    # Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create an Azure DevOps organization
resource "azurerm_devops_organization" "main" {
  name = "my-organization"
  location = "eastus"
}

# Create an Azure Artifacts feed
resource "azurerm_devops_feed" "main" {
  name = "my-feed"
  organization_id = azurerm_devops_organization.main.id
  project_id = azurerm_devops_project.main.id
  view_type = "public"
}

# Create an Azure DevOps project
resource "azurerm_devops_project" "main" {
  name        = "my-project"
  organization_id = azurerm_devops_organization.main.id
  visibility = "private"
  # You can specify other options such as: 
  #  version_control = "git"
  #  process_template = "Agile"
}

# Create a service connection to Azure DevOps
resource "azurerm_devops_service_connection" "main" {
  name = "my-service-connection"
  organization_id = azurerm_devops_organization.main.id
  project_id = azurerm_devops_project.main.id
  service_type = "AzureDevOps"
  authorization {
    scheme = "OAuth"
    parameters = {
      "serviceUri" = "https://dev.azure.com/my-organization"
    }
  }
}
  
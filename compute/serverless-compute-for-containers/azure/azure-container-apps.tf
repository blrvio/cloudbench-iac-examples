
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a Container App
resource "azurerm_container_app" "example" {
  name                = "example-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Configure the Container App's environment
  environment {
    name              = "example-environment"
    app_insights_key = "example-key"
    managed_identity {
      type = "systemAssigned"
    }
  }
  # Configure the Container App's container
  container {
    name             = "example-container"
    image            = "mcr.microsoft.com/azuredocs/containerapps/sample:v1"
    replicas         = 1
    resources {
      requests {
        memory = "1Gi"
        cpu    = "1"
      }
    }
  }
}

# Create a Container App Revision
resource "azurerm_container_app_revision" "example" {
  name                = "example-revision"
  resource_group_name = azurerm_resource_group.example.name
  container_app_name = azurerm_container_app.example.name
  environment_name   = azurerm_container_app.example.environment.name
  image              = "mcr.microsoft.com/azuredocs/containerapps/sample:v1"
}

  
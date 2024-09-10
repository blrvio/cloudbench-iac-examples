
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all Azure features
}

# Create a container app environment
resource "azurerm_container_app_environment" "example" {
  name                = "example-environment"
  location            = "westus2"
  resource_group_name = "example-resources"
  # Optional: Configure the Dapr integration
  dapr {
    enabled    = true
    placement  = "system"
  }
}

# Create a container app
resource "azurerm_container_app" "example" {
  name                = "example-app"
  location            = "westus2"
  resource_group_name = "example-resources"
  environment_name     = azurerm_container_app_environment.example.name
  # Define the container image
  image              = "mcr.microsoft.com/azuredocs/containerapps/sample"
  # Optional: Configure the container app scaling
  scale {
    min_replicas = 1
    max_replicas = 3
  }
  # Define the container app secrets
  secrets {
    name  = "SECRET_KEY"
    value = "YOUR_SECRET_VALUE"
  }
  # Optional: Configure the container app configuration
  configuration {
    replicas = 1
  }
  # Define the container app ingress
  ingress {
    target_port = 80
  }
}

  

    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

# Create a Container Instance
resource "azurerm_container_group" "example" {
  name                = "example-container-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type            = "Linux"
  # Define the container instance configuration
  containers {
    name  = "example-container"
    image = "mcr.microsoft.com/azuredocs/aci-helloworld"
    ports {
      port     = 80
      protocol = "tcp"
    }
    resources {
      requests {
        cpu = 1
        memory_in_gb = 1
      }
    }
  }
  # Configure the container instance networking
  ip_address {
    ports {
      port     = 80
      protocol = "tcp"
    }
  }
  # Configure the container instance logging
  logs {
    enabled = true
  }
  # Configure the container instance restart policy
  restart_policy = "Always"
}

  
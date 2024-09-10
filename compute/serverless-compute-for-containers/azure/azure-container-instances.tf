
    # Configure the Azure Provider
provider "azurerm" {
  features {} # This will automatically enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Create a container group
resource "azurerm_container_group" "example" {
  name                = "example-aci-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Define containers within the group
  container {
    name  = "my-app"
    image = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    # Add resources
    resources {
      requests {
        cpu    = "1"
        memory = "1Gi"
      }
    }
  }
  # Define the network configuration
  network_profile {
    # Use a public IP address
    ip_address {
      ports {
        port     = 80
        protocol = "tcp"
      }
    }
  }
}

  
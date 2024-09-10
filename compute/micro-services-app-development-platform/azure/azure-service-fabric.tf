
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features for the provider
}

# Create a Service Fabric cluster
resource "azurerm_service_fabric_cluster" "main" {
  name                = "my-service-fabric-cluster"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Define the cluster's application type
  application_type {
    name       = "myapptype"
    type       = "Stateless"
    version    = "1.0"
    description = "My application type"
  }

  # Configure the cluster's network settings
  network_settings {
    # Define the cluster's network profile
    network_profile {
      # Define the cluster's subnet
      subnet {
        id = azurerm_subnet.main.id # Reference the subnet resource
      }
    }
  }
}

# Create a subnet for the cluster
resource "azurerm_subnet" "main" {
  name                 = "my-subnet"
  resource_group_name = "my-resource-group"
  virtual_network_name = "my-virtual-network"
  address_prefixes     = ["10.0.0.0/24"]
}

# Create a service fabric application
resource "azurerm_service_fabric_application" "main" {
  name                = "myapp"
  resource_group_name = "my-resource-group"
  cluster_name        = azurerm_service_fabric_cluster.main.name
  application_type_name = "myapptype"
  version            = "1.0"
  # Define the application's service
  service {
    name     = "myservice"
    service_type = "Stateless"
    # Configure the service's replica settings
    replica_settings {
      min_replica_count = 1
      max_replica_count = 1
    }
  }
}

  
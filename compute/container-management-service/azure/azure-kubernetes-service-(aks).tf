
      # Configure o provedor Azure
provider "azurerm" {
  features {}  
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um cluster AKS
resource "azurerm_kubernetes_cluster" "example" {
  name                 = "example-aks"
  resource_group_name = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  dns_prefix           = "exampleaks"
  kubernetes_version  = "1.20.11"
  agent_pool {
    name                 = "agentpool"
    mode                 = "System"
    node_count           = 1
    vm_size              = "Standard_B2s"
    os_disk_size_gb      = 100
    vnet_subnet_id       = azurerm_subnet.example.id
    availability_zones   = ["1", "2"]
  }

  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin = "azure"
    service_cidr     = "10.240.0.0/16"
    dns_service_ip    = "10.240.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    load_balancer_sku  = "Standard"
    load_balancer_profile {
      effective_outbound_ports = "All"
    }
  }
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.240.0.0/16"]
}

# Crie uma sub-rede
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.240.0.0/24"]
}

    
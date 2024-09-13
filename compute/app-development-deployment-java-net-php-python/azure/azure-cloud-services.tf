
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use para habilitar recursos beta
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe" # Substitua pela região desejada
}

# Crie um serviço de nuvem
resource "azurerm_cloud_service" "example" {
  name     = "example-cs"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Crie um serviço de nuvem com uma instância web
resource "azurerm_cloud_service" "example" {
  name     = "example-cs"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  
  instance_source {
    os_image {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04-LTS"
      version   = "Latest"
    }
    size = "Standard_A2_v2"
  }
}

# Crie um serviço de nuvem com configurações personalizadas
resource "azurerm_cloud_service" "example" {
  name     = "example-cs"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  instance_source {
    os_image {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04-LTS"
      version   = "Latest"
    }
    size = "Standard_A2_v2"
  }
  
  configuration {
    os_type = "Linux"

    network_configuration {
      network_interface_configuration {
        name = "nic"
        
        ip_configuration {
          name = "ipconfig"
          
          subnet {
            name = "default"
            
            address_prefix = "10.0.0.0/24"
          }
        }
      }
    }
  }
}
    
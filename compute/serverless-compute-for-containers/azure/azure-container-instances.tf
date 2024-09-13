
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita recursos de pré-visualização
}

# Define a imagem do container
resource "azurerm_container_group" "aci" {
  name                = "aci-example"
  location            = "westus2"
  resource_group_name = "aci-rg"
  os_type             = "Linux"

  container {
    name  = "aci-app"
    image = "mcr.microsoft.com/azuredocs/aci-helloworld:v1"
  }

  # Define a rede para o grupo de contêineres
  network_profile {
    name                = "aci-network"
    dns_config {
      options = ["dns.google.com"]
    }
  }

  # Recursos do grupo de contêineres
  resource_requests {
    cpu          = 1
    memory_in_gb = 1
  }
}

    
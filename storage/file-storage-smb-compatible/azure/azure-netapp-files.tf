
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilita recursos mais recentes
}

# Crie um volume NetApp Files
resource "azurerm_netapp_volume" "example" {
  account_name   = "account-name" # Substitua pelo nome da conta NetApp
  capacity       = 1024 # Tamanho do volume em GiB
  location       = "location" # Substitua pela localização da conta NetApp
  resource_group = "resource-group-name" # Substitua pelo nome do grupo de recursos
  service_level  = "Standard" # Substitua pelo nível de serviço desejado
  subnet_id      = "subnet-id" # Substitua pelo ID da subnet
  volume_name     = "volume-name" # Substitua pelo nome do volume
}

    

      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Ensure latest features are enabled
}

# Crie um domínio do Azure Active Directory Domain Services
resource "azurerm_ad_domain_services" "example" {
  name                = "example-domain"
  location            = "westus2"
  resource_group_name = "example-resources"
  subnet_id           = "subnet-xxxxxxxx" # Substitua pelo ID da subnet
  # Opcional: Define as configurações do DNS
  # dns_configuration {
  #   suffix           = "corp.contoso.com"
  #   dns_forwarder_ip = ["10.0.0.1"]
  #   # Opcional: Especifica o servidor de DNS primário
  #   # primary_dns_server = "10.0.0.1"
  #   # Opcional: Especifica o servidor de DNS secundário
  #   # secondary_dns_server = "10.0.0.2"
  # }
}

    
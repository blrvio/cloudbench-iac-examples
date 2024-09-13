
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ativa recursos mais recentes
}

# Crie um Front Door
resource "azurerm_frontdoor" "example" {
  name                = "example-frontdoor"
  resource_group_name = "example-resource-group"
  location            = "westus2"

  frontend_endpoint {
    name             = "example-frontend"
    host_names      = ["example.com"] # Substitua pelos seus nomes de host
    session_affinity = "Enabled"

    # Defina regras de roteamento
    routing_rule {
      name = "example-routing-rule"

      # Encaminhe todo o tráfego para o backend
      forwarding_configuration {
        backend_pool_id = azurerm_frontdoor_backend_pool.example.id
      }
    }
  }
}

# Crie um grupo de backend
resource "azurerm_frontdoor_backend_pool" "example" {
  name                = "example-backend-pool"
  frontdoor_name     = azurerm_frontdoor.example.name
  resource_group_name = azurerm_frontdoor.example.resource_group_name

  # Defina backends para o grupo de backend
  backend {
    address = "192.168.0.1" # Substitua pelo endereço do seu backend
    # Adicione propriedades adicionais se necessário, como prioridade, peso, etc.
  }
}

# Crie um perfil de segurança de aplicação (WAF)
resource "azurerm_frontdoor_waf_policy" "example" {
  name                = "example-waf-policy"
  resource_group_name = "example-resource-group"
  location            = "westus2"

  # Defina regras de WAF
  rule {
    match_condition {
      # Defina regras de correspondência
      match_variable = "REQUEST_HEADERS"
      operator        = "Contains"
      selector        = "User-Agent"
      value           = "malware-bot"
    }
  }
}
    
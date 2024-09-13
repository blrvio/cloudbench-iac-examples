
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Substitua pelas suas funcionalidades
}

# Crie um Firewall Manager
resource "azurerm_firewall_manager" "example" {
  name                = "example-firewall-manager"
  location            = "West Europe"
  resource_group_name = "example-resources"

  # Defina as configurações do Firewall Manager
  # ...
}

# Crie uma política de Firewall Manager
resource "azurerm_firewall_manager_policy" "example" {
  name                = "example-firewall-manager-policy"
  location            = "West Europe"
  resource_group_name = "example-resources"
  firewall_manager_id = azurerm_firewall_manager.example.id

  # Defina as configurações da política
  # ...
}

# Crie uma regra de política do Firewall Manager
resource "azurerm_firewall_manager_policy_rule" "example" {
  name                = "example-firewall-manager-policy-rule"
  policy_id          = azurerm_firewall_manager_policy.example.id
  priority            = 100
  action              = "Allow"
  protocol            = "TCP"
  source_addresses    = ["10.0.0.0/16"]
  destination_addresses = ["192.168.0.0/16"]
  source_ports        = ["80"]
  destination_ports    = ["80"]
  # ...
}
    
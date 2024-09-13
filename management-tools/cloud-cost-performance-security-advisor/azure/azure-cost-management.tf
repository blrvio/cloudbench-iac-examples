
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita os recursos mais recentes
}

# Crie um grupo de custos
resource "azurerm_cost_management_group" "example" {
  name     = "example-cost-group"
  display_name = "Example Cost Group"
  scope    = "subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitua pela sua assinatura
}

# Crie uma regra de alerta de custos
resource "azurerm_cost_management_alert" "example" {
  name     = "example-alert"
  scope    = "subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitua pela sua assinatura
  display_name = "Example Alert"
  enabled = true
  time_period = "MonthToDate"
  threshold = 100
  operator = "GreaterThan"

  filter {
    type = "Dimension"
    name = "ResourceGroup"
    values = ["example-resource-group"]
  }
}

    
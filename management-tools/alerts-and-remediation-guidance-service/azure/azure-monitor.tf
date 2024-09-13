
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Garante que as últimas funcionalidades estejam disponíveis
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Crie uma conta de Log Analytics
resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-workspace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                  = "Free"
}

# Crie uma regra de alerta
resource "azurerm_monitor_alert_rule" "example" {
  name                = "example-alert"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  workspace_name       = azurerm_log_analytics_workspace.example.name
  description         = "Exemplo de regra de alerta"
  enabled              = true
  condition {
    window_size              = "PT1M"
    time_aggregation         = "Average"
    operator                = "GreaterThan"
    threshold                = 10
    metric_namespace        = "Microsoft.Compute/virtualMachines"
    metric_name            = "PercentageCPU"
    dimension_name_value_pairs {
      name  = "ResourceGroupName"
      value = azurerm_resource_group.example.name
    }
  }
  actions {
    action_group_name = "example-action-group"
    # Configure o grupo de ações aqui
  }
}

    
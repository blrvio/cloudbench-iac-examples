
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilita recursos beta
}

# Crie um workspace do Azure Operational Insights
resource "azurerm_operational_insights_workspace" "main" {
  name                = "my-workspace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  sku                  = "per_gb"
  retention_in_days   = 30 # Define a retenção de dados em dias
}

# Configure um agente do Log Analytics para coletar dados de uma VM
resource "azurerm_log_analytics_workspace_agent" "main" {
  workspace_id = azurerm_operational_insights_workspace.main.id
  vm_id = "vm-id" # Substitua pelo ID da VM
  workspace_name = azurerm_operational_insights_workspace.main.name
}

    
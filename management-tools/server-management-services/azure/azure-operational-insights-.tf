
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Log Analytics workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "my-log-analytics-workspace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Optional settings
  retention_in_days   = 30
  # Enable data ingestion from other Azure services
  data_sources {    
    # Enable Azure Activity Log
    activity_log { 
      enabled = true
    }
    # Enable Azure Audit Logs
    azure_audit_logs { 
      enabled = true
    }
  }
}

# Create a Log Analytics workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "my-log-analytics-workspace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Optional settings
  retention_in_days   = 30
  # Enable data ingestion from other Azure services
  data_sources {    
    # Enable Azure Activity Log
    activity_log { 
      enabled = true
    }
    # Enable Azure Audit Logs
    azure_audit_logs { 
      enabled = true
    }
  }
}

# Create a Log Analytics solution
resource "azurerm_log_analytics_solution" "main" {
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_name      = azurerm_log_analytics_workspace.main.name
  solution_name        = "my-log-analytics-solution"
  # You can add multiple solutions here, 
  # based on your monitoring requirements
  solution_definition_id = "microsoft.operationalinsights/solutions/securityinsights"
}

# Create a Log Analytics shared key
resource "azurerm_log_analytics_workspace_shared_key" "main" {
  workspace_name      = azurerm_log_analytics_workspace.main.name
  resource_group_name = "my-resource-group"
}

  
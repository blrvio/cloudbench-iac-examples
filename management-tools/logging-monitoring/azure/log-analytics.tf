
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  location          = "westus2"
  name              = "my-log-analytics-workspace"
  resource_group_name = "my-resource-group"
  # Optional settings
  retention_in_days = 30
  # For paid tiers, set pricing_tier to "Premium"
  pricing_tier      = "PerGB"
  # Configure the workspace retention policies
  retention_policies {
    retention_time_in_days = 30
    category             = "Logs"
    # For paid tiers, you can enable the ingestion policies
    # ingestion_policies {
    #   # Configure the ingestion policy
    #   # ingestion_policies = ["Default", "Limited", "Disabled"]
    # }
  }
}

# Create a Log Analytics Workspace Shared Key
resource "azurerm_log_analytics_workspace_shared_key" "main" {
  workspace_id = azurerm_log_analytics_workspace.main.id
  # You can get the workspace ID from the Log Analytics workspace resource
}

# Create a Log Analytics Solution
resource "azurerm_log_analytics_solution" "main" {
  workspace_id     = azurerm_log_analytics_workspace.main.id
  solution_id        = "Microsoft.OperationalInsights/solutions/LogAnalyticsAgent"
  solution_type      = "LogAnalyticsAgent"
  # You can configure additional settings as needed
}

  
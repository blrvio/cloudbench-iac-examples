
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Ensure you have all the latest AzureRM features enabled
}

# Create an Azure Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "my-log-analytics-workspace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Set up retention policies for data in the workspace
  retention_in_days = 365
  # Enable the agent to collect data from your VMs
  agent_enabled = true
  # Specify the pricing tier for the workspace
  sku {
    name = "PerGB2018"
  }
}

# Create a Log Analytics Solution
resource "azurerm_log_analytics_solution" "main" {
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_id        = azurerm_log_analytics_workspace.main.id
  solution_name       = "SecurityCenter"
  # Ensure the solution is enabled
  enabled = true
  # Optionally, you can specify the plan
  # plan = "Free"
}

# Create a Log Analytics Workspace Connection to connect the workspace to another resource
resource "azurerm_log_analytics_workspace_connection" "main" {
  name                = "my-workspace-connection"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_id        = azurerm_log_analytics_workspace.main.id
  # Configure the connection properties
  workspace_connection_properties {
    type = "AzureMonitor"
    # Set up a connection to an Azure resource
    # azure_monitor_resource {
    #  resource_group_name = "my-resource-group"
    #  resource_type       = "Microsoft.Compute/virtualMachines"
    #  resource_name        = "my-vm"
    # }
  }
}

# Create a Log Analytics Query (Optional)
# resource "azurerm_log_analytics_query" "main" {
#  workspace_id = azurerm_log_analytics_workspace.main.id
#  query         = "let timeFrame = ago(7d); LogEvents | where TimeGenerated >= timeFrame | summarize count() by Category | render piechart"
#  name          = "My Query"
# }

  
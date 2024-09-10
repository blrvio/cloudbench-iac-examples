
    # Configure the Azure Provider
provider "azurerm" {
  features {} 
}

# Create a Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "example" {
  location             = "westus2"
  name                 = "example-log-analytics-workspace"
  resource_group_name = "example-resource-group"
  # Specify if the workspace is a dedicated workspace. Default is false.
  dedicated = false
  # Specify the retention policy (in days) for data in the workspace. Default is 730 days.
  retention_in_days   = 730
}

# Create an Azure Log Analytics Application Insights Extension
resource "azurerm_monitor_application_insights_extension" "example" {
  name                 = "example-extension"
  resource_group_name = "example-resource-group"
  location             = "westus2"
  application_insights_id = azurerm_application_insights.example.id
  resource_type = "virtualMachine"
  resource_name = "example-vm"
  # Set a time series sampling percentage for collected data, for example 10 would collect 10% of data. Default is 100.
  sampling_percentage = 10
}

# Create an Application Insights resource
resource "azurerm_application_insights" "example" {
  name                 = "example-application-insights"
  resource_group_name = "example-resource-group"
  location             = "westus2"
  # Enable the ingestion of data from Azure Monitor for VMs.
  # This will enable the collection of performance metrics, logs, and events.
  # from the virtual machines.
  vm_ingestion = true
  # The Application Insights component can be enabled for the Azure Monitor for VMs solution to automatically collect metrics, logs and events from your VMs.
  # To disable the ingestion of data from Azure Monitor for VMs, set this to false. Default is true.
  vm_ingestion = true
}
  

    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Automation Account
resource "azurerm_automation_account" "example" {
  name                = "my-automation-account"
  location             = "westus2"
  resource_group_name = "my-resource-group"
  sku                 = "Basic"
}

# Create an Azure Automation Runbook
resource "azurerm_automation_runbook" "example" {
  name                = "my-runbook"
  location             = "westus2"
  resource_group_name = "my-resource-group"
  automation_account_name = azurerm_automation_account.example.name
  runbook_type        = "PowerShell"
  # Add the PowerShell script content of the runbook
  script = "Write-Output "Hello from Azure Automation!""
  # Optionally, set runbook log level
  log_verbose         = false
}

  
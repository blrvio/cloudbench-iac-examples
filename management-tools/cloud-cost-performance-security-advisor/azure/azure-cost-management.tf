
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Use this to enable new features in this provider
}

# Create a Cost Management Budget
resource "azurerm_cost_management_budget" "example" {
  name                = "example-cost-management-budget"
  time_grain          = "Monthly"
  time_period_end     = "2023-12-31"
  time_period_start    = "2023-01-01"
  filter              = "ResourceGroup == 'example-resource-group'"
  amount              = 1000
  budget_threshold_type = "Actual"
  notification_type    = "Email"
  notification_recipients = [
    "user@example.com"
  ]
  resource_group_name = "example-resource-group"
}

  
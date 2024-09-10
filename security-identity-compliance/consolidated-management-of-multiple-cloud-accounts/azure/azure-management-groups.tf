
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Management Group
resource "azurerm_management_group" "example" {
  name     = "MyManagementGroup"
  parent_id = "root"
}

# Create a Subscription under the Management Group
resource "azurerm_subscription" "example" {
  display_name = "MySubscription"
  management_group_id = azurerm_management_group.example.id
  location = "westus"
}

  
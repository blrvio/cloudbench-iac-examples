
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group for your Azure Virtual Desktop resources
resource "azurerm_resource_group" "example" {
  name     = "rg-azure-virtual-desktop"
  location = "westus2"
}

# Create an Azure Virtual Desktop host pool
resource "azurerm_virtual_desktop_host_pool" "example" {
  name             = "my-host-pool"
  location         = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Additional options for the host pool can be added here
}

# Create an Azure Virtual Desktop workspace
resource "azurerm_virtual_desktop_workspace" "example" {
  name             = "my-workspace"
  location         = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Additional options for the workspace can be added here
}

# Create an Azure Virtual Desktop application group
resource "azurerm_virtual_desktop_application_group" "example" {
  name             = "my-app-group"
  location         = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Additional options for the application group can be added here
}

# Associate the application group to the host pool
resource "azurerm_virtual_desktop_application_group_assignment" "example" {
  application_group_id = azurerm_virtual_desktop_application_group.example.id
  host_pool_id          = azurerm_virtual_desktop_host_pool.example.id
  # Additional options for the assignment can be added here
}

# Associate the workspace to the application group
resource "azurerm_virtual_desktop_workspace_application_group_assignment" "example" {
  application_group_id = azurerm_virtual_desktop_application_group.example.id
  workspace_id          = azurerm_virtual_desktop_workspace.example.id
  # Additional options for the assignment can be added here
}

  
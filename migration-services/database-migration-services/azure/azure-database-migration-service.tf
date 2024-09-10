
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "eastus"
}

# Create a database migration service
resource "azurerm_dms_instance" "main" {
  name     = "my-dms-instance"
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  sku {
    name = "Standard"
  }
}

# Create a database migration project
resource "azurerm_dms_project" "main" {
  name               = "my-dms-project"
  resource_group_name = azurerm_resource_group.main.name
  source_platform     = "SQLServer"
  target_platform     = "PostgreSQL"
  dms_instance_name  = azurerm_dms_instance.main.name
}

# Create a database migration task
resource "azurerm_dms_task" "main" {
  name               = "my-dms-task"
  resource_group_name = azurerm_resource_group.main.name
  project_name        = azurerm_dms_project.main.name
  source_connection_id = azurerm_dms_connection.source.id
  target_connection_id = azurerm_dms_connection.target.id
  source_database_name   = "my-source-database"
  target_database_name   = "my-target-database"
  # ... add more task configuration options here ...
}

# Create a source connection
resource "azurerm_dms_connection" "source" {
  name               = "my-source-connection"
  resource_group_name = azurerm_resource_group.main.name
  connection_type      = "Source"
  # ... add more connection configuration options here ...
}

# Create a target connection
resource "azurerm_dms_connection" "target" {
  name               = "my-target-connection"
  resource_group_name = azurerm_resource_group.main.name
  connection_type      = "Target"
  # ... add more connection configuration options here ...
}

  
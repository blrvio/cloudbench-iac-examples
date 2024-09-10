
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure DevOps organization
resource "azurerm_devops_organization" "example" {
  name     = "my-org"
  location = "eastus"
  # Set up the organization with basic features.
  features {    # Enable Boards
    boards = true    # Enable Pipelines
    pipelines = true
  }
}

# Create a project in the organization
resource "azurerm_devops_project" "example" {
  organization_id = azurerm_devops_organization.example.id
  name           = "my-project"
  # The project is using the default process
  # This will create a project with a basic set of features
  visibility = "private"
}

# Create a sprint in the project
resource "azurerm_devops_sprint" "example" {
  project_id = azurerm_devops_project.example.id
  name       = "sprint-1"
  # Set the start and end date for the sprint.
  start_date = "2024-02-19"
  end_date   = "2024-03-04"
}

# Create a backlog in the project
resource "azurerm_devops_backlog" "example" {
  project_id = azurerm_devops_project.example.id
  name       = "product-backlog"
  # Set the backlog type.
  type        = "product"
  # Set the backlog level.
  level = "epic"
  # Add a backlog item
  items {
    path   = "product-backlog"
    work_item_type = "user story"
    title       = "Implement Feature X"
  }
}

  
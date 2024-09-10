
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure DevOps Project
resource "azurerm_devops_project" "main" {
  name     = "my-test-project"
  visibility = "private"
}

# Create a Test Plan
resource "azurerm_devops_test_plan" "main" {
  project_id = azurerm_devops_project.main.id
  name       = "my-test-plan"
}

# Create a Test Suite
resource "azurerm_devops_test_suite" "main" {
  project_id = azurerm_devops_project.main.id
  plan_id    = azurerm_devops_test_plan.main.id
  name       = "my-test-suite"
}

# Create a Test Case
resource "azurerm_devops_test_case" "main" {
  project_id = azurerm_devops_project.main.id
  suite_id    = azurerm_devops_test_suite.main.id
  name       = "my-test-case"
  # Define the steps of the test case
  steps = [
    {
      action     = "Navigate to a web page"
      arguments = "https://www.example.com"
    },
    {
      action     = "Click a button"
      arguments = "Login"
    },
    {
      action     = "Verify text"
      arguments = "Welcome, user"
    }
  ]
}
  
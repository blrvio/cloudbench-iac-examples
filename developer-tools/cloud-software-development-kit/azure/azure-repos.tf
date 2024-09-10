
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure DevOps Project
resource "azurerm_devops_project" "main" {
  name = "my-devops-project"
  visibility = "private" # Set project visibility
}

# Create a Git repository within the Azure DevOps Project
resource "azurerm_devops_git_repository" "main" {
  project_id = azurerm_devops_project.main.id
  name = "my-git-repo"
}

  
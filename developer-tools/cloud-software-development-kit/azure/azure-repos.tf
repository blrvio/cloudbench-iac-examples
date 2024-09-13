
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita recursos beta
}

# Crie um projeto Azure DevOps
resource "azurerm_devops_project" "example" {
  name     = "example-project"
  visibility = "private"
  version_control = "Git"
}

# Crie um repositório Git
resource "azurerm_devops_git_repository" "example" {
  project_id = azurerm_devops_project.example.id
  name       = "example-repo"
}

    
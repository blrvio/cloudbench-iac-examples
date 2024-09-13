
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Opções de recursos do provedor
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um projeto Azure DevOps
resource "azurerm_devops_project" "example" {
  name      = "example-project"
  visibility = "private"
  location  = "westus2"
  resource_group_name = azurerm_resource_group.example.name
}

# Crie um feed Azure Artifacts
resource "azurerm_devops_feed" "example" {
  name          = "example-feed"
  project_id = azurerm_devops_project.example.id
  description  = "My example feed"
  visibility   = "private"
}

# Defina as permissões do feed
resource "azurerm_devops_feed_permission" "example" {
  feed_id = azurerm_devops_feed.example.id
  identity_descriptor = "{principalName}"
  access_level = "Contribute"
  permissions = ["View", "Contribute", "Manage"]
}

# Crie uma pipeline YAML
resource "azurerm_devops_pipeline" "example" {
  project_id = azurerm_devops_project.example.id
  name = "example-pipeline"
  yaml = <<YAML
  trigger: none # Ativar a pipeline manualmente
  stages:
    - stage: Build
      jobs:
        - job: Build
          steps:
            - task: NuGetToolInstaller@2 # Instalar as ferramentas do NuGet
              inputs:
                version: '4.x' # Versão do NuGet
            - task: NuGetAuthenticate@2 # Autenticação no feed
              inputs:
                feed: "example-feed" # Nome do feed
                scope: "project"
            - task: NuGetCommand@2 # Executar um comando do NuGet
              inputs:
                command: "restore"
                restoreSolution: "example.sln"
  YAML
}

    
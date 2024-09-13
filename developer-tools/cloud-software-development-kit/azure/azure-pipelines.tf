
      terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {} # Disable features to avoid breaking changes
}

# Create a variable for the resource group
variable "resource_group_name" {
  default = "my-resource-group"
}

# Create a variable for the project name
variable "project_name" {
  default = "my-project"
}

# Create a variable for the pipeline YAML content
variable "pipeline_yaml" {
  default = "trigger: none
pool: {
  vmImage: 'ubuntu-latest'
}
jobs: 
  - job: 'build'
    steps: 
      - script: echo Hello World
        displayName: 'Run a simple script'"
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = "westus2"
}

# Create an Azure DevOps project
resource "azurerm_devops_project" "example" {
  name                = var.project_name
  visibility          = "private"
  version_control_type = "Git"
  resource_group_name = azurerm_resource_group.example.name
}

# Create a pipeline
resource "azurerm_devops_pipeline" "example" {
  name                = "my-pipeline"
  project_id         = azurerm_devops_project.example.id
  yaml                = var.pipeline_yaml
  variables           = {}
  trigger             = "none"
  auto_cancel_running = true
}

    
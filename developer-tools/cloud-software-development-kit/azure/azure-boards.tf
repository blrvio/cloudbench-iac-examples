
      terraform {  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {} # Configure features here
}

resource "azurerm_devops_project" "example" {
  name                = "example-project"
  visibility          = "private"
  version_control      = "git"
  process_template_id = "tfs/DefaultProcess/1"
  # ... other configuration options
}
    
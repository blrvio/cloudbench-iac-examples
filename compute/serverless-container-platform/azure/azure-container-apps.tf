
      terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {} # Remove this once you start using features
}

resource "azurerm_container_app" "example" {
  name                = "example-container-app"
  location            = "westus2"
  resource_group_name = "example-resources"
  container {
    image = "mcr.microsoft.com/azuredocs/containerapps/python-sample:v1"
  }
  scale {
    min_replicas = 1
    max_replicas = 1
  }
  revision_template {
    containers {
      name          = "container1"
      image         = "mcr.microsoft.com/azuredocs/containerapps/python-sample:v1"
      resources {
        cpu = "1"
        memory = "1Gi"
      }
    }
  }
}


    
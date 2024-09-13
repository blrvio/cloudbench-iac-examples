
      terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {} # Configure as needed
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe" # Replace with your desired location
}

resource "azurerm_app_service_plan" "example" {
  name     = "example-plan"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier    = "Free"
    size     = "F1"
  }
}

resource "azurerm_app_service" "example" {
  name                 = "example-app"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}

    
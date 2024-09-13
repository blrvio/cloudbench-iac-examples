
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use as últimas funcionalidades
}

# Crie um ambiente de App Service
resource "azurerm_app_service_environment" "ase" {
  name = "ase-example"
  location = "westus2" # Substitua pela região desejada
  resource_group_name = "resource-group-name" # Substitua pelo nome do grupo de recursos

  sku {
    tier = "Isolated"
  }
}

# Crie um plano de App Service
resource "azurerm_app_service_plan" "plan" {
  name = "app-service-plan"
  location = "westus2" # Substitua pela região desejada
  resource_group_name = "resource-group-name" # Substitua pelo nome do grupo de recursos
  kind = "app,function"
  sku {
    tier = "Free"
    size = "S1"
  }
  app_service_environment_id = azurerm_app_service_environment.ase.id
}

# Crie uma aplicação web
resource "azurerm_app_service" "web_app" {
  name = "web-app"
  location = "westus2" # Substitua pela região desejada
  resource_group_name = "resource-group-name" # Substitua pelo nome do grupo de recursos
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

    

      ## Configure o provedor do Azure
provider "azurerm" {
  features {} # Define as features desejadas
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um aplicativo no App Center
resource "azurerm_appcenter_app" "example" {
  name          = "example-app"
  resource_group = azurerm_resource_group.example.name
  platform      = "ios"
}

# Crie um pipeline no App Center
resource "azurerm_appcenter_build_pipeline" "example" {
  name          = "example-pipeline"
  app_name      = azurerm_appcenter_app.example.name
  resource_group = azurerm_resource_group.example.name
  platform      = "ios"
}

# Configure o pipeline
# ...

# Crie um branch para o pipeline
resource "azurerm_appcenter_branch" "example" {
  name          = "main"
  pipeline_name = azurerm_appcenter_build_pipeline.example.name
  app_name      = azurerm_appcenter_app.example.name
  resource_group = azurerm_resource_group.example.name
}

# Crie um build no App Center
resource "azurerm_appcenter_build" "example" {
  branch_name   = azurerm_appcenter_branch.example.name
  pipeline_name = azurerm_appcenter_build_pipeline.example.name
  app_name      = azurerm_appcenter_app.example.name
  resource_group = azurerm_resource_group.example.name
}

# Configure o build
# ...
    
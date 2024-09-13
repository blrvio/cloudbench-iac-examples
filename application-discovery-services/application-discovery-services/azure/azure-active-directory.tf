
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Para usar recursos mais recentes
}

# Crie um novo grupo de segurança
resource "azurerm_group" "example" {
  location = "westus2"
  name     = "example-group"
  resource_group_name = "example-resources"
}

# Crie um usuário no Azure Active Directory
resource "azurerm_ad_user" "example" {
  display_name = "example user"
  first_name  = "example"
  last_name   = "user"
  password     = "P@$$wOrd"
  user_principal_name = "exampleuser@example.onmicrosoft.com"
  group_ids     = [azurerm_group.example.id]
}

# Atribui um aplicativo ao grupo
resource "azurerm_group_member" "example" {
  group_object_id = azurerm_group.example.id
  member_object_id = "guid-of-application-service-principal"
}

    
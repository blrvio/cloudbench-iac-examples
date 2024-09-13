
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use as features necessárias
}

# Crie um grupo de usuários
resource "azurerm_ad_group" "example_group" {
  name = "example_group"
  display_name = "Example Group"
  description = "A sample group"
  object_id = "example_group_object_id"
  security_enabled = true
  mail_enabled = false
  visibility = "Private"
  location = "global"
  # ... outros parâmetros
}

# Crie um usuário
resource "azurerm_ad_user" "example_user" {
  display_name = "Example User"
  user_principal_name = "example_user@example.com"
  password = "example_password"
  # ... outros parâmetros
  account_enabled = true
  # ... outros parâmetros
}

# Adicione o usuário ao grupo
resource "azurerm_ad_group_member" "example_user_in_group" {
  group_object_id = azurerm_ad_group.example_group.object_id
  member_object_id = azurerm_ad_user.example_user.object_id
  # ... outros parâmetros
}
    
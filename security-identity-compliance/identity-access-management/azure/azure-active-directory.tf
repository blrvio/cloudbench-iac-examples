
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ativa recursos adicionais
}

# Crie um grupo de segurança
resource "azurerm_active_directory_group" "example_group" {
  display_name = "Example Group"
  description = "Um grupo de exemplo"
  # Supressão da long string 'tenant_id' 
}

# Crie um usuário no grupo de segurança
resource "azurerm_active_directory_user" "example_user" {
  display_name = "Example User"
  # Supressão de long string 'user_principal_name'
  # Supressão de long string 'password'
  # Supressão de long string 'tenant_id'
}

resource "azurerm_active_directory_group_member" "example_group_member" {
  group_object_id = azurerm_active_directory_group.example_group.object_id
  member_object_id = azurerm_active_directory_user.example_user.object_id
}
    
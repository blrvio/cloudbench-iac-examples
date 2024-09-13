
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Adicione as funcionalidades necessárias do Azure
}

# Crie um tenant do Azure Active Directory B2C
resource "azurerm_ad_b2c_tenant" "example" {
  name     = "b2c-tenant-example"
  location = "westus2"
}

# Crie uma política de inscrição de usuário
resource "azurerm_ad_b2c_user_flow" "signup_signin" {
  name           = "signup_signin"
  display_name   = "Sign Up/Sign In"
  tenant_id      = azurerm_ad_b2c_tenant.example.id
  user_flow_type = "SignUpSignIn"
}

# Crie uma política de redefinição de senha
resource "azurerm_ad_b2c_user_flow" "password_reset" {
  name           = "password_reset"
  display_name   = "Password Reset"
  tenant_id      = azurerm_ad_b2c_tenant.example.id
  user_flow_type = "PasswordReset"
}

# Crie uma política de perfil de usuário
resource "azurerm_ad_b2c_user_flow" "profile_editing" {
  name           = "profile_editing"
  display_name   = "Profile Editing"
  tenant_id      = azurerm_ad_b2c_tenant.example.id
  user_flow_type = "ProfileEditing"
}
    
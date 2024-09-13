
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Ative as funcionalidades do Azure
}

# Crie um tenant do Azure Active Directory B2C
resource "azurerm_active_directory_b2c_tenant" "example" {
  name     = "example"
  location = "westus"
}

# Crie um pool de identidade do Azure Active Directory B2C
resource "azurerm_active_directory_b2c_identity_provider" "example" {
  name               = "example"
  tenant_id          = azurerm_active_directory_b2c_tenant.example.id
  identity_provider   = "google"
  client_id         = "YOUR_CLIENT_ID"
  client_secret      = "YOUR_CLIENT_SECRET"
  client_credentials = true
}

# Crie uma política de inscrição do Azure Active Directory B2C
resource "azurerm_active_directory_b2c_user_flow" "example" {
  name      = "example"
  tenant_id = azurerm_active_directory_b2c_tenant.example.id

  user_attribute_assignment {
    attribute = "displayName"
    display_name = "Nome de Exibição"
    is_optional  = false
  }

  user_attribute_assignment {
    attribute = "givenName"
    display_name = "Nome"
    is_optional  = false
  }

  user_attribute_assignment {
    attribute = "surname"
    display_name = "Sobrenome"
    is_optional  = false
  }

  user_attribute_assignment {
    attribute = "email"
    display_name = "Email"
    is_optional  = false
  }

  user_attribute_assignment {
    attribute = "password"
    display_name = "Senha"
    is_optional  = false
  }
}

    
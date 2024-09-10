
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Active Directory B2C tenant
resource "azurerm_ad_b2c_tenant" "main" {
  name     = "my-b2c-tenant"
  location = "westus2" # Replace with your desired location
}

# Create an Azure Active Directory B2C user flow
resource "azurerm_ad_b2c_user_flow" "signup_signin" {
  name              = "signup_signin"
  tenant_id          = azurerm_ad_b2c_tenant.main.id
  display_name       = "Sign up and Sign In"
  user_flow_type      = "SignUpSignIn"
  language_extensions = ["en-US"]

  # Define the identity providers for sign in
  identity_providers {
    local_account {
    }
    # You can add additional identity providers such as social media
  }

  # Define the user attributes to collect during sign up
  user_attributes {
    display_name  = true
    email         = true
  }
}

# Create an Azure Active Directory B2C application
resource "azurerm_ad_b2c_application" "main" {
  name        = "my-b2c-app"
  tenant_id    = azurerm_ad_b2c_tenant.main.id
  client_type = "spa" # Single-page application type
}

  
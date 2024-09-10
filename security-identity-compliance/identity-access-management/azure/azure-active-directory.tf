
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Active Directory Application
resource "azurerm_ad_application" "example" {
  name     = "example-application"
  display_name  = "Example Application"
  # Optionally specify a group object id for a default group to be assigned to the application
  # group_object_id = "<GROUP OBJECT ID>"

  # Define the application's sign-in and sign-out behavior
  sign_in_audience = "AzureADMyOrg"
  # Optional, specify an API permission for the application
  # api_permission {  
  #   value = "<API PERMISSION>"
  # }

  # Optional, configure a web application
  # web {
  #   logout_redirect_uri = "<LOGOUT REDIRECT URI>"
  #   redirect_uris = [ "<REDIRECT URI>"]
  #   # Required for native clients
  #   reply_urls = ["<REPLY URL>"]
  # }

  # Optional, configure a native application
  # native_client {
  #   # Required for native clients
  #   reply_urls = ["<REPLY URL>"]
  # }
}

# Create an Azure Active Directory Service Principal
resource "azurerm_ad_service_principal" "example" {
  application_id = azurerm_ad_application.example.application_id
}

# Create an Azure Active Directory Role Assignment
resource "azurerm_ad_role_assignment" "example" {
  principal_id = azurerm_ad_service_principal.example.object_id
  # Define the role to be assigned
  role_definition_id = "<ROLE DEFINITION ID>"
  scope              = "<SCOPE>"
}

  
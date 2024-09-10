
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Use the latest AzureRM features
}

# Create an Azure Active Directory Application
resource "azurerm_ad_application" "main" {
  name     = "my-azure-ad-app"
  display_name = "My Azure AD App"
  # Optionally define a group that can be assigned to the application
  # group_object_id = azurerm_ad_group.main.object_id
  # Optionally define the application's home page URL
  # homepage = "https://www.example.com"
  # Optionally define the application's sign-on URL
  # sign_on_url = "https://www.example.com/signon"
  # Optionally define the application's identifier URI
  # identifier_uris = ["https://www.example.com/api"]
  # Optionally define the application's reply URLs
  # reply_urls = ["https://www.example.com/callback"]
}

# (Optional) Create an Azure Active Directory Group
# resource "azurerm_ad_group" "main" {
#   name = "my-azure-ad-group"
#   display_name = "My Azure AD Group"
#   # Optionally define the group's description
#   # description = "My Azure AD Group Description"
#   # Optionally define the group's security enabled property
#   # security_enabled = true
# }

# Create an Azure Active Directory Service Principal
resource "azurerm_service_principal" "main" {
  application_id = azurerm_ad_application.main.application_id
  # Optionally define a group that can be assigned to the service principal
  # group_object_id = azurerm_ad_group.main.object_id
}

# (Optional) Assign Application Roles to the Service Principal
# resource "azurerm_role_assignment" "main" {
#   scope            = "my-resource-group"
#   role_definition_id = "b24988ac-6180-42a0-ab88-84f7dc0f8243" # "Contributor" role
#   principal_id      = azurerm_service_principal.main.id
# }

  
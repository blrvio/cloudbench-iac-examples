
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Cognitive Services Account
resource "azurerm_cognitive_services_account" "main" {
  name                = "my-speaker-recognition-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  kind                = "speech"
  sku {
    name = "S0"
  }
}

# Create a Speaker Recognition Model
resource "azurerm_cognitive_services_speaker_recognition_model" "main" {
  name                     = "my-speaker-recognition-model"
  location                 = "westus2"
  resource_group_name     = "my-resource-group"
  cognitive_services_account_name = azurerm_cognitive_services_account.main.name
  # Optional: Add custom model configuration
}

# Create a Speaker Enrollment Profile
resource "azurerm_cognitive_services_speaker_recognition_enrollment_profile" "main" {
  name                     = "my-enrollment-profile"
  location                 = "westus2"
  resource_group_name     = "my-resource-group"
  cognitive_services_account_name = azurerm_cognitive_services_account.main.name
  model_name                = azurerm_cognitive_services_speaker_recognition_model.main.name
  # Optional: Add custom profile configuration
}

# Create a Speaker Verification Profile
resource "azurerm_cognitive_services_speaker_recognition_verification_profile" "main" {
  name                     = "my-verification-profile"
  location                 = "westus2"
  resource_group_name     = "my-resource-group"
  cognitive_services_account_name = azurerm_cognitive_services_account.main.name
  model_name                = azurerm_cognitive_services_speaker_recognition_model.main.name
  # Optional: Add custom profile configuration
}

  
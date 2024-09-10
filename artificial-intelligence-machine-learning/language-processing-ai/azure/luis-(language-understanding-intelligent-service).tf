
    # Configure the AzureRM provider
provider "azurerm" {
  features {} # Use the latest features
}

# Create a LUIS authoring resource
resource "azurerm_cognitive_services_account" "luis" {
  name                = "my-luis-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  kind                = "luis"
  sku {
    name = "F0"
  }
  # Optional settings
  # tags                  = {
  #   Environment = "Dev"
  # }
}

# Create a LUIS app
resource "azurerm_luis_authoring_app" "main" {
  name                  = "my-luis-app"
  location              = "westus2"
  resource_group_name   = "my-resource-group"
  cognitive_services_id = azurerm_cognitive_services_account.luis.id
  # Optional settings
  # culture               = "en-us"
  # version               = "0.1"
  # description            = "My LUIS app"
}

# Create a LUIS intent
resource "azurerm_luis_intent" "main" {
  app_id         = azurerm_luis_authoring_app.main.id
  name           = "BookFlight"
  version        = "0.1"
  # Optional settings
  # description    = "Book a flight intent"
  # is_closed      = true
  # example_utterances = ["book a flight to london","find me a flight to paris"]
}

# Create a LUIS entity
resource "azurerm_luis_entity" "main" {
  app_id         = azurerm_luis_authoring_app.main.id
  name           = "City"
  version        = "0.1"
  # Optional settings
  # description    = "City entity"
  # is_closed      = false
  # example_utterances = ["london","paris","new york"]
}

# Create a LUIS utterance example
resource "azurerm_luis_utterance_example" "main" {
  app_id         = azurerm_luis_authoring_app.main.id
  intent_name   = azurerm_luis_intent.main.name
  text           = "Book a flight to london"
  version        = "0.1"
  # Optional settings
  # entity_labels = [{
  #   entity_name = "City"
  #   start        = 18
  #   end          = 24
  # }]
}

  
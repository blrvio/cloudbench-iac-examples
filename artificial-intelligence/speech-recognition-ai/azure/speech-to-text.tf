
    resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

resource "azurerm_cognitive_services_account" "example" {
  name                = "example-account"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "speech"
  sku {
    name = "S0"
  }
  # For more information on the `api_keys` block see:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_services_account#api_keys
  # api_keys {
  #   # ...
  # }
  # For more information on the `endpoints` block see:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_services_account#endpoints
  # endpoints {
  #   # ...
  # }
}

  
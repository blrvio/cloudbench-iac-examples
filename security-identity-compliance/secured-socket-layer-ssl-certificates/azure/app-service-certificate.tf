
    # Configure the AzureRM Provider
provider "azurerm" {
  features {} # Enable all Azure features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create an App Service Certificate
resource "azurerm_app_service_certificate" "example" {
  name                = "example-certificate"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  # Replace with your valid certificate content
  certificate_content  = "-----BEGIN CERTIFICATE-----
MIIDGTCCAgGgAwIBAgIRAJ9nB4pN2F6l0/n8h+7wDwDQYJKoZIhvcNAQELBQAw
EjEQMA4GA1UEChMHQWNtZSBDbzAgFw0yMjA5MjAyMDM1MzlaGA8yMzAyMDky
MDIwMzU2OVowEjEQMA4GA1UEChMHQWNtZSBDbzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBANuZq59/mQ533kO5zQ2zY3M1V1H5Lh/p033Q+3R/pK753T6D/k
37D43uJ+nN5t8/7i+h/sL+q/0780H5v+V/6H+47/M/yD/s/8L/P/8A/tP/D/wD
6P/D/8D/x/8P/g//w==
-----END CERTIFICATE-----"
}

  
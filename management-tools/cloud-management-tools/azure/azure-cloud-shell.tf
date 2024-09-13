
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Certifique-se de ter as credenciais configuradas
}

# Crie um recurso de Cloud Shell
resource "azurerm_cloud_shell" "example" {
  name = "my-cloud-shell"
  location = "westus2" # Substitua pela sua região desejada
  storage_account_type = "Standard_LRS" # Escolha o tipo de armazenamento
}

# Opcionalmente, configure um script de inicialização personalizado
resource "azurerm_cloud_shell_profile" "example" {
  name = "my-profile"
  cloud_shell_id = azurerm_cloud_shell.example.id
  script = "echo 'Hello from Cloud Shell!'"
}
    
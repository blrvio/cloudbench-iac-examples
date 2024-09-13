
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Configuração de recursos
}

# Crie um recurso de aplicativo móvel
resource "azurerm_mobile_app" "example" {
  name     = "example-mobile-app"
  location = "westus2" # Substitua pela sua região desejada
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  # Outros parâmetros de configuração
}

# Crie um banco de dados para o aplicativo móvel
resource "azurerm_sql_database" "example" {
  name     = "example-mobile-db"
  location = "westus2" # Substitua pela sua região desejada
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  server_name = "example-sql-server" # Substitua pelo nome do seu servidor SQL
  # Outros parâmetros de configuração
}

# Crie uma tabela no banco de dados
resource "azurerm_sql_table" "example" {
  name             = "example-table"
  database_name    = "example-mobile-db"
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  server_name      = "example-sql-server" # Substitua pelo nome do seu servidor SQL
  schema           = "dbo" # Substitua pelo esquema desejado
  # Outros parâmetros de configuração
}

# Configure o serviço de notificação
resource "azurerm_notification_hub" "example" {
  name     = "example-notification-hub"
  location = "westus2" # Substitua pela sua região desejada
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  # Outros parâmetros de configuração
}

# Crie uma conexão entre o aplicativo móvel e o serviço de notificação
resource "azurerm_mobile_app_notification_hub_connection" "example" {
  name                 = "example-notification-hub-connection"
  mobile_app_name       = "example-mobile-app"
  notification_hub_name = "example-notification-hub"
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
}

# Crie uma política de acesso para o aplicativo móvel
resource "azurerm_mobile_app_access_policy" "example" {
  name                 = "example-access-policy"
  mobile_app_name       = "example-mobile-app"
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  # Outros parâmetros de configuração
}
    
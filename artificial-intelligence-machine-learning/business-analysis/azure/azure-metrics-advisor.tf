
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use a versão mais recente do provedor
}

# Crie um recurso de Monitoramento do Azure
resource "azurerm_monitor_workspace" "metrics_advisor_workspace" {
  name     = "metrics_advisor_workspace"
  location = "westus2" # Substitua pela sua região desejada
  resource_group_name = "my-resource-group" # Substitua pelo nome do seu grupo de recursos
}

# Crie um recurso do Metrics Advisor
resource "azurerm_metrics_advisor_configuration" "metrics_advisor_configuration" {
  name                  = "metrics_advisor_configuration"
  resource_group_name    = "my-resource-group" # Substitua pelo nome do seu grupo de recursos
  workspace_name        = azurerm_monitor_workspace.metrics_advisor_workspace.name
  alerting_configuration {
    alert_frequency      = "daily"
  }
  ingestion_configuration {
    auto_detect_anomalies = true
    data_source {
      data_source_type = "application_insights"
      app_id           = "YOUR_APP_INSIGHTS_ID" # Substitua pelo ID do seu Application Insights
    }
  }
  metric_configurations {
    metric_name      = "YOUR_METRIC_NAME" # Substitua pelo nome da métrica
    metric_namespace = "YOUR_METRIC_NAMESPACE" # Substitua pelo namespace da métrica
  }
}

    
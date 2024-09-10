
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Metrics Advisor configuration
resource "azurerm_metrics_advisor_configuration" "main" {
  name                = "metrics-advisor-configuration"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  # This will create a Metrics Advisor configuration for a particular resource
  # You will need to provide the `resource_uri` for the resource you want to monitor.
  # For example, you can use the `resource_uri` of an Azure Storage account.
  resource_uri = "<resource_uri>"
  # Set the alert configuration for the Metrics Advisor
  alert_config {
    # Set the threshold for when an alert should be triggered.
    alerting_threshold = 0.9
    # Set the timeframe for the alert.
    alerting_timeframe = "PT1H"
  }
  # Set the anomaly detection configuration for the Metrics Advisor
  anomaly_detection_config {
    # Set the detection scope for the Metrics Advisor
    detection_scope = "ALL"
  }
  # Set the metric configuration for the Metrics Advisor
  metric_config {
    # Set the metric name for the Metrics Advisor
    metric_name = "bytes_received"
    # Set the aggregation type for the metric
    aggregation_type = "Average"
  }
}

# Create a Metrics Advisor alert
resource "azurerm_metrics_advisor_alert" "main" {
  name                = "metrics-advisor-alert"
  resource_group_name = "my-resource-group"
  configuration_name = azurerm_metrics_advisor_configuration.main.name
  # This will create an alert that will be triggered when the metric exceeds the threshold defined in the Metrics Advisor configuration.
  alerting_threshold = 0.9
  # Set the timeframe for the alert.
  alerting_timeframe = "PT1H"
}

  
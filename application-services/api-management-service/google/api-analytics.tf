
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create an API Analytics configuration
resource "google_api_analytics_config" "default" {
  display_name = "My API Analytics Config"
  project      = "your-gcp-project-id"
  description  = "This is a sample API Analytics configuration"

  # Optional configurations
  # billing_account = "your-billing-account-id"
  # etag           = "your-etag"
  # labels          = {
  #   "label_key" = "label_value"
  # }
}

# Create an API Analytics view
resource "google_api_analytics_view" "default" {
  api_config_name = google_api_analytics_config.default.name
  display_name = "My API Analytics View"
  project      = "your-gcp-project-id"
  description  = "This is a sample API Analytics view"

  # Optional configurations
  # etag           = "your-etag"
  # labels          = {
  #   "label_key" = "label_value"
  # }
}

# Create an API Analytics metric
resource "google_api_analytics_metric" "default" {
  display_name = "My API Analytics Metric"
  project      = "your-gcp-project-id"
  description  = "This is a sample API Analytics metric"

  # Optional configurations
  # etag           = "your-etag"
  # labels          = {
  #   "label_key" = "label_value"
  # }
}

# Create an API Analytics filter
resource "google_api_analytics_filter" "default" {
  display_name = "My API Analytics Filter"
  project      = "your-gcp-project-id"
  description  = "This is a sample API Analytics filter"

  # Optional configurations
  # etag           = "your-etag"
  # labels          = {
  #   "label_key" = "label_value"
  # }
}
  
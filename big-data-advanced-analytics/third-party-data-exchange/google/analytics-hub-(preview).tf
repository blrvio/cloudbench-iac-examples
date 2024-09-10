
    # Configure the Google Cloud provider
provider "google" {
  project = "my-gcp-project"
  region  = "us-central1" # Replace with your desired region
}

# Create an Analytics Hub Data Exchange
resource "google_analyticshub_data_exchange" "main" {
  name             = "my-data-exchange"
  display_name     = "My Data Exchange"
  data_exchange_id = "my-data-exchange-id"
  description      = "Data Exchange for sharing analytics data"
}

# Create an Analytics Hub Data Exchange Listing
resource "google_analyticshub_data_exchange_listing" "main" {
  data_exchange_id  = google_analyticshub_data_exchange.main.data_exchange_id
  display_name       = "My Data Exchange Listing"
  data_exchange_type = "DATA_EXCHANGE"
}

# Create an Analytics Hub Data Source
resource "google_analyticshub_data_source" "main" {
  data_exchange_id = google_analyticshub_data_exchange.main.data_exchange_id
  data_source_id   = "my-data-source"
  display_name       = "My Data Source"
  description      = "A data source for the data exchange"
}

# Create an Analytics Hub Data Source Listing
resource "google_analyticshub_data_source_listing" "main" {
  data_exchange_id = google_analyticshub_data_exchange.main.data_exchange_id
  data_source_id   = google_analyticshub_data_source.main.data_source_id
  display_name       = "My Data Source Listing"
  data_exchange_type = "DATA_SOURCE"
  # Use the default data source schema
  schema = "projects/my-gcp-project/locations/us-central1/datasets/default/tables/default_dataset_schema"
}

  
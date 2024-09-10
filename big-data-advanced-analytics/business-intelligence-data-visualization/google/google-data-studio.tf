
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Google Data Studio report
resource "google_datastudio_report" "main" {
  name      = "My Data Studio Report"
  data_source_type = "GOOGLE_SHEETS"
  # Replace this with your Google Sheets data source ID
  data_source_id = "your-google-sheets-data-source-id"
  # Optional: You can specify the Google Sheets URL instead of the ID
  # data_source_url = "https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0"
}

# You can also use Google Data Studio connectors to connect to other data sources
# like Google Analytics, BigQuery, Cloud SQL, and more.
# See the Google Data Studio documentation for more information on connectors:
# https://cloud.google.com/data-studio/docs/data-sources
  
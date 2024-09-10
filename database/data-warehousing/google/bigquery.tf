
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a BigQuery dataset
resource "google_bigquery_dataset" "main" {
  dataset_id = "my_dataset"
  # Add labels for organization
  labels = {
    environment = "dev"
  }
  # Define access controls
  access {
    role = "roles/bigquery.dataViewer"
    user_by_email = "user@example.com"
  }
}

# Create a BigQuery table
resource "google_bigquery_table" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  table_id    = "my_table"
  # Define the schema of the table
  schema = <<EOF
  [ 
    {
      "name": "id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "name",
      "type": "STRING",
      "mode": "NULLABLE"
    }
  ]
EOF
}

  
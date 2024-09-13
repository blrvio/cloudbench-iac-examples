
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto GCP
}

# Crie um dataset
resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "my_dataset"
  delete_contents_on_destroy = false
  default_table_expiration_ms = 365 * 24 * 60 * 60 * 1000 # Expire tables after 1 year
  default_partition_expiration_ms = 365 * 24 * 60 * 60 * 1000 # Expire partitions after 1 year
  default_time_travel_hours = 24 # Keep a snapshot for 24 hours
  labels = {
    environment = "dev"
  }
}

# Crie uma tabela
resource "google_bigquery_table" "my_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  table_id   = "my_table"

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED",
    "description": "Unique ID"
  },
  {
    "name": "name",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Name of the item"
  }
]
EOF
}

# Crie uma view
resource "google_bigquery_view" "my_view" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  view_id     = "my_view"

  query = "SELECT * FROM `gcp-project-id.my_dataset.my_table`"
}

    
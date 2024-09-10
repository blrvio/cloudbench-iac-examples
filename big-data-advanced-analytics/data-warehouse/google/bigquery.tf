
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a BigQuery dataset
resource "google_bigquery_dataset" "main" {
  dataset_id = "my_dataset"
  location    = "US"
  # Optional: Set the default partition expiration for the dataset
  default_partition_expiration_ms = 31536000000 # 1 year
  # Optional: Set the default table expiration for the dataset
  default_table_expiration_ms = 31536000000 # 1 year

  # Optional: Set the default view lifetime for the dataset
  default_view_lifetime_ms = 31536000000 # 1 year
  # Optional: Set the default view materialization policy
  default_view_materialization_policy = "MATERIALIZED_VIEW"
  # Optional: Set the default view query optimization policy
  default_view_query_optimization_policy = "QUERY_OPTIMIZATION_ENABLED"
  # Optional: Set the default view usage policy
  default_view_usage_policy = "VIEW_USAGE_ENABLED"
}

# Create a BigQuery table
resource "google_bigquery_table" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  table_id   = "my_table"
  # Set the table schema
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

  

      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie um conjunto de dados BigQuery
resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "my_dataset"
  dataset_ref {
    project = "gcp-project-id"
  }
  location = "US"
}

# Crie uma tabela BigQuery
resource "google_bigquery_table" "my_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  table_id = "my_table"
  table_ref {
    project = "gcp-project-id"
    dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  }
  schema = <<EOF
[ 
    {
        "name": "name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "age",
        "type": "INTEGER",
        "mode": "NULLABLE"
    }
]
EOF
}

    
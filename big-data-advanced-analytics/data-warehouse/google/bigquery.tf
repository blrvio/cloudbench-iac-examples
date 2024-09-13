
      # Configure o provedor do Google Cloud
provider "google" {
  project = "my-project-id"
}

# Crie um conjunto de dados
resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "my_dataset"
  location    = "US"
}

# Crie uma tabela
resource "google_bigquery_table" "my_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  table_id   = "my_table"
  schema      = <<EOF
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

    

      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie um conjunto de dados do Cloud DataPrep
resource "google_dataprep_dataset" "default" {
  name     = "my-dataset"
  location = "us-central1"
}

# Crie um fluxo de trabalho do Cloud DataPrep
resource "google_dataprep_flow" "default" {
  dataset_id = google_dataprep_dataset.default.id
  name        = "my-flow"
  recipe      = <<EOF
  {
    "steps": [
      {
        "operation": "TRANSFORM",
        "parameters": {
          "replacements": [
            {
              "source": "\d{3}-\d{3}-\d{4}",
              "target": "REPLACE_PHONE_NUMBER"
            }
          ]
        }
      }
    ]
  }
EOF
}
    
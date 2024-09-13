
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id" # Substitua pelo seu ID do projeto
  region  = "us-central1" # Substitua pela sua região desejada
}

# Crie um endpoint do Vertex Matching Engine
resource "google_vertex_ai_matching_engine_endpoint" "default" {
  display_name = "matching-engine-endpoint"
  location     = "us-central1" # Substitua pela sua região desejada
  matching_engine {
    model = "your-model-name" # Substitua pelo nome do seu modelo
    model_version = "your-model-version" # Substitua pela versão do seu modelo
  }
}

# Crie uma tarefa de correspondência
resource "google_vertex_ai_matching_engine_matching_job" "default" {
  display_name = "matching-job"
  location     = "us-central1" # Substitua pela sua região desejada
  endpoint     = google_vertex_ai_matching_engine_endpoint.default.name
  input_config {
    bigquery_source {
      table = "your-project-id.your-dataset.your-table" # Substitua pelo caminho da sua tabela BigQuery
    }
  }
  output_config {
    bigquery_destination {
      table = "your-project-id.your-dataset.your-output-table" # Substitua pelo caminho da sua tabela de saída BigQuery
    }
  }
}

    

      # Configure o provedor Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo seu ID do projeto
  region  = "us-central1" # Substitua pela sua região desejada
}

# Crie uma instância do Cloud Bigtable
resource "google_bigtable_instance" "default" {
  name     = "my-instance"
  display_name = "My Bigtable Instance"
  cluster {
    name         = "my-cluster"
    location     = "us-central1-b" # Substitua pela sua zona desejada
    serve_nodes = 3
    storage_type = "SSD"
  }
}

# Crie uma tabela no Cloud Bigtable
resource "google_bigtable_table" "default" {
  instance = google_bigtable_instance.default.name
  name     = "my-table"
  column_families {
    name = "cf1"
  }
}
    
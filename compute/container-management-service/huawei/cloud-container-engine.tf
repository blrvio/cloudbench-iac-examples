
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie um cluster Kubernetes
resource "google_container_cluster" "main" {
  name     = "my-cluster"
  location = "us-central1"

  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }

  # Opções adicionais de configuração podem ser adicionadas aqui
}

# Importe o namespace padrão
resource "google_container_namespace" "default" {
  cluster = google_container_cluster.main.name
  location = google_container_cluster.main.location
  name     = "default"
}
    
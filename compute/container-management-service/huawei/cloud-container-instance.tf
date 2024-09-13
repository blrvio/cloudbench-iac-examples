
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo seu ID do projeto
  region  = "us-central1" # Substitua pela sua região
}

# Crie um cluster de Cloud Container Instance
resource "google_container_cluster" "default" {
  name     = "my-cluster"
  location = google_container_cluster.default.location
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  add_ons {
    kubernetes_dashboard {
      disabled = false
    }
  }
}

# Crie um namespace no cluster
resource "google_container_namespace" "default" {
  cluster = google_container_cluster.default.name
  name    = "default"
}

# Importe o serviço do Google Kubernetes Engine
resource "google_container_service" "default" {
  name    = "my-service"
  location = google_container_cluster.default.location
  cluster = google_container_cluster.default.name
  namespace = google_container_namespace.default.name
  template {
    spec {
      containers {
        name  = "nginx"
        image = "nginx:latest"
        ports {
          container_port = 80
        }
      }
    }
  }
}
    
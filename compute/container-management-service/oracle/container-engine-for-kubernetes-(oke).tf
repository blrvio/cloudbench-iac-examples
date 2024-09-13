
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela região desejada
}

# Crie um cluster Kubernetes
resource "google_container_cluster" "default" {
  name     = "my-cluster"
  location = google_container_cluster.default.location

  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }

  # Adicione um grupo de nós com um tipo de máquina específico
  node_pool {
    name = "default-pool"
    initial_node_count = 3
    node_config {
      machine_type = "n1-standard-1"
    }
  }
}

# Crie um serviço Kubernetes
resource "google_container_cluster_service" "default" {
  name     = "my-service"
  location = google_container_cluster.default.location
  cluster  = google_container_cluster.default.name
  namespace = "default"
  port      = 80
  selector = {
    app = "my-app"
  }
}

# Implante um aplicativo em um pod Kubernetes
resource "google_container_cluster_deployment" "default" {
  name     = "my-deployment"
  location = google_container_cluster.default.location
  cluster  = google_container_cluster.default.name
  namespace = "default"
  replicas  = 3
  template {
    metadata {
      labels = {
        app = "my-app"
      }
    }
    spec {
      containers {
        name  = "my-app"
        image = "nginx:latest"
        ports {
          container_port = 80
        }
      }
    }
  }
}
    

    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Create a Kubernetes Cluster
resource "google_container_cluster" "main" {
  name     = "my-kubernetes-cluster"
  location = google_container_cluster.main.location
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
  # Add the necessary network configurations
  network = "default"
  # Add the necessary node pools
  node_pool {
    name     = "default-pool"
    initial_node_count = 3
    node_config {
      machine_type = "n1-standard-1"
    }
  }
}

# Create a Namespace
resource "google_container_namespace" "main" {
  cluster = google_container_cluster.main.name
  location = google_container_cluster.main.location
  name     = "my-namespace"
}

# Create a Deployment
resource "google_container_deployment" "main" {
  cluster  = google_container_cluster.main.name
  location = google_container_cluster.main.location
  name     = "my-deployment"
  namespace = google_container_namespace.main.name
  spec {
    replicas = 3
    template {
      metadata {
        labels = {
          "app" = "my-app"
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
}
  

    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "main" {
  name     = "my-anthos-cluster"
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }

  # Enable Anthos features
  enable_anthos_features = true

  # Configure authentication settings
  authentication {
    provider = "google_key"
    admin_users = ["user@example.com"]
  }

  # Network settings
  network_config {
    network = "my-network"
    subnetwork = "my-subnetwork"
  }
}

# Create an Anthos Config Management repository
resource "google_configmanagement_repository" "main" {
  name    = "my-anthos-repo"
  location = "us-central1"
  git {
    url = "https://github.com/my-org/my-repo.git"
  }
}

# Deploy a sample application to the cluster
resource "google_container_cluster_deployment" "main" {
  name       = "my-app-deployment"
  cluster    = google_container_cluster.main.name
  location = "us-central1"
  template {
    spec {
      containers {
        name = "my-app"
        image = "my-app:latest"
      }
    }
  }
}
  
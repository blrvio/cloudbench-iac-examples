
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Update with your desired region
}

# Create a Kubernetes cluster
resource "google_container_cluster" "main" {
  name     = "my-cluster"
  location = google_container_cluster.main.location

  # Set cluster settings
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
  # Enable autoscaling
  autoscaling {
    enabled = true
  }
}

# Create a namespace for the application
resource "google_container_namespace" "main" {
  location  = google_container_cluster.main.location
  cluster   = google_container_cluster.main.name
  name      = "my-app-namespace"
  project   = google_container_cluster.main.project
}

# Deploy the application to Kubernetes
# ... (Use `kubectl` or other Kubernetes management tools)

  
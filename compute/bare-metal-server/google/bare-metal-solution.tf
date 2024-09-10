
    # Configure the Google Cloud provider
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Create a Google Cloud Bare Metal Solution Launch Instance
resource "google_bare_metal_solution_launch_instance" "main" {
  name = "my-launch-instance"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  # Add any required configurations for your use case
}

# Create a Google Cloud Bare Metal Solution Provisioned Instance
resource "google_bare_metal_solution_provisioned_instance" "main" {
  name = "my-provisioned-instance"
  launch_instance = google_bare_metal_solution_launch_instance.main.name
  # Add any required configurations for your use case
}

  
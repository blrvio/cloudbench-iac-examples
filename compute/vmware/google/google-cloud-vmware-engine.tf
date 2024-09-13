
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um cluster do VMware Engine
resource "google_vmware_engine_private_cloud" "main" {
  name    = "my-private-cloud"
  location = google_vmware_engine_private_cloud.main.location
  network  = "projects/your-project-id/global/networks/default"
  # ... other configurations
}

# Crie uma máquina virtual no cluster
resource "google_vmware_engine_vm" "main" {
  name    = "my-vm"
  private_cloud = google_vmware_engine_private_cloud.main.id
  # ... other configurations
}
    
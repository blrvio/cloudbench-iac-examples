
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Migration Server
resource "google_migration_server" "main" {
  name     = "my-migration-server"
  zone     = "us-central1-a"
  machine_type = "n1-standard-1"
  disk {
    size_gb = 100
    type     = "pd-standard"
  }
  network_interface {
    network = "default"
    subnetwork = "projects/your-gcp-project-id/regions/us-central1/subnetworks/default"
  }
}

# Create a Migration Task
resource "google_migration_task" "main" {
  name                 = "my-migration-task"
  migration_server_name = google_migration_server.main.name
  source_type          = "VMWARE"
  # Configure the source environment
  source_config {
    vmware_config {
      host = "your-vmware-host"
      port = 443
      username = "your-vmware-username"
      password = "your-vmware-password"
      # Define the VMs to be migrated
      source_vm {
        name     = "your-vmware-vm-name"
        datastore = "your-vmware-datastore"
      }
    }
  }
  # Configure the target environment
  target_config {
    gcp_config {
      # Define the Google Cloud project to migrate to
      project = "your-gcp-project-id"
      # Define the Google Cloud zone to migrate to
      zone = "us-central1-a"
    }
  }
}

  
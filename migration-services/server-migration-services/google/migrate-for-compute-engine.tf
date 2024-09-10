
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Migrate for Compute Engine source
resource "google_migrate_for_compute_engine_source" "main" {
  name     = "your-source-name"
  project  = "your-gcp-project-id"
  location = "us-central1"

  # Configure source details
  vm_instance {
    name     = "your-vm-instance-name"
    zone     = "us-central1-a"
    project  = "your-gcp-project-id"
  }

  # Configure storage for the migration
  migrate_for_compute_engine_storage {
    storage_type     = "GCS"
    storage_location = "your-gcs-bucket-name"
  }
}

# Create a Migrate for Compute Engine migration task
resource "google_migrate_for_compute_engine_migration_task" "main" {
  name       = "your-migration-task-name"
  project    = "your-gcp-project-id"
  location   = "us-central1"
  source_name = google_migrate_for_compute_engine_source.main.name

  # Configure migration task settings
  target_project = "your-gcp-project-id"
  target_zone    = "us-central1-b"
  target_machine_type = "n1-standard-1"

  # Configure network settings
  network_interface {
    network  = "your-vpc-network-name"
    subnetwork = "your-subnetwork-name"
  }
}

  
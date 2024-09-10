
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Dataproc cluster
resource "google_dataproc_cluster" "main" {
  name    = "my-dataproc-cluster"
  region  = "us-central1"
  master_config {
    num_instances = 1
    machine_type  = "n1-standard-1"
    disk_config {
      boot_disk_size_gb = 100
    }
  }
  worker_config {
    num_instances = 2
    machine_type  = "n1-standard-1"
    disk_config {
      boot_disk_size_gb = 100
    }
  }
  # Define the software configuration
  initialization_actions {
    # Install the Hive metastore on the master node
    executable_file = "gs://google-cloud-dataproc/init/metastore/setup/metastore-init.sh"
  }
}

  
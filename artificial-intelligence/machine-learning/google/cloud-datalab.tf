
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Dataproc cluster
resource "google_dataproc_cluster" "main" {
  name     = "my-dataproc-cluster"
  region   = "us-central1"
  master_config {
    machine_type = "n1-standard-1"
    num_instances = 1
    disk_config {
      boot_disk_size_gb = 100
    }
  }
  worker_config {
    machine_type = "n1-standard-1"
    num_instances = 2
    disk_config {
      boot_disk_size_gb = 100
    }
  }

  # Enable Dataproc Metastore
  # This is optional, but recommended for managing data catalog and metadata
  # metastore_config {
  #   service_config {
  #     version = "2.0"
  #   }
  # }
}

# Create a Data Catalog
resource "google_data_catalog_entry" "main" {
  linked_resource {
    # Link to the Cloud Storage bucket
    gcs_source {
      resource_uri = "gs://your-bucket-name/path/to/data"
    }
  }
  name        = "my-data-catalog-entry"
  description = "Data catalog entry for my data"
  entry_group_id = google_data_catalog_entry_group.main.id
}

resource "google_data_catalog_entry_group" "main" {
  name = "my-data-catalog-group"
  # Specify the location of the entry group
  location = "us-central1"
}

  
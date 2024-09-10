
    # Configure the Google Cloud provider
provider "google" {
  project = "my-gcp-project"
  region  = "us-central1"
}

# Create a Bigtable instance
resource "google_bigtable_instance" "main" {
  name     = "my-bigtable-instance"
  display_name = "My Bigtable Instance"
  # Choose the instance type (development, production)
  type = "PRODUCTION"

  # Configure the cluster settings
  cluster {
    name = "my-cluster"
    # Choose the cluster location
    location = "us-central1-b"
    # Define the cluster size
    serve_nodes = 3
  }
}

# Create a Bigtable table
resource "google_bigtable_table" "main" {
  instance = google_bigtable_instance.main.name
  name     = "my-table"
  # Define the table schema
  column_family {
    name   = "cf1"
    gc_rule {
      # Set the garbage collection policy for the column family
      union {
        max_age {
          seconds = 3600
        }
      }
    }
  }
}

  
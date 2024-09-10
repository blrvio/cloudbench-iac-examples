
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a File Store instance
resource "google_file_store_instance" "default" {
  name     = "my-file-store"
  tier     = "STANDARD"
  capacity = 1024 # capacity in GiB
  network = "projects/your-project-id/global/networks/default"
  #  This is optional and you can use your own network.
  #  network  = "projects/your-project-id/global/networks/your-network"
  # You can define file system access permissions here
  #  file_share_config {
  #    nfs_export_options {
  #      access_mode  = "READ_WRITE"
  #      squash       = "NO_SQUASH"
  #      root_squash = "ROOT_SQUASH"
  #      # Define what network has access
  #      #  network = "projects/your-project-id/global/networks/your-network"
  #    }
  #  }
}

# Mount the File Store instance on a Compute Engine instance
# You'll need to specify the Compute Engine instance name
# resource "google_compute_instance" "compute" {
#   # ...
# }
resource "google_file_store_instance_mount" "default" {
  instance    = "your-compute-instance"
  file_share = google_file_store_instance.default.file_share
  #  This is optional and you can use your own network.
  #  network = "projects/your-project-id/global/networks/your-network"
  network    = "projects/your-project-id/global/networks/default"
  mount_point = "/mnt/my-file-store"
  # This is required to define how to access the file share.
  #  read_only  = false
  #  subnetwork = "projects/your-project-id/regions/us-central1/subnetworks/your-subnetwork"
}

  
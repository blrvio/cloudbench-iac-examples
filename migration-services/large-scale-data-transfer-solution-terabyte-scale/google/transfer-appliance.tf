
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Adjust if needed
}

# Create a Transfer Appliance
resource "google_transfer_appliance" "default" {
  name     = "transfer-appliance"
  location = "us-central1" # Location of the appliance
  # Create the Transfer Appliance configuration
  config {
    # Set the transfer appliance capacity
    capacity = "40TB"
  }
}

# Create a Transfer Appliance Instance
resource "google_transfer_appliance_instance" "default" {
  appliance = google_transfer_appliance.default.id
  # Configure the Transfer Appliance instance
  instance_config {
    # Configure the Transfer Appliance instance
    # Configure the Transfer Appliance instance
    name     = "transfer-appliance-instance"
    location = "us-central1"
  }
}

# Create a Transfer Appliance Node
resource "google_transfer_appliance_node" "default" {
  appliance   = google_transfer_appliance.default.id
  instance_id = google_transfer_appliance_instance.default.id
  # Configure the Transfer Appliance node
  node_config {
    # Configure the Transfer Appliance node
    name     = "transfer-appliance-node"
    location = "us-central1"
  }
}
  
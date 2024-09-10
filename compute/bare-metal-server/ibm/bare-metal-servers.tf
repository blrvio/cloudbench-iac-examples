
    # Configure the IBM Cloud Provider
provider "ibm_cloud" {
  region = "us-south"
  # You can also use "ibm_cloud_account" to manage specific account settings.
}

# Create a Bare Metal Server Instance
resource "ibm_cloud_bare_metal_server" "main" {
  name = "my-bare-metal-server"
  # Set the desired instance type
  instance_type = "bx2-16x32"
  # Select the datacenter location
  datacenter = "dal10"
  # Configure the network
  network {
    # Define the network configuration
  }
  # Configure the storage
  storage {
    # Define the storage configuration
  }
  # Add any other specific options as needed
  # ...
}

# Create a Network Interface for the Server
resource "ibm_cloud_bare_metal_server_network_interface" "main" {
  # Define the Network Interface configuration
  server_id = ibm_cloud_bare_metal_server.main.id
  # ...
}

# Create a Storage Volume for the Server
resource "ibm_cloud_bare_metal_server_storage_volume" "main" {
  # Define the Storage Volume configuration
  server_id = ibm_cloud_bare_metal_server.main.id
  # ...
}
  

    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY"
  region            = "us-south"
}

# Create a dedicated virtual server infrastructure (VSI)
resource "ibm_vsi_infrastructure" "main" {
  name          = "my-vsi-infrastructure"
  location      = "us-south"
  # Define the hardware profile for the VSI
  hardware_profile = "vx-series"
  # Configure the network settings for the VSI
  network_settings {
    # Create a new network for the VSI
    create_network = true
    # Specify the network name
    network_name  = "my-vsi-network"
    # Define the subnet details
    subnet {
      # Specify the subnet name
      name = "my-vsi-subnet"
      # Configure the subnet mask
      cidr = "10.0.0.0/24"
    }
  }
}

# Create a virtual server instance
resource "ibm_vsi_instance" "main" {
  # Specify the VSI infrastructure ID
  infrastructure_id = ibm_vsi_infrastructure.main.id
  # Define the instance name
  name             = "my-vsi-instance"
  # Choose the operating system image for the instance
  image_id         = "centos-7.9-vsi"
  # Define the instance type
  instance_type    = "vx-series-s"
  # Define the storage size for the instance
  storage_size     = 100
  # Configure the network settings for the instance
  network_settings {
    # Connect the instance to the VSI network
    network_id = ibm_vsi_infrastructure.main.network_settings.0.network_id
    # Specify the subnet to use
    subnet_name = ibm_vsi_infrastructure.main.network_settings.0.subnet.0.name
  }
  # Define the SSH key to use for accessing the instance
  ssh_key_name = "my-ssh-key"
}

  
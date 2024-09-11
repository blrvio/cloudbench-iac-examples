
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your own region
  # Set the compartment ID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Create a Burstable Instance
resource "oci_core_instance" "main" {
  availability_domain = "US-ASHBURN-1A"
  # Replace with your desired Availability Domain
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name = "burstable-instance"
  # Choose a suitable shape for your needs
  shape = "VM.Standard.E2.1"
  # Set the number of instances to create
  count = 1
  # Set the instance source details
  source_details {
    # Use the latest Oracle Linux image
    image_id = "ocid1.image.oc1.iad.aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
  # Define the network configuration
  network_interfaces {
    subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxx"
    # Replace with the subnet ID for your network
    # You can optionally configure more network details here
  }
  # Set the boot volume size
  boot_volume_size_in_gbs = 50
  # Choose a suitable boot volume type for your needs
  boot_volume_type = "standard"
  # Enable or disable the public IP address for the instance
  create_vnic_details {
    assign_public_ip = false
  }
  # Set the availability configuration
  availability_config {
    # Choose a suitable availability configuration for your needs
    # Set the availability domain for the instance
    availability_domain = "US-ASHBURN-1A"
  }
}

  
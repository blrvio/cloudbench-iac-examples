
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your tenancy OCID and user OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  # Provide your API key
  # You can store it securely using Terraform's secrets management
  # See https://www.terraform.io/docs/language/providers/oci/index.html#configuring-the-oci-provider
}

# Create a bare metal instance
resource "oci_core_instance" "main" {
  availability_domain = "AD-1"
  # Replace with your desired shape
  shape = "BM.Standard.E2.2"
  # Assign a pre-defined network to the instance
  # For details on creating a network, see https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Concepts/networkoverview.htm
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaxxxxxx"
  # Define the instance's operating system image
  # For available images, see https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/manageimages.htm
  source_details {
    image_id = "ocid1.image.oc1..aaaaaaaaxxxxxx"
  }
  # Assign a pre-defined boot volume to the instance
  # For details on creating a boot volume, see https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/managingbootvolumes.htm
  boot_volume {
    # The boot volume size (in GB) 
    size_in_gbs = 100
    # Replace with your desired volume type
    volume_type = "standard"
    # Replace with your desired volume backup policy
    backup_policy {
      enabled = false
    }
  }
  # Create the instance with a specific display name
  display_name = "my-bare-metal-instance"
}

# Create a security list
resource "oci_network_security_list" "main" {
  display_name = "my-security-list"
  # Create the security list in your network's compartment
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Define the rules for the security list
  egress {
    # Allow all traffic to exit the instance
    protocol = "all"
    # Any destination
    destination = "0.0.0.0/0"
  }
  ingress {
    # Allow incoming SSH connections
    protocol = "tcp"
    # Source is your own IP address
    source = "192.168.1.1/32"
    # Port 22 (SSH)
    destination_port_range = "22"
  }
  # Create the security list in the same subnet as the instance
  subnet_id = oci_core_instance.main.subnet_id
}

# Assign the security list to the instance
resource "oci_core_instance_security_list" "main" {
  instance_id = oci_core_instance.main.id
  security_list_id = oci_network_security_list.main.id
}

  
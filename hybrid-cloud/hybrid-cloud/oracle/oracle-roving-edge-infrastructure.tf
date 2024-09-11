
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your Oracle Cloud Infrastructure tenancy
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your Oracle Cloud Infrastructure user ocid
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your Oracle Cloud Infrastructure region
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure compartment ocid
  compartment_ocid = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create a Roving Edge Infrastructure instance
resource "oci_core_instance" "main" {
  availability_domain = "AD-1"
  # Replace with a supported shape name
  shape              = "VM.Standard.E2.1"
  # Replace with your chosen image ocid
  source_image_id     = "ocid1.image.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with a subnet ocid
  subnet_id            = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Set a unique display name
  display_name          = "Roving-Edge-Instance"
  # Configure the instance's SSH public key
  # For example, replace "ssh-rsa ..." with the public key contents
  ssh_public_keys      = ["ssh-rsa ..."]
  # Replace with the desired number of instances
  instance_count = 1
  # Define the instance's networking configuration
  # This configuration creates a virtual network interface (VNIC)
  # with a public IP address
  network_interfaces {
    subnet_id = oci_core_subnet.subnet.id
    # Enable public IP assignment
    is_public = true
  }
  # Create a block storage volume
  block_volume_attachments {
    # Replace with the desired volume size in GB
    size_in_gbs = 100
    # Choose the block storage volume type
    # Options include 'standard', 'performance', and 'ultra_performance'
    type = "standard"
    # Replace with a volume ocid
    volume_id = oci_core_volume.volume.id
  }
  # Attach the block volume to the instance
  block_volume_attachments {
    device = "/dev/sdb"
    # Attach to the instance
    instance_id = oci_core_instance.main.id
    # Attach to the volume
    volume_id = oci_core_volume.volume.id
  }
}

# Create a block storage volume
resource "oci_core_volume" "volume" {
  # Replace with the desired volume size in GB
  size_in_gbs = 100
  # Choose the block storage volume type
  # Options include 'standard', 'performance', and 'ultra_performance'
  type = "standard"
  # Replace with an availability domain ocid
  availability_domain = "AD-1"
}

# Create a subnet
resource "oci_core_subnet" "subnet" {
  # Replace with the desired subnet name
  display_name = "subnet-roving-edge"
  # Choose the IP address range for the subnet
  cidr_block     = "10.0.0.0/20"
  # Replace with a virtual cloud network ocid
  vcn_id        = "ocid1.vcn.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with the desired subnet's DNS label
  dns_label      = "subnet-roving-edge"
  # Ensure the subnet is enabled
  is_enabled     = true
}

# Create a virtual cloud network (VCN)
resource "oci_core_vcn" "vcn" {
  # Choose a unique display name for the VCN
  display_name = "VCN-Roving-Edge"
  # Replace with the desired CIDR block for the VCN
  cidr_block = "10.0.0.0/16"
  # Enable the VCN
  is_enabled = true
}

  
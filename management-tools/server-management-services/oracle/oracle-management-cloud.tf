
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your region
  region = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

  # Provide your API key and secret
  # If you use an instance principal, you don't need to specify
  # these values
  # api_key = "YOUR_API_KEY"
  # api_secret = "YOUR_API_SECRET"
}

# Create a compartment for your resources
resource "oci_core_compartment" "example" {
  name         = "my-compartment"
  description = "Compartment for my resources"

  # The OCID of the parent compartment, required for root compartment
  # parent_compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create a virtual network
resource "oci_core_virtual_network" "example" {
  # Replace with the compartment OCID where you want to create the VCN
  compartment_id  = oci_core_compartment.example.id
  display_name    = "my-vcn"
  cidr_block      = "10.0.0.0/16"
}

# Create a subnet within the virtual network
resource "oci_core_subnet" "example" {
  # Replace with the compartment OCID where you want to create the subnet
  compartment_id  = oci_core_compartment.example.id
  display_name    = "my-subnet"
  vcn_id          = oci_core_virtual_network.example.id
  cidr_block      = "10.0.1.0/24"
}

# Create an instance configuration
resource "oci_core_instance_configuration" "example" {
  # Replace with the compartment OCID where you want to create the instance
  compartment_id = oci_core_compartment.example.id
  display_name  = "my-instance-config"
  # Replace with a valid image OCID
  image_id       = "ocid1.image.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with a valid shape OCID
  shape_id       = "ocid1.shape.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create an instance
resource "oci_core_instance" "example" {
  # Replace with the compartment OCID where you want to create the instance
  compartment_id = oci_core_compartment.example.id
  display_name  = "my-instance"
  # Replace with the subnet OCID where you want to create the instance
  subnet_id       = oci_core_subnet.example.id
  instance_config_id = oci_core_instance_configuration.example.id
  # Define the number of instances to launch, defaults to 1
  # count          = 2
}

# Create a block volume
resource "oci_core_volume" "example" {
  # Replace with the compartment OCID where you want to create the volume
  compartment_id = oci_core_compartment.example.id
  display_name  = "my-volume"
  size_in_gbs    = 100
}

# Attach a block volume to an instance
resource "oci_core_volume_attachment" "example" {
  # Replace with the instance OCID
  instance_id = oci_core_instance.example.id
  # Replace with the volume OCID
  volume_id   = oci_core_volume.example.id
  device      = "/dev/sdb"
}

  
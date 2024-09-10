
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your region
  tenancy_id = "ocid1.tenancy.oc1..."
  # Replace with your tenancy ID
  user_ocid = "ocid1.user.oc1..."
  # Replace with your user OCID
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # Replace with your API key fingerprint
  private_key_path = "~/.oci/api_key.pem"
  # Path to your private key
}

# Create a Block Volume
resource "oci_core_volume" "main" {
  availability_domain = "us-ashburn-1a"
  # Choose an availability domain
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  display_name = "my-block-volume"
  # Choose a display name
  size_in_gbs = 100
  # Specify the volume size in GB
  # Choose a volume type
  volume_type = "standard_tier" # Other options: 'high_performance', 'all_flash', 'gp2'
}

# Create an Instance to attach the volume
resource "oci_core_instance" "main" {
  availability_domain = "us-ashburn-1a"
  # Choose an availability domain
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  display_name = "my-instance"
  # Choose a display name
  shape = "VM.Standard.E2.1"
  # Choose a shape
  source_details {
    image {
      id = "ocid1.image.oc1..."
      # Replace with the image OCID
    }
  }
  # Attach the block volume
  volume_attachments {
    device = "/dev/sdb"
    volume_id = oci_core_volume.main.id
  }
}

  
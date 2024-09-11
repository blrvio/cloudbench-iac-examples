
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
  # Replace with your actual values.
}

# Create a Block Volume
resource "oci_core_volume" "example" {
  availability_domain = "us-ashburn-1a"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name        = "example-volume"
  size_in_gbs         = 100
  # Optionally define the volume type.
  # volume_type = "standard"
  # volume_type = "premium"
  # volume_type = "high_performance"
  # volume_type = "all_flash"
}

# Create a Volume Attachment
resource "oci_core_volume_attachment" "example" {
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  instance_id        = "ocid1.instance.oc1..aaaaaaaaxxxxxx"
  volume_id          = oci_core_volume.example.id
  device              = "/dev/sdb"
}

  
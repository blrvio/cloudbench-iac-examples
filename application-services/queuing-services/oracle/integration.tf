
    # Configure the Oracle Cloud Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaaaaaaxxxxxxxxx"
  user     = "ocid1.user.oc1..aaaaaaaaaaaaaxxxxxxxxx"
  key_file = "~/.oci/config"
}

# Create an Oracle Integration Instance
resource "oci_integration_instance" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaxxxxxxxxx"
  display_name  = "my-integration-instance"
  shape         = "OCI_INTEGRATION_INSTANCE_SHAPE_SMALL"
  subnet_id     = "ocid1.subnet.oc1..aaaaaaaaaaaaaxxxxxxxxx"
}

# Create an Oracle Integration Connection
resource "oci_integration_connection" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaxxxxxxxxx"
  display_name  = "my-integration-connection"
  instance_id   = oci_integration_instance.main.id
  type          = "SFTP"
  config = <<EOF
{
  "host": "sftp.example.com",
  "port": 22,
  "username": "user",
  "password": "password"
}
EOF
}
  
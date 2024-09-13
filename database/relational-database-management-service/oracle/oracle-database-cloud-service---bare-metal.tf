
      provider "oci" {
  region = "us-ashburn-1"
}

# Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "example" {
  cidr_block = "10.0.0.0/16"
  display_name = "example-vcn"
}

# Create a subnet within the VCN
resource "oci_core_subnet" "example" {
  vcn_id = oci_core_vcn.example.id
  cidr_block = "10.0.1.0/24"
  display_name = "example-subnet"
}

# Create an Autonomous Database
resource "oci_database_autonomous_database" "example" {
  admin_password = "password"
  admin_username = "admin"
  database_edition = "ENTERPRISE_EDITION"
  db_name = "example-db"
  db_version = "19c"
  hostname = "example-db"
  is_auto_scaling_enabled = true
  is_free_tier = false
  is_private_network_access_enabled = false
  license_model = "LICENSE_INCLUDED"
  maintenance_window_days = ["MONDAY", "TUESDAY"]
  maintenance_window_hours = ["10:00", "12:00"]
  maintenance_window_type = "WEEKLY"
  network_subnet_id = oci_core_subnet.example.id
  shape_name = "VM.Standard.E4.Flex"
  wait_for_state = "AVAILABLE"
}
    

    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Configure your Oracle Cloud Infrastructure credentials
  # You can set these environment variables or use a profile
  # in your Terraform configuration.
  # See https://www.terraform.io/docs/providers/oci/index.html#configuration
  region = "us-ashburn-1"
}

# Create an Autonomous Data Warehouse
resource "oci_database_autonomous_database" "main" {
  # Provide a unique name for your database
  display_name = "my-autonomous-database"
  # Choose a database edition (Enterprise Edition is the default)
  edition       = "ENTERPRISE_EDITION"
  # Select the database version (default is latest version)
  database_version = "19c"
  # Choose a subnet to deploy your database
  subnet_id = oci_core_subnet.main.id
  # Specify the storage size in TB
  data_storage_size_in_tbs = 100
  # Choose the backup configuration
  backup_config { # This configuration is optional
    backup_enabled = true
    # The frequency to take backups (hourly, daily, or weekly)
    backup_retention_policy = "DAILY"
  }
}

# Create a subnet
resource "oci_core_subnet" "main" {
  # Assign a unique name for the subnet
  display_name = "my-subnet"
  # Choose a compartment where the subnet will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Select the virtual cloud network (VCN) for the subnet
  vcn_id = oci_core_vcn.main.id
  # Define the CIDR block for the subnet
  cidr_block = "10.0.0.0/16"
}

# Create a virtual cloud network (VCN)
resource "oci_core_vcn" "main" {
  # Give a unique name for the VCN
  display_name = "my-vcn"
  # Specify a compartment where the VCN will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Choose a CIDR block for the VCN
  cidr_block = "10.0.0.0/16"
  # The VCN is created in the specified region
  region = "us-ashburn-1"
}

  
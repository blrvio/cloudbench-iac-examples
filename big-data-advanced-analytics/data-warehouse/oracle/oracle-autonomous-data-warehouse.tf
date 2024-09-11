
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaz775z5755h7k6g7y5477f6i66356h"
  # Replace with your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaz775z5755h7k6g7y5477f6i66356h"
  # Replace with your region
  region = "us-ashburn-1"
  # Replace with your fingerprint
  fingerprint = "25:a4:d0:2e:b5:4d:40:37:41:85:e4:9f:7b:c1:b8:f6"
  # Replace with your private key
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create an Autonomous Data Warehouse
resource "oci_database_autonomous_database" "main" {
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz775z5755h7k6g7y5477f6i66356h"
  # Replace with a descriptive name for your database
  db_name = "my-adw-db"
  # Replace with the desired Autonomous Data Warehouse edition
  edition = "ENTERPRISE"
  # Replace with the desired Autonomous Data Warehouse version
  version = "19.12"
  # Replace with the desired Autonomous Data Warehouse size
  db_workload = "DW"
  # Replace with the desired storage size
  data_storage_size_in_tbs = 100
  # Replace with the desired number of CPU cores
  cpu_core_count = 1
  # Replace with the desired network bandwidth
  network_bandwidth_in_mbps = 1000
  # Replace with the desired subnet OCID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaz775z5755h7k6g7y5477f6i66356h"
  # Define the license model for the database
  license_model = "LICENSE_INCLUDED"
}

# Create an Autonomous Data Warehouse user
resource "oci_database_autonomous_database_user" "main" {
  # Replace with the Autonomous Data Warehouse OCID
  autonomous_database_id = oci_database_autonomous_database.main.id
  # Replace with the username
  username = "myuser"
  # Replace with the password
  password = "mypassword"
}

# Create an Autonomous Data Warehouse database
resource "oci_database_autonomous_database_database" "main" {
  # Replace with the Autonomous Data Warehouse OCID
  autonomous_database_id = oci_database_autonomous_database.main.id
  # Replace with the database name
  db_name = "mydb"
}

  
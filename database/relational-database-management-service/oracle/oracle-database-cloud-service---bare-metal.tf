
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your OCI tenancy OCID
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your OCI user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your OCI region
  region = "us-ashburn-1"
  # Replace with your OCI fingerprint
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
  # Replace with your OCI private key
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Define the Bare Metal database instance
resource "oci_database_bare_metal_instance" "example" {
  # Replace with the compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with the database name
  database_name = "mydb"
  # Replace with the database edition
  edition = "ENTERPRISE_EDITION"
  # Replace with the database version
  version = "19c"
  # Replace with the shape name
  shape = "BM.Standard.2.8"
  # Replace with the subnet OCID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with the hostname
  hostname = "mydatabase"
  # Set the storage size
  storage_size_in_tbs = 100
  # Set the backup configuration
  backup_config {
    # Set the backup frequency
    frequency = "DAILY"
    # Set the backup retention policy
    retention_policy = "RETENTION_POLICY_KEEP_LAST_N_BACKUPS"
    # Set the number of backups to retain
    retention_count = 7
  }
  # Set the network configuration
  network_config {
    # Set the private IP address
    private_ip = "10.0.0.4"
    # Set the public IP address
    public_ip = "192.168.0.1"
    # Set the subnet OCID
    subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  }
}

# Define the listener for the database
resource "oci_database_listener" "example" {
  # Replace with the compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with the database connection string
  connection_string = "tcp://mydatabase:1521/mydb"
  # Replace with the listener name
  display_name = "mylistener"
  # Replace with the subnet OCID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with the TCP port
  tcp_port = 1521
  # Replace with the database OCID
  database_id = oci_database_bare_metal_instance.example.id
}

  
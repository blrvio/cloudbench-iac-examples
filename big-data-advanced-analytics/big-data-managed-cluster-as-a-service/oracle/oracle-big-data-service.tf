
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your own credentials
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  user_ocid   = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  fingerprint = "<fingerprint>" # Replace with your fingerprint
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create a Big Data Service instance
resource "oci_big_data_service_instance" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name  = "my-big-data-service-instance"
  # Set the desired shape for the instance
  shape = "BD_STANDARD_1.2"
  # Set the desired network configuration
  subnet_ids = ["ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"]
  # Set the desired storage configuration
  storage_config {
    # Set the desired storage size
    size_in_tbs = 10
    # Set the desired storage type
    storage_type = "STANDARD"
  }
  # Set the desired service configuration
  service_config {
    # Set the desired version of the service
    version = "2.0"
  }
  # Set the desired user-defined tags
  tags = {
    "Name" = "My Big Data Service Instance"
  }
}

# Create a Big Data Service database
resource "oci_big_data_service_database" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name  = "my-big-data-service-database"
  # Set the desired database instance
  instance_id = oci_big_data_service_instance.main.id
  # Set the desired database version
  version = "2.0"
  # Set the desired database type
  database_type = "Hive"
}

# Create a Big Data Service table
resource "oci_big_data_service_table" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name  = "my-big-data-service-table"
  # Set the desired database
  database_id = oci_big_data_service_database.main.id
  # Set the desired table definition
  table_definition = <<EOF
CREATE EXTERNAL TABLE my_table (
    id INT,
    name STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION 's3a://my-bucket/my-data/'
TBLPROPERTIES ('orc.compress'='ZLIB');
EOF
}

  
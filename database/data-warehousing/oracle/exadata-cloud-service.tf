
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user_ocid  = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  fingerprint = "xxxxxxxxx"
  private_key_path = "path/to/your/private/key"
}

# Define the Exadata Cloud Service
resource "oci_database_exadata_cloud_service" "example" {
  display_name     = "example-exadata"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  shape           = "Exadata_X8M_24"
  version         = "21c"
  # Configure the network settings
  subnet_id       = "ocid1.subnet.oc1..aaaaaaaaxxxxxx"
  # Add optional tags
  tags            = {
    Department = "Engineering"
  }
}

# Define the Exadata Cloud Service database
resource "oci_database_exadata_cloud_service_database" "example" {
  exadata_cloud_service_id = oci_database_exadata_cloud_service.example.id
  display_name             = "example-database"
  admin_password          = "your_password"
  # Configure the database settings
  edition             = "ENTERPRISE"
  character_set        = "AL32UTF8"
  national_character_set = "AL16UTF16"
  # Add optional tags
  tags                 = {
    Environment = "Production"
  }
}

  
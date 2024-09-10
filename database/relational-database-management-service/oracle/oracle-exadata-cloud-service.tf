
    # Configure the Oracle provider
provider "oracle" {
  # Replace with your Oracle Cloud credentials
  user = "your_user"
  password = "your_password"
  tenancy = "your_tenancy"
  # Replace with your Oracle Cloud region
  region = "us-ashburn-1"
}

# Create an Exadata Cloud Service instance
resource "oracle_exadata_cloud_service" "main" {
  # Replace with your desired name for the Exadata Cloud Service instance
  display_name = "my-exadata-instance"
  # Replace with the desired Exadata Cloud Service shape
  shape = "Exadata_X8_8C"
  # Replace with the desired Exadata Cloud Service version
  version = "21.1.0"
  # Replace with the desired Exadata Cloud Service network
  network = "your_network_name"
  # Replace with the desired Exadata Cloud Service subnet
  subnet = "your_subnet_name"
  # Replace with the desired Exadata Cloud Service storage size
  storage_size = 100
  # Replace with the desired Exadata Cloud Service storage type
  storage_type = "SSD"
  # Replace with the desired Exadata Cloud Service license type
  license_type = "BYOL"
}

# Create a database on the Exadata Cloud Service instance
resource "oracle_database" "main" {
  # Replace with the desired name for the database
  display_name = "my-database"
  # Replace with the desired database version
  version = "19.0.0"
  # Replace with the desired database edition
  edition = "Enterprise"
  # Replace with the desired database character set
  character_set = "AL32UTF8"
  # Replace with the desired database national character set
  national_character_set = "AL16UTF16"
  # Replace with the desired database storage size
  storage_size = 100
  # Replace with the desired database storage type
  storage_type = "SSD"
  # Replace with the desired database license type
  license_type = "BYOL"
  # Replace with the Exadata Cloud Service instance ID
  exadata_cloud_service_id = oracle_exadata_cloud_service.main.id
}

  
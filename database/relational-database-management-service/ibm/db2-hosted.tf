
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Db2 Hosted instance
resource "ibm_db2_instance" "main" {
  name          = "my-db2-instance"
  instance_type = "db2-on-cloud-shared-4x32"
  # Use the "free" plan for a free trial
  plan_id     = "db2-on-cloud-shared-4x32-free"
  database_size = 1024 # Database size in MB
  security_group_id = "your_security_group_id"
  # Optional: Configure the network settings
  # network {
  #   vpc_id = "your_vpc_id"
  #   subnet_id = "your_subnet_id"
  # }
}

# Create a Db2 database
resource "ibm_db2_database" "main" {
  instance_id = ibm_db2_instance.main.id
  name        = "my-db2-database"
  # Optional: Define the database character set
  # character_set = "UTF8"
}

# Create a Db2 user
resource "ibm_db2_user" "main" {
  instance_id = ibm_db2_instance.main.id
  database_name = ibm_db2_database.main.name
  name        = "my-db2-user"
  password = "your_password"
}

  
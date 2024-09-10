
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key     = "YOUR_IBM_CLOUD_API_KEY"
  region      = "us-south"
  org_id      = "YOUR_IBM_CLOUD_ORG_ID"
  account_id  = "YOUR_IBM_CLOUD_ACCOUNT_ID"
}

# Create a Databases for EDB service instance
resource "ibm_db_for_edb" "main" {
  name         = "my-edb-instance"
  service_name = "databases-for-enterprisedb"
  plan         = "paid"
  # Specify the EDB version to be used for this service instance
  version      = "14"
  location     = "us-south"
  # Configure the service instance
  config {
    # Optional configuration for the service instance
  }
  #  Add tags to the EDB service instance
  tags = {
    env = "dev"
  }
}

# Create an EDB database
resource "ibm_db_for_edb_database" "main" {
  instance_id = ibm_db_for_edb.main.id
  name        = "mydb"
  #  Add tags to the EDB database
  tags = {
    env = "dev"
  }
}

# Create an EDB user
resource "ibm_db_for_edb_user" "main" {
  instance_id = ibm_db_for_edb.main.id
  name        = "myuser"
  password    = "mypassword"
  #  Add tags to the EDB user
  tags = {
    env = "dev"
  }
}
  
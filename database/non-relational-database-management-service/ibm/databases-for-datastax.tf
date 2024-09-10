
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_API_KEY" # Replace with your IBM Cloud API key
  region  = "us-south"
}

# Create a DataStax Database
resource "ibm_datastax_database" "main" {
  name     = "my-datastax-database"
  plan     = "basic"
  location = "us-south"
  # Set optional parameters
  //  tags = {
  //    key = "value"
  //  }
}

# Create a DataStax Cluster
resource "ibm_datastax_cluster" "main" {
  name           = "my-datastax-cluster"
  database_id   = ibm_datastax_database.main.id
  node_count     = 1
  instance_size = "2X"
  # Set optional parameters
  //  ssl_enabled = false
  //  monitoring_enabled = true
  //  tags = {
  //    key = "value"
  //  }
  //  custom_properties = {
  //    key = "value"
  //  }
}

  
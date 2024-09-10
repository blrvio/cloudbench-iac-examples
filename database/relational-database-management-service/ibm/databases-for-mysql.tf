
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud API key
  api_key = "YOUR_API_KEY"
}

# Create a Databases for MySQL service instance
resource "ibm_databases_for_mysql_instance" "main" {
  name   = "my-mysql-instance"
  plan   = "shared-1g"
  # Optional: Add tags to the instance
  tags = {
    Name = "My MySQL instance"
  }
}

# Create a service binding for the instance
resource "ibm_databases_for_mysql_binding" "main" {
  name     = "my-mysql-binding"
  instance = ibm_databases_for_mysql_instance.main.id
  service  = "databases-for-mysql"
}

  
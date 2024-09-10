
    # Configure the IBM Cloud provider
provider "ibm_cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create an Informix instance
resource "ibm_cloud_informix_instance" "main" {
  name       = "informix-instance"
  plan       = "informix-standard"
  zone       = "us-south-1"
  password   = "your_password"
  database   = "your_database"
  storage_gb = 10
}

# Create a database user
resource "ibm_cloud_informix_user" "main" {
  instance_id = ibm_cloud_informix_instance.main.id
  name       = "your_user"
  password   = "your_password"
}

  

    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "your_ibm_cloud_api_key"
}

# Create a Redis instance
resource "ibm_redis" "main" {
  name     = "my-redis-instance"
  plan     = "shared-4gb"
  location = "us-south"
  # Optional: Configure the password for the Redis instance
  password = "your_password"
}

  
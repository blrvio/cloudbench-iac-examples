
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Create an IBM Cloud Databases for etcd service instance
resource "ibm_databases_etcd_instance" "main" {
  name       = "my-etcd-instance"
  plan       = "standard"
  region     = "us-south"
  service_id = "YOUR_SERVICE_ID"
  # Additional optional configuration parameters
  # See documentation for more details
}

# Get the connection string from the etcd instance
output "connection_string" {
  value = ibm_databases_etcd_instance.main.connection_string
}

# Get the endpoint from the etcd instance
output "endpoint" {
  value = ibm_databases_etcd_instance.main.endpoint
}

  
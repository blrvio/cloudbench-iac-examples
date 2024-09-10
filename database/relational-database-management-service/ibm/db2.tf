
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key  = "<YOUR_IBM_CLOUD_API_KEY>
  region = "us-south"
}

# Create a Db2 instance
resource "ibm_db2_instance" "main" {
  name           = "my-db2-instance"
  plan           = "db2-on-cloud-standard"
  memory         = 1
  storage        = 10
  pricing_model  = "pay-as-you-go"
  instance_group = "default"

  # Optional settings
  # backup_schedule         = "daily"
  # backup_retention_policy = "7 days"
  # maintenance_window = "2023-06-01T12:00:00Z"
  # enable_ssl = true
}

# Create a Db2 service
resource "ibm_db2_service" "main" {
  name        = "my-db2-service"
  instance_id = ibm_db2_instance.main.id

  # Optional settings
  # service_plan = "pay-as-you-go"
}

  
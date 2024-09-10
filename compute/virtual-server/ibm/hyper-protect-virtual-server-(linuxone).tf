
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key      = "your_ibm_cloud_api_key"
  region       = "us-south"
  org_id       = "your_org_id"
  account_id   = "your_account_id"
}

# Create a Hyper Protect Virtual Server
resource "ibm_hyper_protect_virtual_server" "main" {
  name        = "my-hyper-protect-server"
  plan_id     = "your_plan_id"
  region      = "us-south"
  location    = "dal10"
  resource_group_id = "your_resource_group_id"
  # Optional configurations
  #  tags        = {
  #    name = "My Hyper Protect Server"
  #  }
  #  storage_capacity = 100 # In GB
  #  data_encryption_enabled = true
  #  network_security_group_id = "your_network_security_group_id"
}

  
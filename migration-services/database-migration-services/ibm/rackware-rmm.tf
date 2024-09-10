
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  org_id = "YOUR_IBM_CLOUD_ORG_ID"
}

# Create a Rackware RMM instance
resource "ibm_rackware_rmm" "main" {
  name = "my-rackware-rmm"
  plan = "enterprise"
  zone = "us-south-1"
  # Additional options can be configured here, like resource limits, billing cycle, etc.
}

# Create a Rackware RMM user
resource "ibm_rackware_rmm_user" "main" {
  rmm_instance_id = ibm_rackware_rmm.main.id
  username = "admin"
  password = "strong_password"
  # Additional options can be configured here, like user roles and permissions
}
  
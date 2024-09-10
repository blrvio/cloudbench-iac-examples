
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "your_ibm_cloud_api_key" # Replace with your IBM Cloud API key
  region   = "us-south"               # Replace with your IBM Cloud region
}

# Create a Key Protect instance
resource "ibm_key_protect_instance" "main" {
  name        = "my-key-protect-instance" # Replace with your desired instance name
  resource_group = "your_resource_group" # Replace with your IBM Cloud resource group name
  plan        = "standard"              # Choose your desired plan
}

# Create a Key Protect key
resource "ibm_key_protect_key" "main" {
  instance_id = ibm_key_protect_instance.main.id # ID of the Key Protect instance
  name        = "my-key-protect-key"          # Replace with your desired key name
  type        = "AES256"                      # Choose your desired key type
}

# Create a Key Protect policy
resource "ibm_key_protect_policy" "main" {
  instance_id = ibm_key_protect_instance.main.id # ID of the Key Protect instance
  name        = "my-key-protect-policy"          # Replace with your desired policy name
  # Define the permissions for the policy
  permissions = [
    "create",
    "get",
    "update",
    "delete",
    "rotate",
    "sign",
    "verify",
    "wrap",
    "unwrap",
  ]
  # Define the key to which the policy applies
  keys = [ibm_key_protect_key.main.id]
}

  
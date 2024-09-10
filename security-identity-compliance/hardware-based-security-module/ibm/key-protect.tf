
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"  # Replace with your actual IBM Cloud API Key
  region  = "us-south"
}

# Create a Key Protect instance
resource "ibm_key_protect_instance" "main" {
  name     = "my-key-protect-instance"
  resource_group = "my-resource-group"
  location = "us-south"
}

# Create a Key Protect key
resource "ibm_key_protect_key" "main" {
  instance_id = ibm_key_protect_instance.main.id
  name     = "my-key-protect-key"
  algorithm = "AES256"
  key_type = "symmetric"
  # Optional: You can set additional attributes like key usages, labels, and expiration time.
}

# Create a Key Protect policy
resource "ibm_key_protect_policy" "main" {
  instance_id = ibm_key_protect_instance.main.id
  name     = "my-key-protect-policy"
  # Define the policy rules
  rules = ["key:read", "key:write"]
}

# Create a Key Protect secret
resource "ibm_key_protect_secret" "main" {
  instance_id = ibm_key_protect_instance.main.id
  name     = "my-key-protect-secret"
  key_id     = ibm_key_protect_key.main.id
  # Define the secret value
  value = "my-secret-value"
}
  
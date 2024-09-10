
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "your_api_key"
}

# Create a Secret
resource "ibm_secrets_manager_secret" "main" {
  name   = "my-secret"
  secret = "my-secret-value"

  # Optional: Set tags for the secret
  tags = {
    environment = "dev"
  }
}

# Get a secret value
output "secret_value" {
  value = ibm_secrets_manager_secret.main.secret
}
  
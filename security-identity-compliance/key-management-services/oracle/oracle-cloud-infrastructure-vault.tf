
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Configure the authentication credentials (replace with your values)
  # You can use environment variables, a profile, or directly set the credentials
  # Refer to the official Terraform documentation for more details
  # https://registry.terraform.io/providers/hashicorp/oci/latest/docs
}

# Create a Vault
resource "oci_vault_vault" "main" {
  # Replace with a unique name
  name = "my-vault"
  # The compartment ID where the vault should be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Define the vault lifecycle policy, either "ACTIVE" or "INACTIVE"
  lifecycle_state = "ACTIVE"
  # Enable or disable the Vault
  is_enabled = true
}

# Create a Key
resource "oci_vault_key" "main" {
  # Replace with a unique name
  name = "my-key"
  # The vault ID where the key should be created
  vault_id = oci_vault_vault.main.id
  # Specify the key type, e.g. "RSA2048", "EC_P256"
  key_type = "RSA2048"
  # Define the key lifecycle policy, either "ACTIVE" or "INACTIVE"
  lifecycle_state = "ACTIVE"
  # Optional - If you need to specify a specific key version
  # key_version = 1
  # Optional - Set a description for the key
  description = "My Key"
}

  
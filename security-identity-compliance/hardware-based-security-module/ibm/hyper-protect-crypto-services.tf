
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create a Hyper Protect Crypto Services instance
resource "ibm_hpc_instance" "main" {
  name = "my-hpc-instance"
  location = "us-south"
  # Optionally specify the number of cores and memory for the instance
  # cores = 2
  # memory = 4
}

# Create a key vault
resource "ibm_hpc_key_vault" "main" {
  name = "my-key-vault"
  location = "us-south"
  # Assign the key vault to the HPC instance
  instance_id = ibm_hpc_instance.main.id
}

# Create a key
resource "ibm_hpc_key" "main" {
  name = "my-key"
  key_type = "RSA"
  # Set the key length
  # key_length = 2048
  # Specify the key vault to store the key in
  vault_id = ibm_hpc_key_vault.main.id
}

# Create a key policy
resource "ibm_hpc_key_policy" "main" {
  key_id = ibm_hpc_key.main.id
  # Specify the policy to apply to the key
  # policy = jsonencode({ ... })
}

  

    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaz45fqz7u"
  user    = "ocid1.user.oc1..aaaaaaaaz5r57c7o"
  key_file = "~/.oci/config"
}

# Create a vault
resource "oci_vault_vault" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7472j56"
  display_name   = "my-vault"
  # Optional: Specify a description for the vault
  # description = "This is my vault"
}

# Create a secret in the vault
resource "oci_vault_secret" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7472j56"
  vault_id       = oci_vault_vault.example.id
  display_name   = "my-secret"
  # Optional: Specify a description for the secret
  # description = "This is my secret"
  # Optional: Set the secret content (value)
  # content = "secret_value"
}

# Create a secret version
resource "oci_vault_secret_version" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7472j56"
  vault_id       = oci_vault_vault.example.id
  secret_id      = oci_vault_secret.example.id
  # Optional: Set the secret version content
  # content = "secret_version_value"
}

# Create a policy to grant access to the vault
resource "oci_identity_policy" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7472j56"
  name           = "my-vault-policy"
  statements     = <<EOF
Allow group "ocid1.group.oc1..aaaaaaaaz7472j56" to manage vault in compartment "ocid1.compartment.oc1..aaaaaaaaz7472j56"
EOF
}

  
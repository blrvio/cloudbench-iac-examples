
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
}

# Crie um cofre
resource "oci_vault_vault" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaabbbbbbbbbbbbbb"
  name          = "vault-name"
  description   = "Example vault"
}

# Crie uma chave
resource "oci_vault_key" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaabbbbbbbbbbbbbb"
  vault_id      = oci_vault_vault.example.id
  key_shape      = "2048"
  description   = "Example key"
  key_type      = "RSA"
}

# Crie uma política para controlar o acesso à chave
resource "oci_vault_policy" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaabbbbbbbbbbbbbb"
  statements  = [{"effect": "Allow", "actions": ["vault:ReadKey", "vault:Decrypt", "vault:Sign", "vault:Verify"], "resources": ["ocid1.key.oc1..aaaaaaaaaaaaabbbbbbbbbbbbbb"]}]
}
    
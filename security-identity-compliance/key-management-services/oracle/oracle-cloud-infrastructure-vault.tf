
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaayxxxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaayxxxxxxxx"
  fingerprint = "xxxx"

  # Configure as variáveis de ambiente
  # region = var.region
  # tenancy = var.tenancy
  # user = var.user
  # fingerprint = var.fingerprint
}

# Crie um cofre
resource "oci_kms_vault" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaayxxxxxxxx"
  name           = "example-vault"
  description    = "Example vault"
  # Optional attributes
  # kms_key_id = oci_kms_key.example.id
}

# Crie uma chave
resource "oci_kms_key" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaayxxxxxxxx"
  vault_id       = oci_kms_vault.example.id
  name           = "example-key"
  description    = "Example key"
  # Optional attributes
  # kms_key_version_id = oci_kms_key_version.example.id
  # kms_key_type = "AES_256_GCM"
  # kms_key_purpose = "ENCRYPT_DECRYPT"
  # kms_key_state = "ENABLED"
}

# Crie uma versão de chave
resource "oci_kms_key_version" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaayxxxxxxxx"
  kms_key_id    = oci_kms_key.example.id
  # Optional attributes
  # kms_key_version_state = "ENABLED"
}
    
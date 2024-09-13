
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaw7w7q6y"
  user    = "user_ocid"
  key     = "key_content"
}

# Crie um grupo de usuários
resource "oci_identity_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7w7q6y"
  name           = "example-group"
  description    = "Example group"
}

# Crie um usuário
resource "oci_identity_user" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7w7q6y"
  name           = "example-user"
  description    = "Example user"
}

# Adicione o usuário ao grupo
resource "oci_identity_group_membership" "example" {
  group_id = oci_identity_group.example.id
  user_id  = oci_identity_user.example.id
}
    
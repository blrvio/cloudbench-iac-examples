
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  # (Opcional) Forneça as credenciais para autenticação
  # tenancy_id = "ocid1.tenancy.oc1..."
  # user_ocid   = "ocid1.user.oc1..."
  # fingerprint = "xxxxxxxxxxxxxxxx"
  # private_key = "..."
}

# Crie um diretório
resource "oci_identity_directory" "example" {
  compartment_id = "ocid1.compartment.oc1..." # Substitua pelo ID do compartimento
  display_name  = "My Directory"
}

# Crie um usuário no diretório
resource "oci_identity_user" "example" {
  directory_id = oci_identity_directory.example.id
  display_name  = "john.doe"
}

# Atribua uma política ao usuário
resource "oci_identity_policy_attachment" "example" {
  policy_id   = "ocid1.policy.oc1..." # Substitua pelo ID da política
  target_type = "user"
  target_id   = oci_identity_user.example.id
}
    
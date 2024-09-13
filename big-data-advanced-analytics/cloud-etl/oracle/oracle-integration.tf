
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
}

# Crie um novo recurso de integração
resource "oci_integration_integration" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name  = "My Integration"
  # Descrição do recurso de integração
  description = "Integration for example purpose"
}

# Crie uma nova conexão de integração
resource "oci_integration_connection" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  integration_id = oci_integration_integration.example.id
  display_name  = "My Connection"
  # Descrição da conexão
  description = "Connection for example purpose"
  # Definição da conexão
  connection_definition = <<EOF
# Definição da conexão em formato JSON
EOF
}
    
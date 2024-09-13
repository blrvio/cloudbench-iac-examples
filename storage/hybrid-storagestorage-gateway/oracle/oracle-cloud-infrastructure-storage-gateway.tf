
      ## Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"

  # Substitua pelos seus valores reais
  # Use variáveis para manter as credenciais seguras
  # Exemplo:
  #   tenancy = var.tenancy_id
  #   user     = var.user_ocid
  #   key      = var.api_key
}

## Crie um Gateway de Armazenamento
resource "oci_core_storage_gateway" "example" {
  compartment_id     = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name      = "Storage Gateway Example"
  source_endpoint_id = "ocid1.endpoint.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Substitua pelos seus valores reais
}

## Crie um ponto de montagem para o Gateway de Armazenamento
resource "oci_core_storage_gateway_mount_target" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  storage_gateway_id = oci_core_storage_gateway.example.id
  display_name     = "Storage Gateway Mount Target"
  # Substitua pelos seus valores reais
}
    
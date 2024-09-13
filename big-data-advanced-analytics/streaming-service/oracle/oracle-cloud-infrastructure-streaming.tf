
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  # Substitua pelos seus credenciais do OCI
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user_ocid  = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Crie um stream
resource "oci_streaming_stream" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx" # Substitua pelo ID do compartimento
  name          = "example-stream"
  # ... outras configurações
}

# Crie um consumidor
resource "oci_streaming_consumer" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx" # Substitua pelo ID do compartimento
  stream_id     = oci_streaming_stream.example.id
  name          = "example-consumer"
  # ... outras configurações
}

# Crie um produtor
resource "oci_streaming_producer" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx" # Substitua pelo ID do compartimento
  stream_id     = oci_streaming_stream.example.id
  name          = "example-producer"
  # ... outras configurações
}
    
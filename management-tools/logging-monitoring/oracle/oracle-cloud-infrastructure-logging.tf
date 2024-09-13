
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx" # Substitua pelo ID da sua tenancy
  user_ocid  = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx" # Substitua pelo ID do seu usuário
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Substitua pela sua fingerprint
}

# Crie um log group
resource "oci_logging_log_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx" # Substitua pelo ID do seu compartimento
  display_name = "my-log-group"
}

# Crie um log
resource "oci_logging_log" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx" # Substitua pelo ID do seu compartimento
  log_group_id  = oci_logging_log_group.example.id
  display_name = "my-log"
}

# Crie uma regra de log
resource "oci_logging_log_rule" "example" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx" # Substitua pelo ID do seu compartimento
  display_name     = "my-log-rule"
  log_group_id     = oci_logging_log_group.example.id
  log_id           = oci_logging_log.example.id
  description      = "My log rule"
  action           = "WRITE"
  lifecycle_state = "ENABLED"
}

    
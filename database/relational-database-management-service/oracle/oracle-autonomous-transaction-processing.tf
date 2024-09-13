
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
  # Adicione credenciais para o OCI
}

# Crie uma instância do Autonomous Transaction Processing
resource "oci_database_autonomous_database" "atp_instance" {
  # Substitua por valores reais
  admin_password      = "<ADMIN_PASSWORD>"
  autonomous_database_name = "atp-instance"
  compartment_id     = "<COMPARTMENT_ID>"
  db_version            = "19c"
  # Configure a network
  # Substitua por valores reais
  subnet_id           = "<SUBNET_ID>"
  # Opcional: Especifique o tipo de banco de dados
  # "SHARED" para um ambiente compartilhado
  # "DEDICATED" para um ambiente dedicado
  edition              = "SHARED"
}

    
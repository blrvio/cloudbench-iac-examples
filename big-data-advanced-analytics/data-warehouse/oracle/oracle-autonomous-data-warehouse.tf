
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  # Adicione suas credenciais de autenticação
}

# Crie um Autonomous Data Warehouse
resource "oci_database_autonomous_database" "adw" {
  admin_password = "password" # Substitua por uma senha forte
  admin_username = "admin" # Substitua pelo nome de usuário desejado
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaabbbbbbbbcccccccc"
  # O ID do compartimento onde o ADW será criado
  database_edition = "ENTERPRISE_EDITION" # Substitua pela edição desejada
  # (ENTERPRISE_EDITION | STANDARD_EDITION_2) 
  db_name         = "myadw" # Nome do ADW
  db_workload     = "OLTP" # Substitua pelo tipo de carga de trabalho desejado
  # (OLTP | DW) 
  # ... 
}

    
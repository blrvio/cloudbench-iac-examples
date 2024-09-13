
      # Configure o provedor do Oracle Cloud
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
}

# Crie uma rede virtual privada (VPC)
resource "oci_core_vcn" "main_vcn" {
  cidr_block = "10.0.0.0/16"
  # Substitua pelo bloco CIDR desejado
  display_name = "main-vcn"
  # Substitua pelo nome desejado
}

# Crie uma sub-rede na VPC
resource "oci_core_subnet" "main_subnet" {
  vcn_id = oci_core_vcn.main_vcn.id
  cidr_block = "10.0.1.0/24"
  # Substitua pelo bloco CIDR desejado
  display_name = "main-subnet"
  # Substitua pelo nome desejado
}

# Crie uma instância do Autonomous Data Warehouse
resource "oci_database_autonomous_database" "main_adb" {
  admin_password = "<password>"
  # Substitua por uma senha forte
  # Substitua pela edição desejada (Standard ou Enterprise)
  edition = "ENTERPRISE"
  # Substitua pela versão desejada (19c ou 21c)
  database_version = "19c"
  # Substitua pelo tipo de banco de dados (shared ou dedicated)
  database_type = "DEDICATED"
  # Substitua pelo tamanho da instância desejado
  data_storage_size_in_tbs = 100
  # Substitua pelo nome desejado
  display_name = "main-adb"
  # Substitua pelo nome do compartimento desejado
  compartment_id = "ocid1.compartment.oc1...."
  # Substitua pelo nome do grupo de segurança desejado
  # Pode ser necessário criar um grupo de segurança primeiro
  # Caso contrário, deixe vazio para usar o padrão
  nsg_ids = ["<nsg_id>"]
  # Substitua pelo nome da sub-rede desejada
  subnet_id = oci_core_subnet.main_subnet.id
}
    
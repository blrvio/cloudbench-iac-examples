
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo seu tenancy OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo seu user OCID
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # Substitua pela sua fingerprint da chave
  private_key_path = "~/.oci/oci_api_key.pem"
  # Substitua pelo caminho da chave privada
}

# Crie um data warehouse
resource "oci_data_warehouse_data_warehouse" "dw" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID do compartimento
  display_name  = "my-data-warehouse"
  # Substitua pelo nome do data warehouse
  shape_name     = "DW.Standard.1"
  # Substitua pelo nome do shape desejado
}

# Crie um usuário do data warehouse
resource "oci_data_warehouse_user" "user" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID do compartimento
  data_warehouse_id = oci_data_warehouse_data_warehouse.dw.id
  display_name   = "my-user"
  # Substitua pelo nome do usuário
}

# Crie uma conexão de rede
resource "oci_data_warehouse_network_connection" "network_connection" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID do compartimento
  data_warehouse_id = oci_data_warehouse_data_warehouse.dw.id
  display_name   = "my-network-connection"
  # Substitua pelo nome da conexão de rede
  subnet_id       = "ocid1.subnet.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID da subnet
}

# Crie um banco de dados
resource "oci_data_warehouse_database" "database" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID do compartimento
  data_warehouse_id = oci_data_warehouse_data_warehouse.dw.id
  display_name   = "my-database"
  # Substitua pelo nome do banco de dados
}

# Crie um esquema
resource "oci_data_warehouse_schema" "schema" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID do compartimento
  data_warehouse_id = oci_data_warehouse_data_warehouse.dw.id
  display_name   = "my-schema"
  # Substitua pelo nome do esquema
}

# Crie uma tabela
resource "oci_data_warehouse_table" "table" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Substitua pelo ID do compartimento
  data_warehouse_id = oci_data_warehouse_data_warehouse.dw.id
  display_name   = "my-table"
  # Substitua pelo nome da tabela
  schema_name     = oci_data_warehouse_schema.schema.display_name
  # Substitua pelo nome do schema
}

    
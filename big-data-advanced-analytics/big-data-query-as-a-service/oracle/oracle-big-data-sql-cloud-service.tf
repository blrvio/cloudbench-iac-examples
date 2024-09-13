
      # Configure o provedor do Oracle Cloud
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaab4v4y4"
  user    = "ocid1.user.oc1..aaaaaaaaw7i6n7a"
  fingerprint = "xxxxxxx"
}

# Crie um Data Warehouse
resource "oci_database_datawarehouse" "datawarehouse" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab4v4y4"
  display_name  = "my-datawarehouse"
  shape          = "VM.Standard2.1"
  source         = "BIGDATA_SQL"
  source_type    = "DATA_WAREHOUSE"
}

# Crie um usuário do banco de dados
resource "oci_database_user" "user" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab4v4y4"
  display_name  = "my-user"
  data_warehouse_id = oci_database_datawarehouse.datawarehouse.id
  password = "my-password"
}

# Crie uma tabela no data warehouse
resource "oci_database_table" "my_table" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab4v4y4"
  display_name  = "my_table"
  data_warehouse_id = oci_database_datawarehouse.datawarehouse.id
  columns = [{"name": "id", "data_type": "NUMBER", "nullable": false}, {"name": "name", "data_type": "VARCHAR", "nullable": false}]
}

# Crie um esquema no data warehouse
resource "oci_database_schema" "my_schema" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab4v4y4"
  display_name  = "my_schema"
  data_warehouse_id = oci_database_datawarehouse.datawarehouse.id
}

    
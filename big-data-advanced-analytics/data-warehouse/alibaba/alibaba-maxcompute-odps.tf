
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  # Substitua as credenciais de acesso e região
  access_key  = "AKIAXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  region      = "cn-hangzhou"
}

# Crie um projeto MaxCompute
resource "alicloud_odps_project" "example" {
  name = "example-project"
}

# Crie um banco de dados MaxCompute
resource "alicloud_odps_database" "example" {
  name = "example_database"
  project = alicloud_odps_project.example.id
}

# Crie uma tabela MaxCompute
resource "alicloud_odps_table" "example" {
  name = "example_table"
  database = alicloud_odps_database.example.name
  project = alicloud_odps_project.example.id
  columns = <<EOF
  {"name": "id", "type": "BIGINT", "comment": "ID"}
  {"name": "name", "type": "STRING", "comment": "Nome"}
  EOF
}

    
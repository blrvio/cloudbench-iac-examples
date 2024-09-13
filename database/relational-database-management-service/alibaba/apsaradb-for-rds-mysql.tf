
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  region = "cn-hangzhou"
}

# Crie um banco de dados MySQL
resource "alicloud_rds_instance" "mysql_db" {
  engine = "MySQL"
  engine_version = "5.7"
  instance_type = "rds.mysql.t1.small"
  instance_charge_type = "Postpaid"
  storage = 10
  connection_mode = "Public"
  security_group_ids = ["sg-xxxxxxxx"]
  db_name = "my_database"
  db_instance_class = "Basic"

  tags = {
    Name = "My MySQL Database"
  }
}

# Crie um usuário do banco de dados
resource "alicloud_rds_account" "mysql_user" {
  db_instance_id = alicloud_rds_instance.mysql_db.id
  account_name = "my_user"
  account_password = "my_password"
  account_type = "Normal"
}
    
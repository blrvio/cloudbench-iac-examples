
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  region = "cn-hangzhou" # Substitua pela sua região desejada
}

# Crie um instance do ApsaraDB for RDS SQL Server
resource "alicloud_rds_instance" "db_instance" {
  engine                  = "SQLServer"
  engine_version          = "2017_Standard"
  instance_type           = "rds.mysql.t1.small"
  instance_charge_type    = "Postpaid"
  instance_network_type   = "VPC"
  db_instance_class       = "basic"
  db_instance_storage     = 20
  payment_type           = "PayAsYouGo"
  storage_type            = "cloud_essd"
  vpc_id                   = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  vswitch_id               = "vswitch-xxxxxxxx" # Substitua pelo ID da sua VSwitch
  connection_mode         = "Public"
  db_name                  = "mydatabase"
  db_instance_description  = "My RDS SQL Server instance"
  security_ip_list        = ["0.0.0.0/0"]
  availability_zone_id    = "cn-hangzhou-a"
  port                     = 1433
  password                 = "password"
}

# Crie um usuário do banco de dados
resource "alicloud_rds_account" "db_user" {
  account_name = "db_user"
  account_password = "password"
  db_instance_id   = alicloud_rds_instance.db_instance.id
  account_type     = "normal"
}

# Crie uma regra de segurança para o banco de dados
resource "alicloud_rds_security_group" "db_security_group" {
  security_group_name = "db_security_group"
  security_group_description = "Security group for RDS SQL Server"
  vpc_id                 = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  security_group_rule {
    type = "ingress"
    from_port = 1433
    to_port = 1433
    ip_protocol = "tcp"
    cidr_ip = "0.0.0.0/0"
  }
}

# Crie uma regra de segurança para o banco de dados
resource "alicloud_rds_security_group_rule" "db_security_group_rule" {
  db_instance_id = alicloud_rds_instance.db_instance.id
  security_group_id = alicloud_rds_security_group.db_security_group.id
  db_instance_port = 1433
}

    
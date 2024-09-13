
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  region = "cn-hangzhou" # Substitua pela sua região desejada
}

# Crie um banco de dados ApsaraDB for RDS PostgreSQL
resource "alicloud_rds_instance" "postgres_db" {
  engine           = "PostgreSQL"
  engine_version   = "12"
  instance_type    = "rds.pg.s1.small"
  instance_charge_type = "PostPaid"
  database_name     = "my_database"
  database_password = "password123"
  vpc_id           = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  vswitch_id        = "vswitch-xxxxxxxx" # Substitua pelo ID da sua VSwitch
  security_group_ids = ["sg-xxxxxxxx"] # Substitua pelo ID do seu grupo de segurança
  tags = {
    Name = "My PostgreSQL Database"
  }
}

# Crie um usuário do banco de dados
resource "alicloud_rds_account" "postgres_user" {
  db_instance_id  = alicloud_rds_instance.postgres_db.id
  account_name    = "postgres_user"
  account_password = "password123"
  account_type     = "Normal"
}

# Conceda permissões ao usuário do banco de dados
resource "alicloud_rds_privilege" "postgres_user_permissions" {
  db_instance_id = alicloud_rds_instance.postgres_db.id
  account_name    = alicloud_rds_account.postgres_user.account_name
  db_name         = alicloud_rds_instance.postgres_db.database_name
  privilege        = "SUPER"
  host             = "%"
}

    

      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma instância do AWS DMS
resource "aws_dms_replication_instance" "dms_instance" {
  replication_instance_identifier = "dms-instance-example"
  engine_version = "3.5.1"
  allocated_storage = 100
  publicly_accessible = false
  replication_task_count = 1
  vpc_security_group_ids = ["sg-xxxxxxxx"] # Substitua pelo ID do grupo de segurança da VPC
  multi_az = false
  engine_name = "postgresql"

  tags = {
    Name = "DMS Instance"
  }
}

# Crie uma tarefa de replicação para migrar dados do PostgreSQL para o MySQL
resource "aws_dms_replication_task" "postgre_to_mysql" {
  replication_task_identifier = "postgre_to_mysql"
  migration_type = "full"
  replication_instance_arn = aws_dms_replication_instance.dms_instance.replication_instance_arn
  source_endpoint_arn = aws_dms_endpoint.postgre_endpoint.endpoint_arn
  target_endpoint_arn = aws_dms_endpoint.mysql_endpoint.endpoint_arn
  table_mappings = <<EOF
{"rules": [{"rule-type": "selection", "rule-id": "1", "rule-name": "all", "object-locator": {"schema-name": "public", "table-name": "*"}, "rule-action": "include"}], "rule-groups": []}
EOF
}

# Crie um endpoint de origem (PostgreSQL)
resource "aws_dms_endpoint" "postgre_endpoint" {
  endpoint_id = "postgre_endpoint"
  endpoint_type = "source"
  engine_name = "postgresql"
  server_name = "postgre_server_address"
  port = 5432
  username = "postgre_user"
  password = "postgre_password"
  database_name = "postgre_database"
}

# Crie um endpoint de destino (MySQL)
resource "aws_dms_endpoint" "mysql_endpoint" {
  endpoint_id = "mysql_endpoint"
  endpoint_type = "target"
  engine_name = "mysql"
  server_name = "mysql_server_address"
  port = 3306
  username = "mysql_user"
  password = "mysql_password"
  database_name = "mysql_database"
}

    
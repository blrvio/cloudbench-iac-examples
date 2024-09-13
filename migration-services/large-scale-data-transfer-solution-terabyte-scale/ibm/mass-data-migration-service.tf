
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie uma instância do serviço DMS
resource "aws_dms_replication_instance" "example" {
  allocation_group       = "default"
  apply_immediately     = true
  availability_zone      = "us-east-1a"
  engine_version         = "3.4.7"
  multi_az               = false
  replication_instance_id = "dms-example"
  replication_instance_class = "dms.t2.micro"
  replication_subnet_group_id = "dms-example-subnet-group"
  vpc_security_group_ids = ["sg-xxxxxxxx"]
}

# Crie um grupo de sub-redes para o serviço DMS
resource "aws_dms_replication_subnet_group" "example" {
  replication_subnet_group_description = "Example DMS subnet group"
  replication_subnet_group_id     = "dms-example-subnet-group"
  subnet_ids                         = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
}

# Crie uma tarefa de migração
resource "aws_dms_replication_task" "example" {
  replication_task_id  = "dms-example-task"
  replication_instance_arn = aws_dms_replication_instance.example.replication_instance_arn
  migration_type       = "full"
  source_endpoint_arn  = aws_dms_endpoint.source.arn
  target_endpoint_arn = aws_dms_endpoint.target.arn
  table_mappings        = <<EOF
  { "rules": [ { "rule-type": "selection", "rule-name": "all", "rule-id": "1", "rule-action": "include", "selection-type": "full-table", "logical-operator": "AND", "rule-filters": [ { "filter-type": "source-table-name", "filter-value": "table_name" } ] } ] }
EOF
}

# Crie um endpoint de origem
resource "aws_dms_endpoint" "source" {
  endpoint_id  = "dms-example-source"
  endpoint_type = "source"
  engine_name    = "mysql"
  username       = "username"
  password       = "password"
  hostname       = "hostname"
  port           = 3306
}

# Crie um endpoint de destino
resource "aws_dms_endpoint" "target" {
  endpoint_id  = "dms-example-target"
  endpoint_type = "target"
  engine_name    = "postgresql"
  username       = "username"
  password       = "password"
  hostname       = "hostname"
  port           = 5432
}
    
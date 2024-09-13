
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um broker Amazon MQ
resource "aws_mq_broker" "main" {
  broker_name = "my-mq-broker"
  engine       = "ActiveMQ"
  engine_version = "5.15.10"
  host_instance_type = "mq.t2.medium"
  publicly_accessible = true
  security_groups = ["sg-xxxxxxxx"] # Substitua pelo ID do seu grupo de segurança
  user            = "admin"
  password          = "my-password" # Substitua por uma senha forte
  deployment_mode = "SINGLE_INSTANCE"
}

# Crie uma senha para o usuário do broker
resource "aws_mq_user" "admin" {
  broker_id = aws_mq_broker.main.id
  username  = "admin"
  password  = "my-password" # Substitua por uma senha forte
}

# Crie uma configuração de segurança
resource "aws_mq_configuration" "main" {
  broker_id = aws_mq_broker.main.id
  name       = "my-mq-configuration"
  description = "Configuração de segurança do broker"
  engine       = "ActiveMQ"
  engine_version = "5.15.10"

  configuration_properties = <<EOF
# Configure as propriedades do broker aqui
EOF
}

# Crie um acesso de usuário
resource "aws_mq_user" "main" {
  broker_id = aws_mq_broker.main.id
  username  = "my-user"
  password  = "my-password" # Substitua por uma senha forte
}

# Crie uma política de acesso para o usuário
resource "aws_mq_user_policy" "main" {
  broker_id = aws_mq_broker.main.id
  user_name  = aws_mq_user.main.username
  policy     = <<EOF
# Configure a política de acesso aqui
EOF
}

    
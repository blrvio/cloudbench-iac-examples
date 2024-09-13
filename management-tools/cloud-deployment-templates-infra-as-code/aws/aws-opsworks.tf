
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um stack OpsWorks
resource "aws_opsworks_stack" "main" {
  name    = "my-opsworks-stack"
  region  = "us-east-1"
  service_role_arn = "arn:aws:iam::123456789012:role/opsworks_service_role"
  # ... (outras configurações, como VPC, subredes, etc.)
}

# Crie um layer OpsWorks
resource "aws_opsworks_layer" "custom_layer" {
  name         = "Custom Layer"
  stack_id     = aws_opsworks_stack.main.id
  shortname    = "custom"
  type         = "custom"
  # ... (outras configurações, como receita, volume, etc.)
}

# Crie uma instância OpsWorks
resource "aws_opsworks_instance" "web_server" {
  layer_ids   = [aws_opsworks_layer.custom_layer.id]
  stack_id     = aws_opsworks_stack.main.id
  instance_type = "t2.micro"
  # ... (outras configurações, como AMI, segurança, etc.)
}

# Crie um aplicativo OpsWorks
resource "aws_opsworks_app" "my_app" {
  name          = "my-opsworks-app"
  stack_id      = aws_opsworks_stack.main.id
  shortname    = "my-app"
  type          = "rails"
  # ... (outras configurações, como repositório, etc.)
}
    
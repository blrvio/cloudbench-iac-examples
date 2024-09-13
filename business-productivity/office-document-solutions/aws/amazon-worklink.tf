
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um domínio WorkLink
resource "aws_worklink_fleet" "main" {
  name   = "worklink-fleet"
  fleet_name = "worklink-fleet"
  directory_id  = "d-xxxxxxxx" # Substitua pelo ID do seu diretório
  company_code   = "xxxxxxxx" # Substitua pelo código da sua empresa
  identity_provider {
    type     = "cognito" # Substitua pelo tipo de provedor de identidade
    cognito_identity_provider {
      user_pool_arn = "arn:aws:cognito-idp:us-east-1:123456789012:userpool/us-east-1_XXXXXXXX" # Substitua pelo ARN do seu pool de usuários Cognito
    }
  }
  audit_stream {
    s3_bucket = "bucket-name" # Substitua pelo nome do bucket S3
    s3_prefix  = "worklink-audit-logs" # Substitua pelo prefixo do log
  }
  network {
    vpc_id     = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
    subnet_ids = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das suas sub-redes
  }
}

# Crie uma aplicação WorkLink
resource "aws_worklink_web_url" "main" {
  fleet_arn = aws_worklink_fleet.main.arn
  company_code   = aws_worklink_fleet.main.company_code
  url         = "https://www.example.com" # Substitua pela URL da sua aplicação
}

# Crie uma associação WorkLink
resource "aws_worklink_association" "main" {
  fleet_arn = aws_worklink_fleet.main.arn
  user_arn   = "arn:aws:iam::123456789012:user/user-name" # Substitua pelo ARN do seu usuário IAM
}

    
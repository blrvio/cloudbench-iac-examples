
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma regra de configuração
resource "aws_config_rule" "s3_bucket_encryption" {
  name = "S3BucketEncryption"
  source {
    owner = "AWS"
    source_identifier = "S3_BUCKET_ENCRYPTION"
  }
  input_parameters = {
    # Substitua por parâmetros de configuração específicos
  }
  description = "Garantir que todos os buckets S3 sejam criptografados"
}

# Crie um registro de entrega de configurações
resource "aws_config_delivery_channel" "default" {
  name = "default"
  s3_bucket_name = "bucket-name" # Substitua pelo nome do bucket S3
  s3_key_prefix = "config"
}

# Crie uma avaliação de conformidade
resource "aws_config_compliance_evaluation" "s3_bucket_encryption_evaluation" {
  config_rule_name = aws_config_rule.s3_bucket_encryption.name
}

    
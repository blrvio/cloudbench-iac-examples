
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um registro de acesso
resource "aws_access_transparency_access_log" "example" {
  target_id = "target-id"
  name = "example"
  vpc_id = "vpc-xxxxxxxx"
}

# Crie um gravador de acesso
resource "aws_access_transparency_access_log_recorder" "example" {
  name = "example"
  vpc_id = "vpc-xxxxxxxx"
  logging_status = "ENABLED"
}

# Crie um gravador de acesso que exporta logs para um bucket do S3
resource "aws_access_transparency_access_log_recorder" "example" {
  name = "example"
  vpc_id = "vpc-xxxxxxxx"
  logging_status = "ENABLED"
  s3_export {
    bucket = "example"
    prefix = "access-logs"
  }
}
    
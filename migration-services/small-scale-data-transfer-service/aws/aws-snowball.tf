
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um job de Snowball
resource "aws_snowball_job" "example" {
  description = "My Snowball job"
  job_type    = "IMPORT"
  resources   = [{"s3_bucket": "my-bucket", "s3_prefix": "my-prefix"}]
  # ... (opções adicionais, como número de dispositivos)
}

# Crie um endereço de envio
resource "aws_snowball_address" "example" {
  job_id = aws_snowball_job.example.id
  name   = "My shipping address"
  # ... (informações do endereço)
}

# Crie um endereço de retorno
resource "aws_snowball_address" "example_return" {
  job_id = aws_snowball_job.example.id
  name   = "My return address"
  # ... (informações do endereço)
}

# Crie um usuário no AWS Snowball
resource "aws_snowball_user" "example" {
  job_id     = aws_snowball_job.example.id
  email       = "my-user@example.com"
  role        = "USER"
  password    = "my-password"
  is_admin    = false
  is_password_reset_required = false
}

# Crie uma política de Snowball
resource "aws_snowball_policy" "example" {
  job_id = aws_snowball_job.example.id
  policy  = "{\"Version\": \"2012-10-17\", \"Statement\": [{\"Effect\": \"Allow\", \"Principal\": {\"AWS\": \"arn:aws:iam::123456789012:user/my-user\"}, \"Action\": [\"snowball:DescribeJob\", \"snowball:ListJobs\", \"snowball:UpdateJob\", \"snowball:CancelJob\"]}]}"
}

    
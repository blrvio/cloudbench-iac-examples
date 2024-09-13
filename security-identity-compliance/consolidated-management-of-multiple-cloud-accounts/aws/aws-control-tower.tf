
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Configure o provedor do Control Tower
provider "aws-controltower" {
  account_id = "xxxxxxxx"
  region     = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma conta gerenciada pelo Control Tower
resource "aws_controltower_account" "managed_account" {
  email        = "example@example.com" # Substitua pelo email da conta
  account_name = "managed-account"

  # ... outras configurações de conta
}

# Crie uma conta gerenciada pelo Control Tower
resource "aws_controltower_enabled_service" "guardduty" {
  service_name = "GuardDuty"
}

# Crie uma conta gerenciada pelo Control Tower
resource "aws_controltower_organizational_unit" "ou_development" {
  name = "Development"
  parent_id  = aws_controltower_organizational_unit.ou_root.id
}

# Crie uma conta gerenciada pelo Control Tower
resource "aws_controltower_organizational_unit" "ou_root" {
  name = "Root"
}

# Crie uma conta gerenciada pelo Control Tower
resource "aws_controltower_policy" "iam_policy" {
  name = "iam-policy"
  content = "# Exemplo de política IAM
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::xxxxxxxx:root"
        },
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": [
          "arn:aws:s3:::my-bucket/*"
        ]
      }
    ]
  }"
}
    
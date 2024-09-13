
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um chave KMS
resource "aws_kms_key" "default" {
  description = "Chave KMS para criptografia de dados"
  enable_key_rotation = true
}

# Crie uma chave KMS com chave mestre
resource "aws_kms_key" "master_key" {
  description = "Chave KMS com chave mestre"
  enable_key_rotation = true
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow access to IAM user",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:user/example-user"
      },
      "Action": [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:ReEncryptFrom",
        "kms:ReEncryptTo",
        "kms:GenerateDataKeyWithoutPlaintext",
        "kms:DescribeKey",
        "kms:GetKeyPolicy",
        "kms:GetParametersForImport",
        "kms:ImportKeyMaterial"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

# Crie uma chave KMS com um alias
resource "aws_kms_alias" "default" {
  name = "alias/example-alias"
  target_key_id = aws_kms_key.default.id
}
    
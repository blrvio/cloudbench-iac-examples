
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma chave KMS
resource "aws_kms_key" "my_key" {
  description = "My KMS key"
  enable_key_rotation = true
}

# Crie uma política de chave KMS
resource "aws_kms_key_policy" "my_key_policy" {
  key_id     = aws_kms_key.my_key.id
  policy     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow access for specific user",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:user/my_user"
      },
      "Action": [
        "kms:DescribeKey",
        "kms:EnableKeyRotation",
        "kms:DisableKeyRotation",
        "kms:GetKeyPolicy",
        "kms:GetPublicKey",
        "kms:ListAliases",
        "kms:ListGrants",
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyWithoutPlaintext",
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncryptFrom",
        "kms:ReEncryptTo",
        "kms:CreateGrant",
        "kms:RevokeGrant",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

    
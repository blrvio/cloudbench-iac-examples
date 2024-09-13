
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um vault Glacier
resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"
  acl    = "private"

  tags = {
    Name = "example-bucket"
  }
}

# Crie uma política para o vault
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.bucket
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGlacierAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "s3:GetBucketLocation",
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
POLICY
}

# Crie uma regra de ciclo de vida para o vault
resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example.bucket
  rule {
    id     = "archive_old_objects"
    status = "Enabled"
    prefix = "old-objects/"
    transition {
      days   = 365
      storage_class = "GLACIER"
    }
  }
}
    
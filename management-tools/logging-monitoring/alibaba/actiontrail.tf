
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Trail
resource "aws_cloudtrail" "default" {
  name = "my-trail"
  s3_bucket_name = "my-bucket-name" # Substitua pelo nome do bucket S3
  is_multi_region_trail = true
  include_global_service_events = true
  enable_log_file_validation = true

  # Configure eventos para registro
  event_selector {
    read_write_type  = ["Read", "Write"] # Substitua pelos tipos de eventos desejados
    data_resources    = ["s3:Bucket"] # Substitua pelos recursos desejados
    include_management_events = true
  }
}

# Crie um bucket S3
resource "aws_s3_bucket" "default" {
  bucket = "my-bucket-name" # Substitua pelo nome do bucket S3

  # Configure acesso para CloudTrail
  acl = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Crie uma política para o bucket S3
resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.default.bucket
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudTrailAccess",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": [
        "s3:GetBucketAcl",
        "s3:GetBucketLocation",
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.default.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.default.bucket}/*"
      ]
    }
  ]
}
POLICY
}
    
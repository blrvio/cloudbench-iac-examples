
      # Configure o provedor (ex: AWS, GCP, Azure)
provider "aws" {
  region = "us-east-1"
}

# Crie um bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"
  acl    = "private"
}

# Crie um objeto no bucket
resource "aws_s3_bucket_object" "my_object" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "my-object.txt"
  source = "my-object.txt"
}
    
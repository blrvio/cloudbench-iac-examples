
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um bucket S3
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name" # Substitua pelo nome do seu bucket
  acl    = "private" # Defina a ACL do bucket
}

# Crie um objeto S3
resource "aws_s3_bucket_object" "my_object" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "my-object.txt" # Substitua pelo nome do seu objeto
  source = "my-object.txt" # Substitua pelo caminho para o seu arquivo local
}
    
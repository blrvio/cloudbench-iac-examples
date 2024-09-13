
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma réplica de servidor
resource "aws_s3_bucket" "source_bucket" {
  bucket = "source-bucket-name" # Substitua pelo nome do bucket de origem
  acl    = "private"
}

resource "aws_s3_bucket_object" "source_object" {
  bucket = aws_s3_bucket.source_bucket.id
  key    = "source-object-key" # Substitua pelo nome do objeto de origem
  source = "path/to/source-object" # Substitua pelo caminho do objeto de origem
}

resource "aws_s3_bucket" "target_bucket" {
  bucket = "target-bucket-name" # Substitua pelo nome do bucket de destino
  acl    = "private"
}

resource "aws_s3_bucket_object" "target_object" {
  bucket = aws_s3_bucket.target_bucket.id
  key    = "target-object-key" # Substitua pelo nome do objeto de destino
  source = aws_s3_bucket_object.source_object.id
}
    
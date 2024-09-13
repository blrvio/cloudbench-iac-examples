
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um container MediaStore
resource "aws_mediastore_container" "example" {
  name = "example"
}

# Crie um endpoint MediaStore
resource "aws_mediastore_endpoint" "example" {
  container_name = aws_mediastore_container.example.name
}

# Crie uma política de acesso MediaStore
resource "aws_mediastore_policy" "example" {
  container_name = aws_mediastore_container.example.name
  policy         = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "mediastore:PutObject",
        "mediastore:GetObject",
        "mediastore:ListObjects"
      ],
      "Resource": "arn:aws:mediastore:us-east-1:123456789012:container/example/*"
    }
  ]
}
POLICY
}
    
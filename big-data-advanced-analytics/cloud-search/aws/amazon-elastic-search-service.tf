
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um domínio Elasticsearch
resource "aws_elasticsearch_domain" "main" {
  domain_name = "my-elasticsearch-domain"
  elasticsearch_version = "7.10"
  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = 10
  }
  node_to_node_encryption {
    enabled = true
  }
  access_policies = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "es:ESHttpGet",
        "es:ESSearch",
        "es:ESHttpPost",
        "es:ESHttpPut",
        "es:ESHttpDelete",
        "es:ESHttpHead",
        "es:ESHttpOptions",
        "es:ESHttpPatch"
      ],
      "Resource": "arn:aws:es:us-east-1:123456789012:domain/my-elasticsearch-domain/*"
    }
  ]
}
EOF
}

# Crie um VPC para o domínio
resource "aws_elasticsearch_domain_vpc_options" "main" {
  domain_name = aws_elasticsearch_domain.main.domain_name
  vpc_options {
    security_group_ids = [aws_security_group.main.id]
    subnet_ids = [aws_subnet.main.id]
  }
}

# Crie um grupo de segurança para o domínio
resource "aws_security_group" "main" {
  name   = "es-sg"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Crie uma sub-rede para o domínio
resource "aws_subnet" "main" {
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

    
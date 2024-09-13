
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma instância EC2 com GPU
resource "aws_instance" "pytorch_instance" {
  ami           = "ami-xxxxxxxx" # Substitua pela AMI do PyTorch desejada
  instance_type = "p3.2xlarge" # Substitua pelo tipo de instância com GPU desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH

  tags = {
    Name = "PyTorch Instance"
  }
}

# Instale o PyTorch na instância
resource "null_resource" "install_pytorch" {
  provisioner "local-exec" {
    command = "sudo apt-get update && sudo apt-get install python3-pip && pip3 install torch torchvision torchaudio"
  }
}

# Crie um bucket S3 para armazenar dados
resource "aws_s3_bucket" "pytorch_data" {
  bucket = "pytorch-data-bucket"

  tags = {
    Name = "PyTorch Data Bucket"
  }
}

# Configure o IAM para acesso ao bucket S3
resource "aws_iam_role" "pytorch_role" {
  name = "pytorch_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "pytorch_policy" {
  role       = aws_iam_role.pytorch_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Crie um perfil de instância EC2 associado ao IAM
resource "aws_instance_profile" "pytorch_profile" {
  name = "pytorch_profile"
  role = aws_iam_role.pytorch_role.name
}

# Associe o perfil de instância ao EC2
resource "aws_instance" "pytorch_instance" {
  # ... (configuração da instância EC2 já definida)
  iam_instance_profile = aws_instance_profile.pytorch_profile.id
}

    
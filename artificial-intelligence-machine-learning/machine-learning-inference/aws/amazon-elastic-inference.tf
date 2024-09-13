
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um acelerador Elastic Inference
resource "aws_elastic_inference_accelerator" "elastic_inference" {
  accelerator_type = "eia1.small"
}

# Crie uma instância EC2
resource "aws_instance" "instance" {
  ami           = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH
  # ... (outras configurações da instância)
}

# Associe o acelerador à instância
resource "aws_elastic_inference_accelerator_association" "elastic_inference_association" {
  instance_id          = aws_instance.instance.id
  accelerator_id       = aws_elastic_inference_accelerator.elastic_inference.id
}
    
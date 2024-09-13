
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Enclave
resource "aws_enclave" "my_enclave" {
  enclave_type = "nitro" # Tipo de enclave
  name        = "my-enclave" # Nome do enclave

  # Configurações de segurança (supressas para brevidade)
}

# Crie uma instância EC2 com suporte a Enclaves
resource "aws_instance" "my_instance" {
  ami           = "ami-xxxxxxxx" # AMI com suporte a Enclaves
  instance_type = "c5.xlarge" # Tipo de instância com suporte a Enclaves
  key_name     = "key_name" # Chave SSH
  security_groups = [aws_security_group.allow_ssh.id]
  
  enclave_options {
    enabled = true # Habilita o suporte a Enclaves
  }
}

# Associe o Enclave à instância EC2
resource "aws_enclave_data" "my_enclave_data" {
  enclave_arn = aws_enclave.my_enclave.arn
  instance_id = aws_instance.my_instance.id
}
    
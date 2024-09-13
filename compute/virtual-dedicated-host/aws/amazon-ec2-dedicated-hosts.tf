
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um host dedicado
resource "aws_ec2_dedicated_host" "example" {
  availability_zone = "us-east-1a"
  host_type          = "m5.xlarge"
  auto_placement     = false

  # Supressão de longas strings
  # instance_family = "m5"
  # instance_type = "m5.xlarge"
  # ...

  # ... (outros atributos)
}

# Crie uma instância EC2 no host dedicado
resource "aws_instance" "example" {
  ami           = "ami-xxxxxxxx"
  instance_type = "m5.xlarge"
  dedicated_host_id = aws_ec2_dedicated_host.example.id
  # ... (outros atributos)
}
    
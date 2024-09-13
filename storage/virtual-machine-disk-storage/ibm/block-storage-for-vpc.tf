
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um volume de armazenamento
resource "aws_ebs_volume" "my_volume" {
  availability_zone = "us-east-1a"
  size = 100
  type = "gp3"
}

# Crie uma instância EC2
resource "aws_instance" "my_instance" {
  ami = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  # ... outros atributos da instância ...
}

# Anexar o volume à instância
resource "aws_volume_attachment" "my_attachment" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.my_instance.id
  volume_id = aws_ebs_volume.my_volume.id
}
    
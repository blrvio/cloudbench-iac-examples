
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um servidor de migração
resource "aws_smis_server" "example" {
  name   = "example"
  tags = {
    Name = "Example Server"
  }
}

# Crie uma tarefa de migração
resource "aws_smis_replication_run" "example" {
  server_id = aws_smis_server.example.id
  source_server_type = "LINUX"
  source_server_ip = "10.0.0.1"
  destination_volume_type = "gp2"
  tags = {
    Name = "Example Replication Run"
  }
}
    
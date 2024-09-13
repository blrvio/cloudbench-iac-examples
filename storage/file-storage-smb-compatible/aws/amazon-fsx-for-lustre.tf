
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um sistema de arquivos FSx para Lustre
resource "aws_fsx_lustre_file_system" "main" {
  file_system_type  = "PERSISTENT_1"
  storage_capacity   = 1200
  subnet_ids        = ["subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  security_group_ids = ["sg-xxxxxxxx"] # Substitua pelos IDs dos grupos de segurança

  tags = {
    Name = "fsx-lustre-main"
  }
}

# Crie um ponto de montagem para o sistema de arquivos FSx para Lustre
resource "aws_fsx_lustre_mount_target" "main" {
  file_system_id = aws_fsx_lustre_file_system.main.id
  subnet_id      = "subnet-xxxxxxxx" # Substitua pelo ID da sub-rede
  security_groups = ["sg-xxxxxxxx"] # Substitua pelos IDs dos grupos de segurança
}

    
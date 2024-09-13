
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um sistema de arquivos FSx para Windows File Server
resource "aws_fsx_windows_file_system" "fsx_for_windows" {
  file_system_type = "WINDOWS" # Tipo de sistema de arquivos
  storage_capacity  = 1024 # Capacidade de armazenamento em GB
  subnet_ids         = ["subnet-xxxxxxxx"] # Substitua pelo ID da sub-rede
  security_group_ids = ["sg-xxxxxxxx"] # Substitua pelo ID do grupo de segurança

  tags = {
    Name = "FSx for Windows File Server"
  }
}

# Crie uma montagem para acessar o sistema de arquivos
resource "aws_fsx_windows_file_system_mount_target" "fsx_for_windows_mount" {
  file_system_id = aws_fsx_windows_file_system.fsx_for_windows.id # ID do sistema de arquivos
  subnet_id      = "subnet-xxxxxxxx" # Substitua pelo ID da sub-rede
  security_group_ids = ["sg-xxxxxxxx"] # Substitua pelo ID do grupo de segurança
}

    
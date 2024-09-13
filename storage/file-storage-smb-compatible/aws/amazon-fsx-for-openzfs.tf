
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um sistema de arquivos FSx for OpenZFS
resource "aws_fsx_openzfs_file_system" "main" {
  storage_capacity_gib = 1024 # Tamanho em GiB do volume do sistema de arquivos
  subnet_ids         = ["subnet-xxxxxxxx"] # Substitua pelo ID da sua subnet
  security_group_ids   = ["sg-xxxxxxxx"] # Substitua pelo ID do seu grupo de segurança
  kms_key_id          = "arn:aws:kms:us-east-1:xxxxxxxx:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitua pelo ID da sua chave KMS
  throughput_capacity_mibps = 128 # Taxa de transferência em MiBps
  user_data = <<EOF
# Aqui você pode adicionar scripts de inicialização
EOF
  tags = {
    Name = "FSx for OpenZFS"
  }
}

# Crie uma montagem do sistema de arquivos FSx for OpenZFS
resource "aws_fsx_openzfs_file_system_mount_target" "main" {
  file_system_id = aws_fsx_openzfs_file_system.main.id
  subnet_id        = "subnet-xxxxxxxx" # Substitua pelo ID da sua subnet
  security_groups   = ["sg-xxxxxxxx"] # Substitua pelo ID do seu grupo de segurança
  tags = {
    Name = "FSx for OpenZFS Mount Target"
  }
}
    
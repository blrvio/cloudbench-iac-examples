
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster do Cloud HSM
resource "aws_cloudhsm_v2_cluster" "example" {
  hsm_type = "hsm1.medium"
  subnet_ids = ["subnet-xxxxxxxx"] # Substitua pelo ID da sua sub-rede
  source_backup_id = "backup-xxxxxxxx" # Substitua pelo ID do backup (opcional)
}

# Crie um HSM no cluster
resource "aws_cloudhsm_v2_hsm" "example" {
  cluster_id  = aws_cloudhsm_v2_cluster.example.id
  eni_id       = "eni-xxxxxxxx" # Substitua pelo ID da sua interface de rede elástica
  subnet_id   = "subnet-xxxxxxxx" # Substitua pelo ID da sua sub-rede
  external_ip = "x.x.x.x" # Substitua pelo IP externo do HSM
}
    
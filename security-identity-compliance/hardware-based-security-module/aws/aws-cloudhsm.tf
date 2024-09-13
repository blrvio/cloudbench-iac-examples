
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster HSM
resource "aws_cloudhsm_v2_cluster" "example" {
  hsm_type         = "hsm1.medium"
  subnet_ids      = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  source_backup_id = "backup-xxxxxxxx" # Substitua pelo ID do backup (opcional)

  tags = {
    Name = "My HSM Cluster"
  }
}

# Crie um HSM no cluster
resource "aws_cloudhsm_v2_hsm" "example" {
  cluster_id     = aws_cloudhsm_v2_cluster.example.id
  eni_id           = "eni-xxxxxxxx" # Substitua pelo ID da interface de rede elástica
  subnet_id        = "subnet-xxxxxxxx" # Substitua pelo ID da sub-rede
  hsm_type         = "hsm1.medium"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Substitua pela chave SSH (opcional)

  tags = {
    Name = "My HSM"
  }
}

# Crie uma chave HSM
resource "aws_cloudhsm_v2_key" "example" {
  cluster_id = aws_cloudhsm_v2_cluster.example.id
  label       = "my-key"
  value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Substitua pelo valor da chave (opcional)
}

# Crie uma política HSM
resource "aws_cloudhsm_v2_policy" "example" {
  cluster_id = aws_cloudhsm_v2_cluster.example.id
  policy      = "{"Version": "2012-10-17", "Statement": [{"Effect": "Allow", "Principal": "*", "Action": "*", "Resource": "*"} ]}"
}
    
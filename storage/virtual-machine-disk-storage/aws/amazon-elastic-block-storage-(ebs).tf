
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um volume EBS
resource "aws_ebs_volume" "web_server_volume" {
  availability_zone = "us-east-1a" # Substitua pela zona de disponibilidade desejada
  size              = 10 # Substitua pelo tamanho do volume em GiB
  type              = "gp2" # Substitua pelo tipo de volume desejado
}

# Crie um snapshot do volume EBS
resource "aws_ebs_snapshot" "web_server_snapshot" {
  volume_id = aws_ebs_volume.web_server_volume.id
}

# Crie um volume EBS a partir de um snapshot
resource "aws_ebs_volume" "web_server_volume_from_snapshot" {
  availability_zone = "us-east-1a" # Substitua pela zona de disponibilidade desejada
  size              = 10 # Substitua pelo tamanho do volume em GiB
  snapshot_id       = aws_ebs_snapshot.web_server_snapshot.id
  type              = "gp2" # Substitua pelo tipo de volume desejado
}
    
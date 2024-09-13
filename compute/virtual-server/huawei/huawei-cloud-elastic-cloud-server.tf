
      # Configure o provedor Huawei Cloud
provider "huaweicloud" {
  region = "cn-north-4" # Substitua pela sua região desejada
}

# Crie um grupo de segurança
resource "huaweicloud_ecs_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  rule {
    type       = "ingress"
    direction  = "ingress"
    protocol   = "tcp"
    port_range = "22"
    cidr       = "0.0.0.0/0"
  }
}

# Crie uma instância ECS
resource "huaweicloud_ecs_instance" "web_server" {
  name                 = "web_server"
  availability_zone    = "cn-north-4-a" # Substitua pela sua zona de disponibilidade
  flavor               = "ecs.g1.small" # Substitua pelo tipo de instância desejado
  image_id             = "centos-7.6-20200910.vhd" # Substitua pela AMI desejada
  security_group_ids  = [huaweicloud_ecs_security_group.allow_ssh.id]
  key_pair_name        = "key_name" # Substitua pelo nome da chave SSH
  system_disk_type     = "SATA"
  system_disk_size     = 100
}

    
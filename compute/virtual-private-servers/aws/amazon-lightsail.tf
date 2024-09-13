
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um instance Lightsail
resource "aws_lightsail_instance" "web_server" {
  availability_zone = "us-east-1a" # Substitua pela zona de disponibilidade desejada
  blueprint_id     = "amazon-linux-2" # Substitua pelo blueprint desejado
  bundle_id         = "nano_1_0" # Substitua pelo bundle desejado
  key_pair_name      = "key_name" # Substitua pelo nome da chave SSH
  user_data         = <<EOF
# Instale o Nginx

EOF

  tags = {
    Name = "Web Server"
  }
}

# Crie um endpoint DNS
resource "aws_lightsail_domain" "web_server_domain" {
  domain_name = "example.com" # Substitua pelo seu domínio
  instance_name = aws_lightsail_instance.web_server.name
}

# Crie um registro DNS
resource "aws_lightsail_domain_entry" "web_server_entry" {
  domain_name   = aws_lightsail_domain.web_server_domain.name
  instance_name = aws_lightsail_instance.web_server.name
  name          = "www"
  record_type    = "A"
  target         = aws_lightsail_instance.web_server.public_ip
}

    
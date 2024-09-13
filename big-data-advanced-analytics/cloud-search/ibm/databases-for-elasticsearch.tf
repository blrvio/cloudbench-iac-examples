
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um domínio Elasticsearch
resource "aws_elasticsearch_domain" "main" {
  domain_name = "my-elasticsearch-domain" # Substitua pelo nome desejado
  elasticsearch_version = "7.10" # Substitua pela versão desejada
  ebs_options {
    # Configure as opções do EBS
    # ...
  }
  node_to_node_encryption {
    # Configure a criptografia de nó para nó
    # ...
  }
  snapshot_options {
    # Configure as opções de snapshot
    # ...
  }
  vpc_options {
    # Configure as opções da VPC
    # ...
  }
  advanced_options {
    # Configure as opções avançadas
    # ...
  }
  access_policies = "# Substitua pela política de acesso desejada"
}

# Configure um usuário Elasticsearch
resource "aws_elasticsearch_user" "admin" {
  domain_name = aws_elasticsearch_domain.main.domain_name
  username    = "admin"
  password    = "# Substitua pela senha desejada"
}

# Crie um endpoint do Kibana
resource "aws_elasticsearch_domain_endpoint" "kibana" {
  domain_name = aws_elasticsearch_domain.main.domain_name
  endpoint    = "kibana"
}
    
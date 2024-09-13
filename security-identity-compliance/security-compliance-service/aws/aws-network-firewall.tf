
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um firewall de rede
resource "aws_network_firewall_firewall" "example" {
  firewall_policy_arn = aws_network_firewall_firewall_policy.example.arn
  subnet_mappings = [{"subnet_id" = aws_subnet.example.id}]
  firewall_name = "example"
}

# Crie uma política de firewall de rede
resource "aws_network_firewall_firewall_policy" "example" {
  firewall_policy_name = "example"
  firewall_policy_id = "example"
  description          = "Exemplo de política de firewall de rede"
  stateless_default_action = "DROP"

  stateless_rule_group_references {
    priority = 1
    resource_arn = aws_network_firewall_stateless_rule_group.example.arn
  }
}

# Crie um grupo de regras sem estado para o firewall de rede
resource "aws_network_firewall_stateless_rule_group" "example" {
  stateless_rule_group_name = "example"
  stateless_rule_group_id = "example"
  description = "Exemplo de grupo de regras sem estado para o firewall de rede"

  stateless_rules {
    rule_order = 1
    match_attributes {
      sources {
        port_ranges {
          from_port = 80
          to_port   = 80
        }
        address_groups {
          address_group_id = aws_network_firewall_address_group.example.id
        }
      }
      destinations {
        port_ranges {
          from_port = 80
          to_port   = 80
        }
        address_groups {
          address_group_id = aws_network_firewall_address_group.example.id
        }
      }
    }
    rule_action = "PASS"
  }
}

# Crie um grupo de endereços para o firewall de rede
resource "aws_network_firewall_address_group" "example" {
  address_group_name = "example"
  address_group_id = "example"
  description = "Exemplo de grupo de endereços para o firewall de rede"

  addresses {
    address_type = "CIDR"
    address = "10.0.0.0/16"
  }
}

# Crie uma sub-rede para o firewall de rede
resource "aws_subnet" "example" {
  vpc_id = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Crie uma VPC para o firewall de rede
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
    
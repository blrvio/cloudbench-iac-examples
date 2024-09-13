
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma rede Blockchain
resource "aws_managed_blockchain_network" "example" {
  name     = "example-network"
  framework = "ethereum"
  # ... other configuration ...
}

# Crie um membro da rede
resource "aws_managed_blockchain_member" "example" {
  name             = "example-member"
  network_id      = aws_managed_blockchain_network.example.id
  # ... other configuration ...
}

# Crie um nó de rede
resource "aws_managed_blockchain_node" "example" {
  member_id = aws_managed_blockchain_member.example.id
  # ... other configuration ...
}
    
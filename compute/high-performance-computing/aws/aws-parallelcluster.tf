
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster AWS ParallelCluster
resource "aws_parallelcluster_cluster" "example" {
  name = "my-parallelcluster"
  region = "us-east-1"
  # Outros parâmetros do cluster
  #...
}

    
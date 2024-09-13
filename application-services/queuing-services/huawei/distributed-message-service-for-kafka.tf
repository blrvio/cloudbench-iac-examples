
      ## Configure o provedor do AWS
provider "aws" {
  region = "us-east-1"
}

## Crie um cluster do MSK
resource "aws_msk_cluster" "main" {
  name         = "msk-cluster"
  broker_node_group_info {
    instance_type = "kafka.m5.large"
    client_subnets = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
  }
  kafka_version = "2.6.0"

  # ...
}

## Crie um tópico no MSK
resource "aws_msk_topic" "main" {
  cluster_arn = aws_msk_cluster.main.arn
  name         = "my-topic"
  # ...
}

    
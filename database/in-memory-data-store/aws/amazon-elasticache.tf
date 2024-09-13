
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cache Redis
resource "aws_elasticache_cluster" "redis_cache" {
  engine             = "redis"
  engine_version    = "6.x"
  cache_node_type   = "cache.t2.micro"
  num_cache_nodes   = 1
  cluster_name      = "my-redis-cache"
  parameter_group_name = "default.redis6.x"
  port              = 6379

  # Substitua o ID da VPC e da subnet pela sua configuração
  vpc_security_group_ids = ["sg-xxxxxxxx"]
  subnet_group_name      = "my-subnet-group"
}

    

      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  # Substitua pelos seus valores
  region = "cn-hangzhou"
  # ...
}

# Crie um cache do ApsaraDB for Redis
resource "alicloud_redis_instance" "example" {
  # Substitua pelos seus valores
  name            = "example"
  engine_version  = "3.2"
  instance_class  = "redis.shared.small"
  password        = "# senha do Redis"
  security_group_id = "sg-xxxxxxxx"
  # ...
}

# Crie um endpoint para acesso ao cache
resource "alicloud_redis_instance_endpoint" "example" {
  # Substitua pelos seus valores
  instance_id = alicloud_redis_instance.example.id
  # ...
}
    
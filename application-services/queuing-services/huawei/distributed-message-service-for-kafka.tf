
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Kafka cluster
resource "huaweicloud_dmskafka_cluster" "main" {
  name                 = "my-kafka-cluster"
  version              = "2.6.0"
  broker_num            = 3
  instance_spec        = "kafka.small"
  disk_size             = 100
  vpc_id               = "your-vpc-id"
  subnet_id            = "your-subnet-id"
  security_group_id    = "your-security-group-id"
  enable_public_network = true

  # Define the topics to create in the cluster
  topics {
    name = "my-topic"
    partitions = 3
    replication_factor = 3
  }
}

# Create a Kafka topic
resource "huaweicloud_dmskafka_topic" "main" {
  cluster_id = huaweicloud_dmskafka_cluster.main.id
  name       = "my-topic"
  partitions = 3
  replication_factor = 3
}

# Create a Kafka consumer group
resource "huaweicloud_dmskafka_consumer_group" "main" {
  cluster_id = huaweicloud_dmskafka_cluster.main.id
  name       = "my-consumer-group"
}

  
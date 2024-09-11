
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a DMS instance
resource "huaweicloud_dms_instance" "main" {
  name = "my-dms-instance" # Name of your DMS instance
  # Define the instance type (e.g., "standard")
  instance_type = "standard"
  # Define the instance specifications (e.g., number of brokers)
  broker_count = 1
  # Define the storage capacity (e.g., "100GB")
  storage_size = "100GB"
  # Specify the DMS version to use
  version = "2.0"
  # Define the network configuration
  network {
    # Specify the Vpc ID
    vpc_id = "your-vpc-id"
    # Specify the subnet ID
    subnet_id = "your-subnet-id"
    # Define the security group IDs
    security_group_ids = ["your-security-group-id"]
  }
  # Specify the instance group ID if using a cluster configuration
  instance_group_id = "your-instance-group-id"
  # Define the availability zone (e.g., "eu-west-1a")
  availability_zone = "eu-west-1a"
  # Configure the monitoring options
  monitoring {
    # Enable or disable monitoring
    enable = true
    # Configure the monitoring metrics to collect
    metrics = ["cpu", "memory", "disk"]
  }
  # Define the maintenance policy for the instance
  maintenance_policy {
    # Specify the maintenance window for scheduled updates
    maintenance_window = "00:00-06:00"
    # Define the maintenance frequency
    maintenance_frequency = "weekly"
  }
  # Configure the automatic backup settings
  backup {
    # Enable or disable automatic backups
    enable = true
    # Define the backup frequency
    frequency = "daily"
    # Define the backup retention period
    retention_period = "30 days"
  }
  # Add tags to the instance
  tags = {
    Name = "My DMS Instance"
  }
}

# Create a DMS topic
resource "huaweicloud_dms_topic" "main" {
  name = "my-dms-topic"
  # Specify the DMS instance ID
  instance_id = huaweicloud_dms_instance.main.id
  # Define the topic settings
  topic_settings {
    # Specify the topic type (e.g., "queue", "topic")
    topic_type = "queue"
  }
  # Add tags to the topic
  tags = {
    Name = "My DMS Topic"
  }
}
  
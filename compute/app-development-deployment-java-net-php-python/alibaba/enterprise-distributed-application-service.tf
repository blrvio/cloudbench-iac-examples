
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Create an EDAS application
resource "alicloud_edas_application" "example" {
  app_name         = "my-app"
  app_group_id      = "my-app-group"
  app_version      = "1.0"
  runtime_version  = "java8"
  # Environment configuration
  environment {
    # Environment variables
    environment_vars = {
      my_key = "my_value"
    }
    # Custom configuration
    custom_config {
      custom_config_content = <<EOF
# Custom configuration content
EOF
    }
  }
  # Deployment configuration
  deployment_config {
    deploy_strategy = "BLUE_GREEN"
    # Deploy to a specific cluster
    deploy_cluster = "my-cluster"
  }
  # Health check configuration
  health_check_config {
    # Health check URL
    health_check_url = "/health"
    # Health check interval
    health_check_interval = 10
  }
  # Scaling configuration
  scaling_config {
    # Minimum instances
    min_instance_num = 1
    # Maximum instances
    max_instance_num = 3
    # Scaling rules
    scaling_rules = {
      # Rule name
      rule_name = "cpu_utilization"
      # Rule type
      rule_type = "CPU_UTILIZATION"
      # Threshold
      threshold = 80
      # Scaling action
      scaling_action = "scale_out"
    }
  }
  # Traffic configuration
  traffic_config {
    # Traffic rule
    traffic_rule {
      # Rule name
      rule_name = "default_rule"
      # Target instance group
      target_instance_group = "my-instance-group"
      # Traffic weight
      traffic_weight = 100
    }
  }
}

# Create an EDAS instance group
resource "alicloud_edas_instance_group" "example" {
  group_id        = "my-instance-group"
  cluster_id      = "my-cluster"
  instance_type = "ecs.s1.small"
  instance_count = 2
  # Network configuration
  network_config {
    # VPC ID
    vpc_id = "vpc-id"
    # Subnet ID
    subnet_id = "subnet-id"
  }
  # Security group configuration
  security_group_config {
    # Security group ID
    security_group_id = "sg-id"
  }
}

# Create an EDAS cluster
resource "alicloud_edas_cluster" "example" {
  cluster_id = "my-cluster"
  # Configuration
  config {
    # Cluster name
    cluster_name = "my-cluster-name"
    # Cluster type
    cluster_type = "STANDALONE"
  }
  # Network configuration
  network_config {
    # VPC ID
    vpc_id = "vpc-id"
    # Subnet ID
    subnet_id = "subnet-id"
  }
  # Security group configuration
  security_group_config {
    # Security group ID
    security_group_id = "sg-id"
  }
}
  
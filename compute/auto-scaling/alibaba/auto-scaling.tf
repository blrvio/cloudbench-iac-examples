
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a scaling configuration
resource "alicloud_autoscaling_scaling_configuration" "main" {
  instance_type = "ecs.t1.small" # Instance type to use
  image_id     = "centos_7_04_x64_20G_alibase_20220310.vhd" # Image ID to use
  # Optional parameters
  # spot_price_limit = "0.1" # Maximum price for spot instances
  # security_group_ids = ["sg-xxx"] # Security group IDs to use
  # vpc_id = "vpc-xxx" # VPC ID to use
  # vswitch_id = "vswitch-xxx" # VSwitch ID to use
  # user_data = "echo 'Hello world' > /home/ubuntu/hello.txt"
  # ...
}

# Create a scaling group
resource "alicloud_autoscaling_scaling_group" "main" {
  scaling_group_name = "my-scaling-group" # Name of the scaling group
  scaling_configuration_id = alicloud_autoscaling_scaling_configuration.main.id
  # Optional parameters
  # desired_capacity = 2 # Desired number of instances
  # min_size = 1 # Minimum number of instances
  # max_size = 5 # Maximum number of instances
  # cooldown = 300 # Cooldown period in seconds
  # ...
}

# Create a scaling policy
resource "alicloud_autoscaling_scaling_policy" "main" {
  scaling_group_id  = alicloud_autoscaling_scaling_group.main.id
  scaling_policy_name = "my-scaling-policy"
  adjustment_type      = "PercentChangeInCapacity" # Type of adjustment
  scaling_adjustment = "10" # Adjustment value
  # Optional parameters
  # cooldown = 300 # Cooldown period in seconds
  # ...
}

# Create a scaling rule
resource "alicloud_autoscaling_scaling_rule" "main" {
  scaling_group_id     = alicloud_autoscaling_scaling_group.main.id
  scaling_rule_name    = "my-scaling-rule"
  scaling_policy_id    = alicloud_autoscaling_scaling_policy.main.id
  adjustment_type      = "PercentChangeInCapacity" # Type of adjustment
  scaling_adjustment = "10" # Adjustment value
  # Optional parameters
  # cooldown = 300 # Cooldown period in seconds
  # ...
  # Define the trigger conditions for the scaling rule
  # ...
}

  
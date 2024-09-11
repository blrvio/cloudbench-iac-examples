
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create an Auto Scaling group
resource "huaweicloud_as_group" "main" {
  name     = "my-as-group"
  launch_configuration_name = aws_launch_configuration.main.name
  min_size = 1
  max_size = 3
  desired_capacity = 2
  availability_zones = ["cn-north-1a"] # Add other AZs as needed
}

# Create a Launch Configuration
resource "huaweicloud_as_launch_configuration" "main" {
  name = "my-launch-configuration"
  image_id  = "centos7.8-x86_64"
  instance_type = "ecs.c1.medium"
  # Add other options as needed
}

  
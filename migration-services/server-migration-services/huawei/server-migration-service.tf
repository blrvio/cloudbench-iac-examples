
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Server Migration Service (SMS) Migration Task
resource "huaweicloud_sms_migration_task" "main" {
  name  = "my-sms-migration-task"
  source_type = "PHYSICAL_MACHINE" # Specify the source type, here physical machine
  # Other properties for source configuration
  # ...
  target_type = "ECS" # Specify the target type, here ECS
  # Other properties for target configuration
  # ...
  migration_mode = "HOT" # Specify the migration mode
  # Other optional properties
  # ...
}

# Create an ECS instance
resource "huaweicloud_ecs_instance" "main" {
  name             = "my-ecs-instance"
  flavor           = "ecs.s1.small"
  image_id         = "centos-7.5"
  security_groups  = [aws_security_group.main.id] # Reference the security group
  # Other optional properties
  # ...
}

# Create a security group for the ECS instance
resource "huaweicloud_vpc_security_group" "main" {
  name   = "sg-ecs"
  # Define inbound and outbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  

    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon MQ Broker
resource "aws_mq_broker" "main" {
  broker_name  = "my-mq-broker" # Name of the broker
  engine       = "activemq" # Broker engine (ActiveMQ, RabbitMQ)
  engine_version = "5.15.11" # Engine version
  # Create an instance with a specific configuration
  host_instance_type = "mq.t2.medium" # Instance type (see https://aws.amazon.com/amazon-mq/pricing/)
  # Optional settings
  publicly_accessible  = true # Make the broker publicly accessible (not recommended for security)
  # Configure broker security
  user_name = "admin" # Username for accessing the broker
  password = "my-password" # Password for accessing the broker (replace with a strong password)
  # Configure a security group for the broker
  security_groups = [aws_security_group.main.id]
  # Optional configurations
  # maintenance_window_start_time = "03:00" # Start time for maintenance window
  # maintenance_window_duration = "120" # Duration of maintenance window (in minutes)
}

# Create a security group for the broker
resource "aws_security_group" "main" {
  name   = "sg-mq-broker"
  # Define inbound and outbound rules
  ingress {
    from_port   = 61613
    to_port     = 61613
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

# Create an Amazon MQ Configuration
resource "aws_mq_configuration" "main" {
  name            = "my-mq-configuration" # Name of the configuration
  engine          = "activemq" # Broker engine (ActiveMQ, RabbitMQ)
  engine_version  = "5.15.11" # Engine version
  # Define the configuration properties
  configuration_properties = <<EOF
# Configure the broker for your specific needs
EOF
}

# Create a user for the Amazon MQ Broker
resource "aws_mq_user" "main" {
  broker_id = aws_mq_broker.main.broker_id # Broker ID
  username  = "my-user" # Username for accessing the broker
  password  = "my-password" # Password for accessing the broker (replace with a strong password)
  # Define user permissions
  # This example grants full permissions to the user
  # You can customize this based on your security needs
  console_access  = true # Allow access through the AWS Management Console
}

  
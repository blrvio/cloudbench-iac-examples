
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Cloud9 Environment
resource "aws_cloud9_environment_ec2" "main" {
  name          = "my-cloud9-env"
  instance_type = "t3.micro"
  # Configure the Cloud9 environment's network settings
  subnet_id = "subnet-0123456789abcdef0"
  # Optionally, you can specify a specific security group
  security_group_ids = ["sg-0123456789abcdef0"]
  # Configure the Cloud9 environment's storage settings
  automatic_stop_timeout_in_minutes = 60 # Set the timeout for automatic stop in minutes
  # Configure the Cloud9 environment's user settings
  user_settings {
    # Set the Cloud9 environment's user name
    user_name = "my-cloud9-user"
    # Customize the Cloud9 environment's user settings
    # You can configure additional settings as needed
  }
  # Optionally, you can configure additional settings
  # like the Cloud9 environment's logging configuration or the
  # Cloud9 environment's SSH configuration
}

# Create a Cloud9 Environment (using the default EC2 instance type)
resource "aws_cloud9_environment" "main" {
  name = "my-cloud9-env"
  # Configure the Cloud9 environment's network settings
  subnet_id = "subnet-0123456789abcdef0"
  # Optionally, you can specify a specific security group
  security_group_ids = ["sg-0123456789abcdef0"]
  # Configure the Cloud9 environment's storage settings
  automatic_stop_timeout_in_minutes = 60 # Set the timeout for automatic stop in minutes
  # Configure the Cloud9 environment's user settings
  user_settings {
    # Set the Cloud9 environment's user name
    user_name = "my-cloud9-user"
    # Customize the Cloud9 environment's user settings
    # You can configure additional settings as needed
  }
  # Optionally, you can configure additional settings
  # like the Cloud9 environment's logging configuration or the
  # Cloud9 environment's SSH configuration
}

  
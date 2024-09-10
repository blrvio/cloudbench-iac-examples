
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS CloudShell profile
resource "aws_cloud_shell_profile" "main" {
  name = "my-cloud-shell-profile" # Name of your CloudShell profile

  # Define the SSH key to use for the CloudShell profile
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDc7..." # Replace with your SSH public key

  # Enable CloudShell session history
  # Optional
  enable_session_history = true

  # Set the CloudShell default environment
  # Optional
  default_environment = "Linux"
}

# Create an AWS CloudShell session
resource "aws_cloud_shell_session" "main" {
  # Optional
  name = "my-cloud-shell-session"
  # Specify the CloudShell profile to use
  profile_name = aws_cloud_shell_profile.main.name
  # Optional
  instance_type = "t3.micro"
}

  
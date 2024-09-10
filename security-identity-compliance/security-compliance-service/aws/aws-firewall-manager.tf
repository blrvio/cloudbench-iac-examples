
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Firewall Manager Admin Account
resource "aws_firewall_manager_admin_account" "main" {
  admin_account_id = "123456789012" # Replace with your admin account ID
  # Optional: Configure the status of the admin account
  # status = "ENABLED" # Default is "ENABLED"
}

# Create a Firewall Manager Application List
resource "aws_firewall_manager_application_list" "main" {
  name   = "my-application-list"
  # Define the application list type
  type = "CUSTOM"
  # Add applications to the list
  applications {
    # Define the application name and protocol
    name    = "http"
    protocol = "TCP"
    # Optionally define the ports
    ports = [80, 443]
  }
}

# Create a Firewall Manager Firewall Policy
resource "aws_firewall_manager_firewall_policy" "main" {
  name   = "my-firewall-policy"
  # Define the firewall policy type
  type = "STATEFUL"
  # Set the firewall policy's priority
  priority = 1
  # Configure the firewall policy's description
  description = "Firewall policy for my applications"
  # Define the application list
  application_list_ids = [aws_firewall_manager_application_list.main.id]
  # Define the firewall policy's rules
  firewall_policy_rules {
    # Define the rule's action
    action = "ALLOW"
    # Define the rule's priority
    priority = 1
    # Define the rule's protocol
    protocol = "TCP"
    # Define the rule's source and destination
    source = "ANY"
    destination = "ANY"
    # Optionally define the ports
    ports = [80, 443]
  }
}

# Associate a Firewall Policy with an AWS account
resource "aws_firewall_manager_firewall_policy_association" "main" {
  firewall_policy_id = aws_firewall_manager_firewall_policy.main.id
  # Define the target account ID
  target_account_id = "123456789012" # Replace with your target account ID
}

  
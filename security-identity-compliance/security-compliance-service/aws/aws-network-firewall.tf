
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Network Firewall Endpoint
resource "aws_networkfirewall_endpoint" "main" {
  name             = "my-network-firewall-endpoint"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.main.arn
  subnet_mappings = {
    subnet_id = aws_subnet.main.id
  }
}

# Create a Network Firewall Firewall Policy
resource "aws_networkfirewall_firewall_policy" "main" {
  name    = "my-firewall-policy"
  firewall_policy {
    # Define the firewall policy
    stateless_custom_actions = {
      "" = {
        "" = {
          # Define a custom action
          action_name = "my-custom-action"
          action_type = "DENY"
        }
      }
    }
    stateless_default_actions = {
      "" = {
        # Define the default action
        action_type = "ALLOW"
      }
    }
    stateless_rule_group_references = {
      "" = {
        # Define the rule group reference
        resource_arn = aws_networkfirewall_rule_group.main.arn
        priority = 100
      }
    }
  }
}

# Create a Network Firewall Rule Group
resource "aws_networkfirewall_rule_group" "main" {
  name    = "my-rule-group"
  type    = "STATELESS"
  rule_group {
    "" = {
      # Define the rule group
      stateless_rules = {
        "" = {
          # Define a stateless rule
          rule_options {
            # Define rule options
            action = "ALLOW"
            rule_type = "STATELESS"
          }
          match_attributes {
            # Define match attributes
            sources {
              "" = {
                # Define a source
                address_definition {
                  # Define the source address
                  address_type = "CIDR"
                  address = "0.0.0.0/0"
                }
              }
            }
            destinations {
              "" = {
                # Define a destination
                address_definition {
                  # Define the destination address
                  address_type = "CIDR"
                  address = "0.0.0.0/0"
                }
              }
            }
          }
        }
      }
    }
  }
}

# Create a Subnet for the Network Firewall Endpoint
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id # Replace with your VPC ID
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  # Optional: assign tags
  tags = {
    Name = "My Subnet"
  }
}

# Create a VPC for the Network Firewall
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Optional: assign tags
  tags = {
    Name = "My VPC"
  }
}

  
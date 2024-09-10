
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Route 53 Traffic Flow
resource "aws_route53_traffic_flow" "main" {
  name = "my-traffic-flow"
  # Specify the Route 53 Hosted Zone ID where you want to create the Traffic Flow
  hosted_zone_id = "Z1234567890ABCDEF0"
  # Define the Traffic Flow's logic
  traffic_flow_config {
    type = "WEIGHTED"
    # Define the targets for the Traffic Flow
    targets {
      weight = 1
      # Define the target endpoint
      endpoint {
        type = "INSTANCE"
        # Specify the IP address of the instance
        instance {
          ip_address = "172.16.0.1"
        }
      }
    }
    # Define the fallback behavior for the Traffic Flow
    fallback_target {
      # Define the target endpoint
      endpoint {
        type = "INSTANCE"
        # Specify the IP address of the fallback instance
        instance {
          ip_address = "172.16.0.2"
        }
      }
    }
  }
  # Add tags to the Traffic Flow
  tags = {
    Name = "My Traffic Flow"
  }
}

  
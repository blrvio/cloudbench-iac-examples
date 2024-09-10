
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Global Accelerator
resource "aws_globalaccelerator_accelerator" "main" {
  name = "my-global-accelerator"
  # Configure the enabled features
  enabled = true
  # Configure the IP address type for the listener
  ip_address_type = "IPV4"
  # Configure the attributes for the accelerator
  attributes {
    # Enable the `Flow Logs` for the accelerator
    flow_logs_s3_bucket = "my-s3-bucket"
    # Enable the `Flow Logs` for the accelerator
    flow_logs_s3_prefix = "global-accelerator-logs"
    # Configure the `Flow Logs` format
    flow_logs_format = "standard"
  }
}

# Create a Listener
resource "aws_globalaccelerator_listener" "main" {
  accelerator_arn = aws_globalaccelerator_accelerator.main.arn
  port            = 80
  # Configure the protocol
  protocol = "TCP"
  # Configure the client affinity
  client_affinity = "SOURCE_IP"
  # Configure the port range
  port_range {
    from_port = 80
    to_port   = 80
  }
}

# Create an Endpoint Group
resource "aws_globalaccelerator_endpoint_group" "main" {
  listener_arn  = aws_globalaccelerator_listener.main.arn
  endpoint_type = "INSTANCE"
  # Configure the endpoints
  endpoint_configuration {
    # Configure the endpoint for the instance
    endpoint_id = "instance-id"
    # Configure the weight for the endpoint
    weight = 100
  }
  # Configure the traffic dial percentage
  traffic_dial_percentage = 100
}

# Create a DNS Namespace
resource "aws_globalaccelerator_dns_namespace" "main" {
  name = "my-dns-namespace"
  # Configure the tags for the DNS Namespace
  tags = {
    Name = "My DNS Namespace"
  }
  # Configure the properties of the DNS Namespace
  properties {
    # Configure the description for the DNS Namespace
    description = "My DNS Namespace Description"
    # Configure the hosted zone ID for the DNS Namespace
    hosted_zone_id = "Z1234567890ABCDEF0"
    # Configure the service ID for the DNS Namespace
    service_id = "service-id"
  }
}

  
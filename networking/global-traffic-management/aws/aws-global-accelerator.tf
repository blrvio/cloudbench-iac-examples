
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um acelerador global
resource "aws_globalaccelerator_accelerator" "example" {
  name = "example"
  enabled = true
}

# Crie um listener
resource "aws_globalaccelerator_listener" "example" {
  accelerator_arn = aws_globalaccelerator_accelerator.example.arn
  port_ranges {
    from_port = 80
    to_port   = 80
  }
  protocol = "TCP"
}

# Crie um endpoint grupo
resource "aws_globalaccelerator_endpoint_group" "example" {
  listener_arn = aws_globalaccelerator_listener.example.arn
  endpoint_configuration {
    endpoint_id = "xxxxxxxxxxxxxxxxx"
    weight = 100
  }
  traffic_dial_percentage = 100
}
    

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Proton service
resource "aws_proton_service" "main" {
  name = "my-proton-service"
  # Specify the service template
  template = "my-service-template"
  # Configure the service environment
  environment {
    name = "dev"
    # Optionally define service environment settings
    service_settings {
      # Define service settings
    }
  }
  # Specify the service instance
  instance {
    name = "my-service-instance"
    # Optionally define service instance settings
    instance_settings {
      # Define instance settings
    }
  }
}

# Create a Proton service template
resource "aws_proton_service_template" "main" {
  name = "my-service-template"
  # Specify the service template type
  template_type = "ecs"
  # Configure the service template settings
  template_settings {
    # Define service template settings
  }
}

  

# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an X-Ray sampling rule
resource "aws_xray_sampling_rule" "main" {
  name = "my-sampling-rule"
  # Define the sampling rule configuration
  rule_config {
    # Set the default sampling rate
    default_sampling {
      # Set the default sampling rate to 10%
      fixed_rate = 0.1
    }
    # Set the sampling rate based on HTTP request headers
    http_request_method {
      # Set the sampling rate to 50% for GET requests
      get_method {
        fixed_rate = 0.5
      }
    }
    # Set the sampling rate based on URL path
    url_path {
      # Set the sampling rate to 100% for requests to /api endpoint
      service_name = "api"
      fixed_rate   = 1.0
    }
  }
}

  
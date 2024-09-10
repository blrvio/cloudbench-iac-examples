
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Application Discovery Service Configuration
resource "aws_application_discovery_service_configuration" "main" {
  # Set a descriptive name for the configuration
  name = "my-ads-configuration"
  # Specify the log group where logs will be stored
  log_group_name = "my-ads-log-group"
  # Configure the agents that will be used for discovery
  agent_configuration {
    # Enable or disable the agent
    enable_agent = true
    # Set the number of times an agent attempts to connect to the service
    connection_timeout = 60
    # Set the interval in seconds between agent communication attempts
    health_service_timeout = 120
    # Configure the agent to send discovery data
    discovery_data_collection_config {
      # Enable the collection of application dependencies
      collect_application_dependencies = true
      # Enable the collection of system information
      collect_system_information = true
      # Enable the collection of configuration information
      collect_configuration_data = true
    }
  }
}

# Create an Application Discovery Service Agent Configuration
resource "aws_application_discovery_service_agent_configuration" "main" {
  # Set a descriptive name for the agent configuration
  name = "my-ads-agent-configuration"
  # Specify the Amazon S3 bucket where agent files will be stored
  agent_s3_bucket_name = "my-ads-agent-bucket"
  # Configure the agent to collect discovery data
  discovery_data_collection_config {
    # Enable the collection of application dependencies
    collect_application_dependencies = true
    # Enable the collection of system information
    collect_system_information = true
    # Enable the collection of configuration information
    collect_configuration_data = true
  }
}

  
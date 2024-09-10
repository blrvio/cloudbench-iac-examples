
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a MediaTailor configuration
resource "aws_mediatailor_configuration" "main" {
  name = "my-mediatailor-config"
  # Configure the source location for the content
  source_location_name = "my-source-location"
  # Define the playback configuration
  playback_configuration {
    ad_marker_passthrough = "ENABLED" # Enable ad marker passthrough
    # Configure the manifest source for the content
    manifest_source {
      # Use the S3 bucket to store the manifest file
      s3_source {
        bucket_name = "my-s3-bucket"
        key_prefix  = "my-manifest-path/"
      }
    }
  }
  # Define the logs configuration
  log_configuration {
    log_level = "INFO" # Set the log level
    # Configure the destination for the logs
    cloudwatch_logs_configuration {
      # Create a new CloudWatch log group
      log_group_name = "my-mediatailor-logs"
    }
  }
}

# Create a MediaTailor source location
resource "aws_mediatailor_source_location" "main" {
  name = "my-source-location"
  # Define the HTTPS endpoint for the content source
  http_package_source {
    # Define the content source URL
    source_url = "https://example.com/my-content/"
    # Specify the content source type
    source_type = "S3_SOURCE"
    # Configure the HLS packaging for the source location
    hls_source {
      # Define the HLS manifest URL
      hls_manifest_uri = "https://example.com/my-content/manifest.m3u8"
      # Specify the HLS segment duration
      segment_duration = "10" # In seconds
    }
  }
  # Define the access configuration for the source location
  access_configuration {
    # Define the security group IDs that will be used to access the source location
    security_group_ids = [aws_security_group.main.id]
  }
}

# Create a security group for the MediaTailor source location
resource "aws_security_group" "main" {
  name   = "sg-mediatailor"
  # Define the ingress and egress rules for the security group
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a MediaTailor playback endpoint
resource "aws_mediatailor_playback_endpoint" "main" {
  name           = "my-playback-endpoint"
  configuration_name = aws_mediatailor_configuration.main.name
  # Define the playback endpoint URL
  playback_endpoint_url = "https://my-playback-endpoint.mediatailor.us-east-1.amazonaws.com"
  # Define the logging configuration for the playback endpoint
  log_configuration {
    # Configure the destination for the logs
    cloudwatch_logs_configuration {
      # Create a new CloudWatch log group
      log_group_name = "my-playback-endpoint-logs"
    }
  }
}

  
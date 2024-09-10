
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Elemental Delta Channel
resource "aws_elemental_delta_channel" "main" {
  name               = "my-channel" # Name of your Elemental Delta Channel
  input_sources     = [aws_elemental_delta_input_source.main.id]
  channel_class      = "BASIC" # Channel class, 'BASIC' or 'PREMIUM'
  output_formats    = ["HLS"] # Output formats, e.g. ['HLS']
  ingest_endpoint    = "your-endpoint" # Ingest endpoint
  playback_endpoint = "your-endpoint" # Playback endpoint
  # Optional settings
  tags               = {
    Name = "My Elemental Delta Channel"
  }
  # Output options
  output_options {
    # HLS options
    hls_options {
      # Optional HLS settings
      # segment_duration = 10
      # manifest_duration = 30
    }
  }
}

# Create an Elemental Delta Input Source
resource "aws_elemental_delta_input_source" "main" {
  name = "my-input-source" # Name of your Elemental Delta Input Source
  # Ingest settings
  ingest_settings {
    # Ingest endpoint
    ingest_endpoint = "your-endpoint"
    # Input protocol
    input_protocol = "RTMP"
    # Input type
    input_type = "STREAM"
  }
  # Optional settings
  tags = {
    Name = "My Elemental Delta Input Source"
  }
}

  
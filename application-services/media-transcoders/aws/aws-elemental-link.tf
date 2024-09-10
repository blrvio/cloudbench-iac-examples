
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Elemental Link Live Session
resource "aws_medialive_input_security_group" "main" {
  name = "my-link-security-group"
  # Configure security group rules
  ingress {
    cidr_blocks = ["0.0.0.0/0"] # Allow access from any IP address
    protocol    = "udp"
    to_port     = 5004 # Allow UDP traffic on port 5004 (default Elemental Link port)
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"] # Allow egress to any IP address
    protocol    = "udp"
    to_port     = 5004
  }
}

resource "aws_medialive_input" "main" {
  name = "my-link-input"
  # Use the security group created above
  input_security_groups = [aws_medialive_input_security_group.main.id]
  # Configure the input type as 'LINK'
  type = "LINK"
  # Define the link configuration
  link_configuration {
    # Specify the protocol for the link connection
    protocol = "RTMP"
    # Specify the source address and port for the link
    source {
      address = "192.168.1.100" # Replace with your link source IP address
      port = 1935 # Replace with your link source port
    }
    # Provide any authentication information (optional)
    authentication {
      # Choose the authentication type (e.g., 'SHARED_SECRET', 'JWT')
      type = "SHARED_SECRET"
      # Provide any necessary credentials (e.g., shared secret, JWT token)
    }
  }
}

# Create an AWS Elemental MediaLive Channel
resource "aws_medialive_channel" "main" {
  name = "my-link-channel"
  # Choose the channel class (e.g., 'STANDARD', 'SINGLE_PIPELINE')
  channel_class = "SINGLE_PIPELINE"
  # Configure the input attachment for the channel
  input_attachments {
    input_id = aws_medialive_input.main.id
    input_attachment_name = "main"
  }
  # Configure the encoder settings for the channel
  encoder_settings {
    # Configure the output settings for the channel
    output_groups {
      # Define the output group name
      name = "main"
      # Configure the output settings for the group
      output_group_settings {
        # Specify the output group type
        type = "HLS_GROUP_SETTINGS"
        # Define the output group settings (e.g., HLS settings)
        hls_group_settings {
          # Configure the HLS settings (e.g., segment length, key length, etc.)
        }
      }
      # Configure the outputs within the group
      outputs {
        # Define the output name
        name = "main"
        # Configure the output settings
        output_settings {
          # Define the output codec (e.g., 'H264', 'AAC')
          video_description {
            codec_settings {
              h264_settings {
                # Configure H264 codec settings (e.g., bitrate, profile, level)
              }
            }
          }
          # Define the audio codec (e.g., 'AAC', 'MP2')
          audio_description {
            codec_settings {
              aac_settings {
                # Configure AAC codec settings (e.g., bitrate, sampling rate, etc.)
              }
            }
          }
          # Configure the container settings (e.g., 'MPEGTS', 'CMAF')
          container_settings {
            # Define the container settings (e.g., segment length, key length, etc.)
          }
        }
      }
    }
  }
}

  
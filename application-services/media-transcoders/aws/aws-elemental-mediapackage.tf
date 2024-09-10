
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a MediaPackage Channel
resource "aws_mediapackage_channel" "main" {
  name        = "my-media-package-channel"
  description = "My MediaPackage Channel"
  # Define the HLS packaging configuration
  hls_configuration {
    # Define the HLS playlist settings
    playlist_settings {
      # Create a playlist for live streams
      playlist_type = "LIVE"
      # Set the playlist duration
      playlist_duration_seconds = 10
      # Configure a dynamic ad insertion (DAI) manifest
      dynamic_ad_insertion {
        # Set the ad marker type
        ad_marker_type = "SCTE35"
      }
    }
  }
  # Define the Channel's origin endpoint
  origin_endpoint {
    # Specify the origin endpoint name
    name = "my-origin-endpoint"
    # Set the origin endpoint's URL
    url  = "https://my-origin-endpoint.example.com"
    # Define the origin endpoint's package configuration
    package_configuration {
      # Specify the package name
      name = "my-package"
      # Configure the package's HLS settings
      hls_configuration {
        # Define the HLS playlist settings
        playlist_settings {
          # Create a playlist for live streams
          playlist_type = "LIVE"
          # Set the playlist duration
          playlist_duration_seconds = 10
          # Configure a dynamic ad insertion (DAI) manifest
          dynamic_ad_insertion {
            # Set the ad marker type
            ad_marker_type = "SCTE35"
          }
        }
      }
    }
  }
}

# Create a MediaPackage Origin Endpoint
resource "aws_mediapackage_origin_endpoint" "main" {
  channel_id      = aws_mediapackage_channel.main.id
  # Specify the origin endpoint name
  name            = "my-origin-endpoint"
  # Set the origin endpoint's URL
  url             = "https://my-origin-endpoint.example.com"
  # Define the origin endpoint's package configuration
  package_configuration {
    # Specify the package name
    name = "my-package"
    # Configure the package's HLS settings
    hls_configuration {
      # Define the HLS playlist settings
      playlist_settings {
        # Create a playlist for live streams
        playlist_type = "LIVE"
        # Set the playlist duration
        playlist_duration_seconds = 10
        # Configure a dynamic ad insertion (DAI) manifest
        dynamic_ad_insertion {
          # Set the ad marker type
          ad_marker_type = "SCTE35"
        }
      }
    }
  }
}

  
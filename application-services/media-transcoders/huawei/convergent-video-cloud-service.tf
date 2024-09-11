
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a Convergent Video Cloud Service App
resource "huaweicloud_cvcs_app" "main" {
  name = "my-cvcs-app"
  # Optional parameters
  description = "My CVCS App"
  # Define the configurations for the application
  configs {
    # Define the configurations for the video encoding
    video_encoding {
      # Define the default output resolution
      default_resolution = "1080p"
      # Define the encoding profile
      profile = "high"
    }
  }
}

# Create a Convergent Video Cloud Service Channel
resource "huaweicloud_cvcs_channel" "main" {
  app_id = huaweicloud_cvcs_app.main.id
  name = "my-cvcs-channel"
  # Optional parameters
  description = "My CVCS Channel"
  # Define the configurations for the channel
  configs {
    # Define the input stream settings
    input_stream {
      # Define the stream type
      stream_type = "rtmp"
      # Define the source URL
      source_url = "rtmp://my-source-server/my-stream"
    }
  }
}

# Create a Convergent Video Cloud Service Stream
resource "huaweicloud_cvcs_stream" "main" {
  channel_id = huaweicloud_cvcs_channel.main.id
  name = "my-cvcs-stream"
  # Optional parameters
  description = "My CVCS Stream"
  # Define the configurations for the stream
  configs {
    # Define the output format
    output_format = "hls"
    # Define the output URL
    output_url = "https://my-cdn-server/my-stream"
  }
}

  

    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Substitute with your desired region
}

# Create a Live channel
resource "huaweicloud_live_channel" "main" {
  name   = "my-live-channel"
  domain = "example.com" # Replace with your domain
  # Optional settings
  # stream_type = "RTMP"
  # default_rtmp_url = "rtmp://example.com/live"
  # default_hls_url = "https://example.com/live"
  # default_http_flv_url = "http://example.com/live"
}

# Create a Live application
resource "huaweicloud_live_application" "main" {
  name = "my-live-application"
  # Optional settings
  # live_channels = ["my-live-channel"]
}

# Create a Live transcoding template
resource "huaweicloud_live_transcoding_template" "main" {
  name = "my-live-transcoding-template"
  # Optional settings
  # bitrate = 1000
  # resolution = "1280x720"
  # frame_rate = 25
  # video_codec = "h264"
  # audio_codec = "aac"
}

# Create a Live push stream
resource "huaweicloud_live_push_stream" "main" {
  channel = "my-live-channel"
  app    = "my-live-application"
  # Optional settings
  # transcoding_template = "my-live-transcoding-template"
}

  
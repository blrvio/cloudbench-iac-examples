
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your region and credentials
  region  = "cn-north-1"
  # ...
}

# Create a Video Ingestion Service channel
resource "huaweicloud_vis_channel" "main" {
  name     = "my-vis-channel"
  # ...
}

# Create a Video Ingestion Service push stream
resource "huaweicloud_vis_push_stream" "main" {
  channel_id = huaweicloud_vis_channel.main.id
  # ...
}

# Create a Video Ingestion Service pull stream
resource "huaweicloud_vis_pull_stream" "main" {
  channel_id = huaweicloud_vis_channel.main.id
  # ...
}

# Create a Video Ingestion Service task
resource "huaweicloud_vis_task" "main" {
  channel_id = huaweicloud_vis_channel.main.id
  # ...
}
  

    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "us-east-1"  # Replace with your desired region
}

# Create a VOD service
resource "huaweicloud_vod_service" "main" {
  name = "my-vod-service"
  description = "My VOD service"
}

# Create a VOD space
resource "huaweicloud_vod_space" "main" {
  name = "my-vod-space"
  service_id = huaweicloud_vod_service.main.id
  description = "My VOD space"
}

# Create a VOD file
resource "huaweicloud_vod_file" "main" {
  space_id = huaweicloud_vod_space.main.id
  file_name = "my-video.mp4"
  # Use a placeholder for the file path
  file_path = "s3://my-bucket/my-video.mp4"
  #  The following field is optional and should be replaced with actual values
  vod_config = {
    tags = {
      "key1" = "value1"
    }
  }
}

# Create a VOD transcoding template
resource "huaweicloud_vod_transcoding_template" "main" {
  name = "my-transcoding-template"
  description = "My transcoding template"
  service_id = huaweicloud_vod_service.main.id
  vod_config = {
    # Replace with actual values for transcoding configurations
    transcoding = {
      type = "video"
      format = "mp4"
    }
  }
}

  
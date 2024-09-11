
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create an Image Tagging task
resource "huaweicloud_image_tagging_task" "main" {
  # The ID of the image to tag
  image_id = "your-image-id"
  # The name of the tag
  tag_name = "my-tag"
  # The value of the tag
  tag_value = "my-tag-value"
}

  
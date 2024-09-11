
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a content moderation service
resource "huaweicloud_cms_service" "main" {
  name   = "my-content-moderation-service"
  # Specify the configuration for the content moderation service
  config {
    # Enable or disable the content moderation service
    enabled = true
    # Specify the type of content moderation
    type    = "text"
  }
}

# Create a content moderation task
resource "huaweicloud_cms_task" "main" {
  # Specify the service ID
  service_id = huaweicloud_cms_service.main.id
  # Specify the content to be moderated
  content = "This is an example content to be moderated."
}

  
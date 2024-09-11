
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create an Image Search Instance
resource "alicloud_image_search_instance" "default" {
  name = "my-image-search-instance"
  # Set the instance specifications
  spec = "basic"
  # You can also use custom spec configurations.
  # spec = "custom"
  # custom_spec {
  #   # ...
  # }
  # Define the tags for the instance
  tags = {
    Name = "My Image Search Instance"
  }
}

# Create an Image Search Index
resource "alicloud_image_search_index" "default" {
  instance_id = alicloud_image_search_instance.default.id
  name = "my-image-search-index"
  # Set the index parameters
  # index_config {
  #   # ...
  # }
}

# Create an Image Search Job
resource "alicloud_image_search_job" "default" {
  instance_id = alicloud_image_search_instance.default.id
  index_id = alicloud_image_search_index.default.id
  name = "my-image-search-job"
  # Set the job parameters
  # job_config {
  #   # ...
  # }
}
  
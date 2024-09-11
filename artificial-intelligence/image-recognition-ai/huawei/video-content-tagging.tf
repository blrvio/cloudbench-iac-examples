
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Video Content Tagging service
resource "huaweicloud_vct_service" "main" {
  name        = "my-vct-service" # Name of your Video Content Tagging service
  description = "My VCT Service" # Description of your VCT service
  # Add other optional configuration parameters as needed
}

# Create a VCT task
resource "huaweicloud_vct_task" "main" {
  service_id = huaweicloud_vct_service.main.id # ID of the VCT service
  name        = "my-vct-task" # Name of your VCT task
  # Add other optional configuration parameters as needed
}

# Create a VCT model
resource "huaweicloud_vct_model" "main" {
  service_id = huaweicloud_vct_service.main.id # ID of the VCT service
  name        = "my-vct-model" # Name of your VCT model
  # Add other optional configuration parameters as needed
}

  
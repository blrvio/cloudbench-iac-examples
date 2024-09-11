
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Real-time ASR service
resource "huaweicloud_rasr_service" "main" {
  name = "my-rasr-service"
  # Other optional configurations...
}

# Create a Real-time ASR task
resource "huaweicloud_rasr_task" "main" {
  service_id = huaweicloud_rasr_service.main.id # ID of the RASR service
  # Other optional configurations...
}

  
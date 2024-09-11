
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1"
}

# Create a Media Processing Center instance
resource "huaweicloud_mpc_instance" "main" {
  name          = "my-mpc-instance"
  instance_type = "Standard"
  # Configure storage settings
  storage_config {
    disk_type = "SSD"
    capacity   = 100
  }
}

# Create a Media Processing Center job
resource "huaweicloud_mpc_job" "main" {
  instance_id = huaweicloud_mpc_instance.main.id
  # Define the job type
  job_type = "transcoding"
  # Configure input and output settings
  input {
    source_type = "url"
    source_url  = "https://example.com/video.mp4"
  }
  output {
    output_type = "hls"
    output_url  = "s3://my-bucket/output"
  }
}

  
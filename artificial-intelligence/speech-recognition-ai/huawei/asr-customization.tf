
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "us-east-1" # Replace with your desired region
}

# Create an ASR Customization
resource "huaweicloud_asr_customization" "main" {
  name    = "my-asr-customization"
  # Optional settings
  engine_type  = "GENERAL"
  description = "ASR Customization for specific domain"
  # Configure ASR customization resources
  resources {
    dataset_id = "dataset_id"
  }
}

  

    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1"
}

# Create a DES Disk
resource "huaweicloud_des_disk" "main" {
  name = "my-disk"
  disk_type = "SSD"
  disk_size = 100
  availability_zone = "cn-north-1a"

  # Optional configuration for the DES Disk
  # disk_performance_level = "high"
  # iops = 10000
  # throughput = 100
}

  
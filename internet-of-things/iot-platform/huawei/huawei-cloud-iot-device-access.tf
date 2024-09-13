
      # Configure the HUAWEI CLOUD provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a device profile
resource "huaweicloud_iotda_device_profile" "example" {
  name = "example"
  description = "Example device profile"
}

# Create a device group
resource "huaweicloud_iotda_device_group" "example" {
  name = "example"
  device_profile_id = huaweicloud_iotda_device_profile.example.id
}

# Create a device
resource "huaweicloud_iotda_device" "example" {
  name = "example"
  device_group_id = huaweicloud_iotda_device_group.example.id
  device_id = "example"
}

    
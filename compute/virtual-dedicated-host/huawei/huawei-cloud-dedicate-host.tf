
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a dedicated host
resource "huaweicloud_deh_host" "main" {
  name = "my-dedicated-host"
  type = "dedicated_host_1" # Replace with the desired dedicated host type
  # Optional parameters
  # availability_zone = "cn-north-1-a"
  # tags = {
  #   Name = "my-dedicated-host"
  # }
}

# Create a dedicated host group
resource "huaweicloud_deh_host_group" "main" {
  name = "my-dedicated-host-group"
  # Optional parameters
  # availability_zone = "cn-north-1-a"
  # tags = {
  #   Name = "my-dedicated-host-group"
  # }
}

# Attach the dedicated host to the dedicated host group
resource "huaweicloud_deh_host_group_host" "main" {
  host_group_id = huaweicloud_deh_host_group.main.id
  host_id = huaweicloud_deh_host.main.id
}
  
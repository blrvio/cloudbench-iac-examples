
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a dedicated host
resource "alicloud_dedicated_host" "main" {
  dedicated_host_group_id = "dhg-abc12345"
  host_type                 = "ecs.g6.xlarge"
  availability_zone        = "cn-hangzhou-a"
  # Optional configuration
  # auto_renew                = false
  # tags = {
  #   Name = "My Dedicated Host"
  # }
}

# Create a dedicated host group
resource "alicloud_dedicated_host_group" "main" {
  name    = "dhg-abc12345"
  zone_id = "cn-hangzhou-a"
  # Optional configuration
  # auto_pay                  = true
  # auto_renew               = false
  # tags = {
  #   Name = "My Dedicated Host Group"
  # }
}

  
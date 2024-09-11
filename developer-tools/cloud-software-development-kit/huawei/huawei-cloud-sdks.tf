
    # Configure the provider for HUAWEI CLOUD
provider "huaweicloud" {
  # Replace with your HUAWEI CLOUD region
  region = "cn-north-1"
  # Replace with your HUAWEI CLOUD access key
  access_key = "your_access_key"
  # Replace with your HUAWEI CLOUD secret key
  secret_key = "your_secret_key"
}

# Example usage for creating a HUAWEI CLOUD ECS instance
resource "huaweicloud_ecs_instance" "main" {
  # Replace with the ECS instance name
  name = "my-ecs-instance"
  # Replace with the ECS instance type
  flavor = "ecs.s1.small"
  # Replace with the ECS instance image
  image_id = "centos-7.9.20220826.v2000"
  # Replace with the ECS instance security group
  security_group_ids = ["your_security_group_id"]
  # Replace with the ECS instance subnet
  subnet_id = "your_subnet_id"
  # Replace with the ECS instance disk size
  disk_size = 100
}

  
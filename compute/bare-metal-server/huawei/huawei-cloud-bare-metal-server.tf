
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your region
  region = "cn-north-1"
}

# Create a Bare Metal Server
resource "huaweicloud_bms_server" "main" {
  # Replace with your desired instance type
  flavor_id = "bms.s1.large"
  # Replace with your desired image
  image_id = "centos7_bms_base"
  # Replace with your desired security group
  security_group_id = "sg-xxxxxxxx"
  # Replace with your desired key pair
  key_name = "my-key-pair"
  # Replace with your desired name for the server
  name = "my-bms-server"
  # Replace with your desired subnet
  subnet_id = "subnet-xxxxxxxx"
  # Replace with your desired availability zone
  availability_zone = "cn-north-1a"
  # Replace with your desired number of disks
  data_disk_count = 1
  # Replace with your desired disk size in GB
  data_disk_size = 100
}

  
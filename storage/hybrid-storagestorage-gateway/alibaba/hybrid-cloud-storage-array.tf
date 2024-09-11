
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "cn-hangzhou" # Replace with your desired region
  profile = "default"    # Replace with your Alibaba Cloud profile
}

# Create a NAS file system
resource "alicloud_nas_file_system" "main" {
  name       = "my-nas-fs"
  description = "My NAS File System"
  # You can choose between Standard and Performance tiers
  storage_type = "Standard"
  # Specify the VPC ID
  vpc_id = "vpc-****"
  # Specify the VSwitch ID
  vswitch_id = "vsw-****"
}

# Create a NAS mount target
resource "alicloud_nas_mount_target" "main" {
  file_system_id = alicloud_nas_file_system.main.id
  # Specify the VSwitch ID
  vswitch_id = "vsw-****"
}

# Create a security group for the NAS file system
resource "alicloud_security_group" "main" {
  name = "sg-nas"
  # Allow access to the NAS file system from specific IP addresses or security groups
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Attach the security group to the NAS mount target
resource "alicloud_nas_mount_target_attachment" "main" {
  mount_target_id = alicloud_nas_mount_target.main.id
  security_group_id = alicloud_security_group.main.id
}
  
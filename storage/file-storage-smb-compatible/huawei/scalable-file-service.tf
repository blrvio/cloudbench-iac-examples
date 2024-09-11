
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west1" # Replace with your desired region
}

# Create a Scalable File Service (SFS) file system
resource "huaweicloud_sfs_file_system" "main" {
  name        = "my-sfs-file-system"
  description = "My SFS file system"
  # Optionally define storage capacity and availability zone
  capacity    = 100 # GB
  availability_zone = "eu-west1-a"
}

# Create an SFS mount target
resource "huaweicloud_sfs_mount_target" "main" {
  file_system_id = huaweicloud_sfs_file_system.main.id
  subnet_id       = "subnet-id" # Replace with your subnet ID
  # Optionally define the security group ID
  security_groups = ["security-group-id"] # Replace with your security group ID
}

# Create an SFS access group
resource "huaweicloud_sfs_access_group" "main" {
  name       = "my-sfs-access-group"
  description = "My SFS access group"
  # Define the file system ID to which the access group belongs
  file_system_id = huaweicloud_sfs_file_system.main.id
}

# Add a rule to the access group
resource "huaweicloud_sfs_access_group_rule" "main" {
  access_group_id = huaweicloud_sfs_access_group.main.id
  # Define the rule type (e.g., 'allow')
  rule_type      = "allow"
  # Define the user or group that can access the file system
  user           = "user-id" # Replace with your user ID
  # Define the path within the file system that the user can access
  path           = "/path/to/directory"
}

  
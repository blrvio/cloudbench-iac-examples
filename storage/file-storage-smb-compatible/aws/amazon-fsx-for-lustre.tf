
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an FSx for Lustre file system
resource "aws_fsx_lustre_file_system" "main" {
  #  A unique name for the file system.
  name = "my-fsx-lustre-filesystem"

  # The ID of the VPC for the file system.
  vpc_id = "vpc-1234567890abcdef0"

  #  The ID of the subnet in which to create the file system. The subnet must be in the same Availability Zone as the file system.
  subnet_ids = ["subnet-1234567890abcdef0"]

  # The type of file system to create. Valid values: "PERSISTENT_1", "PERSISTENT_2"
  # PERSISTENT_1: Basic file system for workloads that don't need high throughput.
  # PERSISTENT_2: High-performance file system for workloads that require high throughput and low latency.
  storage_type = "PERSISTENT_1"

  # The storage capacity (GiB) of the file system. Must be a multiple of 1024 GiB for "PERSISTENT_1" and a multiple of 32 TiB for "PERSISTENT_2".
  storage_capacity = 1024

  # The security group IDs of the security groups for the file system. The file system will be accessible from any IP address that is allowed by the security groups.
  security_groups = ["sg-1234567890abcdef0"]

  #  The configuration for the auto import policy.
  auto_import_policy {
    #  Indicates whether automatic import is enabled for the file system.
    enabled = false

    #  The source Amazon S3 bucket for the import policy.
    s3_import_path = "s3://my-bucket/data/"

    #  Indicates whether automatic import should be enabled for new files that are added to the source Amazon S3 bucket.
    import_on_creation = false
  }

  # The deployment type of the file system. Valid values: "SINGLE_AZ", "MULTI_AZ"
  # SINGLE_AZ: The file system will be created in a single Availability Zone.
  # MULTI_AZ: The file system will be created in multiple Availability Zones for high availability.
  deployment_type = "SINGLE_AZ"
}

# Create a mount target for the FSx for Lustre file system
resource "aws_fsx_lustre_mount_target" "main" {
  # The ID of the file system to associate with the mount target.
  file_system_id = aws_fsx_lustre_file_system.main.id

  # The ID of the subnet in which to create the mount target. The subnet must be in the same Availability Zone as the file system.
  subnet_id = "subnet-1234567890abcdef0"

  #  The security group IDs of the security groups for the mount target. The mount target will be accessible from any IP address that is allowed by the security groups.
  security_groups = ["sg-1234567890abcdef0"]
}

  
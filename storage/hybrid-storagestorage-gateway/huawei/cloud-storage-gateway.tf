
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Cloud Storage Gateway instance
resource "huaweicloud_csg_gateway" "main" {
  name = "my-csg-gateway" # Name of your gateway instance
  # Choose a VPC ID from your existing Huawei Cloud VPC
  vpc_id = "vpc-xxxxxxxxxxxxx"
  # Choose a subnet ID from your existing VPC
  subnet_id = "subnet-xxxxxxxxxxxxx"
  # Configure the security group ID
  security_group_id = "sg-xxxxxxxxxxxxx"
  # Choose a storage type
  storage_type = "S3"
  # Configure the S3 access key and secret key
  s3_access_key_id = "AKIAXXXXXXXXXXXXXXXX"
  s3_secret_access_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  # Choose the S3 bucket region
  s3_bucket_region = "cn-north-1"
  # Set the S3 bucket name
  s3_bucket_name = "my-bucket"
  # Specify a storage capacity for the gateway instance
  storage_capacity = 100
  # Configure the gateway instance type
  instance_type = "standard"
  # Optional: Define tags for the gateway instance
  tags = {
    Name = "my-csg-gateway"
  }
}

  
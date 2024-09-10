
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a VPC Network
resource "ibm_is_vpc" "main" {
  name = "my-vpc"
  zone = "us-south-1"
  # Configure the subnets
  subnets = [
    {
      name = "subnet-a"
      zone = "us-south-1"
      ip_version = "ipv4"
      cidr_block = "10.0.0.0/16"
    },
    {
      name = "subnet-b"
      zone = "us-south-1"
      ip_version = "ipv4"
      cidr_block = "10.1.0.0/16"
    },
  ]
}

# Create a Cloud Migration instance
resource "ibm_is_cloud_migration" "main" {
  name = "my-migration-instance"
  vpc_id = ibm_is_vpc.main.id
  # Configure the instance
  instance_type = "basic"
  # Configure the storage
  storage_size = 100
  # Configure the tags
  tags = {
    "Name" = "my-migration-instance"
  }
  # Configure the security group
  security_group_ids = [ibm_is_security_group.main.id]
}

# Create a Security Group
resource "ibm_is_security_group" "main" {
  name = "my-security-group"
  vpc_id = ibm_is_vpc.main.id
  # Configure the rules
  ingress = [
    {
      protocol = "tcp"
      ports = ["22"]
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      protocol = "tcp"
      ports = ["0-65535"]
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

  
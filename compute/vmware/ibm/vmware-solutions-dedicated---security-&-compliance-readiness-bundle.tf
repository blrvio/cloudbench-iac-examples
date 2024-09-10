
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a VMware Solutions Dedicated Instance
resource "ibm_is_vpc_instance" "main" {
  name = "my-vmware-instance"
  # Replace with a valid VMware Solutions Dedicated Instance ID
  resource_group_id = "YOUR_RESOURCE_GROUP_ID"
  # Replace with a valid VMware Solutions Dedicated Instance ID
  image_id = "YOUR_VMWARE_SOLUTION_IMAGE_ID"
  # Replace with a valid VMware Solutions Dedicated Instance ID
  flavor_id = "YOUR_VMWARE_SOLUTION_FLAVOR_ID"
  # Replace with a valid VMware Solutions Dedicated Instance ID
  network_id = "YOUR_VMWARE_SOLUTION_NETWORK_ID"
}

# Create a Security Group
resource "ibm_is_vpc_security_group" "main" {
  name   = "my-security-group"
  # Replace with a valid VMware Solutions Dedicated Instance ID
  resource_group_id = "YOUR_RESOURCE_GROUP_ID"
  
  # Allow inbound SSH connections
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Associate the Security Group to the instance
resource "ibm_is_vpc_instance_security_group" "main" {
  # Replace with a valid VMware Solutions Dedicated Instance ID
  instance_id = ibm_is_vpc_instance.main.id
  # Replace with a valid VMware Solutions Dedicated Instance ID
  security_group_id = ibm_is_vpc_security_group.main.id
}

  
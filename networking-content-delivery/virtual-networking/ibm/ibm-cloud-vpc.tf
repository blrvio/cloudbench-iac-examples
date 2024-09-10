
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API Key
  region  = "us-south" # Replace with your desired IBM Cloud region
}

# Create a VPC network
resource "ibm_vpc_network" "main" {
  name = "my-vpc-network" # Name of the VPC network
}

# Create a subnet within the VPC network
resource "ibm_vpc_subnet" "main" {
  name        = "my-subnet" # Name of the subnet
  network_id = ibm_vpc_network.main.id # ID of the VPC network
  # Define the IP address range for the subnet
  zone = "us-south-1"
  cidr_block = "10.0.0.0/24"
}

# Create a security group
resource "ibm_vpc_security_group" "main" {
  name = "my-security-group" # Name of the security group
  # Define the ingress rules for the security group
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a virtual server instance
resource "ibm_vpc_instance" "main" {
  name = "my-instance" # Name of the virtual server instance
  image = "ibm-public:centos-7:7.9.2009" # Image ID for CentOS 7
  # Define the VPC network and subnet for the instance
  network_id = ibm_vpc_network.main.id
  subnet_id = ibm_vpc_subnet.main.id
  # Define the security group for the instance
  security_groups = [ibm_vpc_security_group.main.id]
  # Define the flavor (instance type) for the instance
  flavor = "bx2.16x32"
}

  
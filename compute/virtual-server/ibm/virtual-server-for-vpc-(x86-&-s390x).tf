
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  ibmcloud_api_key = "your_ibm_cloud_api_key"
  region           = "us-south"
}

# Create a VPC network
resource "ibm_vpc_network" "main" {
  name     = "my-vpc-network"
  resource_group = "my-resource-group"
}

# Create a subnet within the VPC network
resource "ibm_vpc_subnet" "main" {
  name             = "my-subnet"
  network_id        = ibm_vpc_network.main.id
  zone              = "us-south-1"
  ipv4_cidr_block  = "10.0.0.0/24"
  resource_group = "my-resource-group"
}

# Create a security group
resource "ibm_vpc_security_group" "main" {
  name             = "my-security-group"
  network_id        = ibm_vpc_network.main.id
  resource_group = "my-resource-group"
}

# Create a virtual server
resource "ibm_vpc_virtual_server" "main" {
  name             = "my-virtual-server"
  network_id        = ibm_vpc_network.main.id
  subnet_id         = ibm_vpc_subnet.main.id
  security_group_ids = [ibm_vpc_security_group.main.id]
  resource_group = "my-resource-group"
  # ... other configuration options
}

  
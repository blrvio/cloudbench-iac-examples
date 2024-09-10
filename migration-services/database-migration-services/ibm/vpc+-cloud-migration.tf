
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create a VPC network
resource "ibm_is_vpc" "main" {
  name = "my-vpc"
  # Optional: Specify the resource group
  resource_group = "my-resource-group"
}

# Create a subnet within the VPC
resource "ibm_is_subnet" "main" {
  name = "my-subnet"
  vpc_id = ibm_is_vpc.main.id
  zone = "us-south-1"
  cidr = "10.0.0.0/24"
}

# Create a virtual server instance
resource "ibm_is_virtual_server" "main" {
  name = "my-instance"
  # Optional: Specify the resource group
  resource_group = "my-resource-group"
  image = "ibm-public:ubuntu:20.04"
  # Choose the instance size
  size = "bx2c.4x16"
  # Attach the subnet to the instance
  subnet_id = ibm_is_subnet.main.id
}

# Configure access to the virtual server instance
resource "ibm_is_security_group" "main" {
  name = "my-security-group"
  vpc_id = ibm_is_vpc.main.id
  # Allow SSH access to the instance
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "ibm_is_virtual_server_security_group" "main" {
  virtual_server_id = ibm_is_virtual_server.main.id
  security_group_id = ibm_is_security_group.main.id
}

# Optionally, configure a load balancer
# ...

# Create a Cloud Migration service instance
resource "ibm_cloud_migration_service" "main" {
  name = "my-migration-service"
  # Optional: Specify the resource group
  resource_group = "my-resource-group"
  # Specify the location of the service instance
  location = "us-south"
  # Select the appropriate plan
  plan = "standard"
}

# Configure migration jobs
# ...
  
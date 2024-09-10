
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY"
  region          = "us-south"
}

# Create a Classic Virtual Server (CVS)
resource "ibm_vsi_server" "main" {
  name = "my-cvs"
  image = "ibm-public:centos-7.9"
  flavor = "bx2.16x32"
  zone = "us-south-1"

  # Define the network settings
  network_interface {
    subnet = "YOUR_SUBNET_ID"
  }

  # Optional: Define the security settings
  security_groups = ["YOUR_SECURITY_GROUP_ID"]
  # Optional: Define the storage settings
  volumes {
    volume_id = "YOUR_VOLUME_ID"
    device     = "/dev/sdb"
  }
}

# You can also use the `ibm_vsi_network_interface` and `ibm_vsi_security_group` resources to configure the network and security settings of the CVS.

# Example: Create a new network interface
resource "ibm_vsi_network_interface" "main" {
  name    = "my-network-interface"
  subnet = "YOUR_SUBNET_ID"
  server  = ibm_vsi_server.main.id
}

# Example: Create a new security group
resource "ibm_vsi_security_group" "main" {
  name     = "my-security-group"
  vpc_id   = "YOUR_VPC_ID"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  
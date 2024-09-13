
      # Configure o provedor IBM Cloud
provider "ibm" {
  region   = "us-south"
  api_key = "xxxxxxxx"
}

# Crie um VPC
resource "ibm_vpc_network" "my_vpc" {
  name    = "my-vpc"
  resource_group = "default"
  classic_access = false
}

# Crie uma sub-rede
resource "ibm_vpc_subnet" "my_subnet" {
  name = "my-subnet"
  zone = "us-south-1"
  vpc_id = ibm_vpc_network.my_vpc.id
  cidr = "10.0.0.0/16"
}

# Crie uma instância de servidor
resource "ibm_is_instance" "my_server" {
  name = "my-server"
  image = "centos-7.8"
  zone = "us-south-1"
  profile = "bx2-16x32"
  subnet = ibm_vpc_subnet.my_subnet.id
}

    
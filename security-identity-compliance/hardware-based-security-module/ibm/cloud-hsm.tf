
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create a Cloud HSM instance
resource "ibm_cloud_hsm_instance" "main" {
  name = "my-hsm-instance"
  # Select the hardware security module (HSM) model
  model = "HSMv2-144"
  # Select the data center location
  datacenter = "dal10"
  # Select the network to which the HSM will be connected
  network = "my-network"
  # Select the number of partitions
  partition_count = 1
}

# Configure the HSM network
resource "ibm_cloud_hsm_network" "main" {
  name = "my-network"
  # Select the VPC
  vpc = "my-vpc"
  # Select the subnet
  subnet = "my-subnet"
}

# Create a HSM client
resource "ibm_cloud_hsm_client" "main" {
  name = "my-hsm-client"
  # Select the HSM instance
  instance = ibm_cloud_hsm_instance.main.id
}

# Grant access to the HSM client
resource "ibm_cloud_hsm_client_access" "main" {
  client = ibm_cloud_hsm_client.main.id
  instance = ibm_cloud_hsm_instance.main.id
  # Grant access to the default partition
  partition = 0
}

# Create a HSM partition
resource "ibm_cloud_hsm_partition" "main" {
  instance = ibm_cloud_hsm_instance.main.id
  # Set the partition ID
  partition = 0
  # Set the partition label
  label = "my-partition"
  # Set the partition state
  state = "active"
}

# Create a HSM partition role
resource "ibm_cloud_hsm_partition_role" "main" {
  instance = ibm_cloud_hsm_instance.main.id
  partition = 0
  # Set the role name
  name = "my-partition-role"
}

# Grant access to the HSM partition role
resource "ibm_cloud_hsm_partition_role_access" "main" {
  client = ibm_cloud_hsm_client.main.id
  instance = ibm_cloud_hsm_instance.main.id
  partition = 0
  role = ibm_cloud_hsm_partition_role.main.name
}

  

    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Use the OCID for your tenancy
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Create a virtual machine instance
resource "oci_core_instance" "main" {
  availability_domain = "AD-1"
  compartment_id       = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name         = "my-vm-instance"
  shape_name           = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    image_id    = "ocid1.image.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
  # Assign the SSH public key for access
  # ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2E..."
}

# Create a virtual network
resource "oci_core_virtual_network" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name   = "my-vnet"
  cidr_block     = "10.0.0.0/16"
}

# Create a subnet
resource "oci_core_subnet" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name     = "my-subnet"
  virtual_network_id = oci_core_virtual_network.main.id
  cidr_block        = "10.0.1.0/24"
}

# Create a security list
resource "oci_network_security_list" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name   = "my-security-list"
  # Define the ingress and egress rules
  egress {
    protocol      = "all"
    destination    = "0.0.0.0/0"
    icmp_options {
      type = "all"
    }
  }
}

# Create a route table
resource "oci_core_route_table" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name     = "my-route-table"
  virtual_network_id = oci_core_virtual_network.main.id
}

# Create a route rule
resource "oci_core_route_rule" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  route_table_id  = oci_core_route_table.main.id
  destination      = "0.0.0.0/0"
  destination_type = "CIDR_BLOCK"
  # Set the default gateway as the internet gateway
  # internet_gateway_id = "ocid1.internetgateway.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Attach the security list to the subnet
resource "oci_core_subnet_security_list" "main" {
  subnet_id      = oci_core_subnet.main.id
  security_list_id = oci_network_security_list.main.id
}

# Attach the route table to the subnet
resource "oci_core_subnet_route_table" "main" {
  subnet_id       = oci_core_subnet.main.id
  route_table_id  = oci_core_route_table.main.id
}

# Assign the subnet to the virtual machine instance
resource "oci_core_instance_network_interface" "main" {
  instance_id = oci_core_instance.main.id
  subnet_id   = oci_core_subnet.main.id
  # Use the security list assigned to the subnet
  # security_list_ids = [oci_network_security_list.main.id]
}

# Create a database instance
resource "oci_database_db_system" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name     = "my-database-instance"
  # Choose a database shape
  db_system_shape = "VM.Standard.E2.1"
  # Choose an image for the database
  db_system_version = "19.13.0.0.0"
  # Define the network configuration
  # subnet_id = oci_core_subnet.main.id
  # Assign a public IP address to the database
  # is_public_ip_enabled = true
  # Choose the edition of the database
  edition = "ENTERPRISE_EDITION"
  # Choose the licensing model
  license_model = "LICENSE_INCLUDED"
}

# Create a database user
resource "oci_database_db_user" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  db_system_id   = oci_database_db_system.main.id
  display_name    = "my-db-user"
  password        = "my-password"
}

# Create a database schema
resource "oci_database_db_schema" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  db_system_id   = oci_database_db_system.main.id
  display_name    = "my-db-schema"
  # Set the default user
  db_user_id = oci_database_db_user.main.id
}

  
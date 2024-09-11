
    # Configure the Oracle provider
provider "oracle" {
  # Replace with your Oracle Cloud credentials
  user       = "your_username"
  password    = "your_password"
  tenant     = "your_tenant"
  region     = "us-ashburn-1"
  # For more advanced configuration, refer to the documentation
  # https://registry.terraform.io/providers/hashicorp/oracle/latest/docs
}

# Create a Exadata Cloud@Customer instance
resource "oracle_exadata_cloud_customer_instance" "main" {
  # Replace with your desired values
  name    = "my-exadata-instance"
  shape   = "Exadata X8M"
  # Define the availability domain
  availability_domain = 1
  # Define the network configuration
  network {
    # Replace with your desired values
    subnet_id  = "your_subnet_id"
    security_list_ids = ["your_security_list_id"]
  }
  # Define the storage configuration
  storage {
    # Replace with your desired values
    storage_type = "dbfs"
    size          = 100
  }
  # Define the database configuration
  database {
    # Replace with your desired values
    version = "19c"
    edition = "Enterprise"
  }
}

# Create a security list
resource "oracle_security_list" "main" {
  # Replace with your desired values
  name = "my-security-list"
  # Define the ingress rules
  ingress {
    # Replace with your desired values
    protocol = "tcp"
    port_range = "22"
    source_cidr_blocks = ["0.0.0.0/0"]
  }
  # Define the egress rules
  egress {
    # Replace with your desired values
    protocol = "tcp"
    port_range = "0-65535"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a subnet
resource "oracle_subnet" "main" {
  # Replace with your desired values
  name = "my-subnet"
  cidr_block = "10.0.0.0/16"
  # Define the virtual cloud network
  vcn_id = "your_vcn_id"
}

  

    # Configure the OCI provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaw77777777777777777777777777"
  # Authentication method. Currently only `resource_principal` is supported.
  auth_method = "resource_principal"
  # The unique OCID of the resource principal being used.
  resource_principal_ocid = "ocid1.resourceprincipal.oc1..aaaaaaaaw77777777777777777777777777"
  # Optional: The profile to use for authentication.
  # profile = "my-profile"
  # Set the default compartment ID if you want all resources created in the same compartment.
  # compartment_id = "ocid1.compartment.oc1..aaaaaaaaw77777777777777777777777777"
}

# Create a compute instance
resource "oci_core_instance" "example" {
  availability_domain = "us-ashburn-1a"
  compartment_id       = "ocid1.compartment.oc1..aaaaaaaaw77777777777777777777777777"
  display_name         = "example-instance"
  shape = "VM.Standard.E2.1"
  # Define a block for the network configuration
  network_config {
    subnet_id = "ocid1.subnet.oc1..aaaaaaaaw77777777777777777777777777"
  }

  # Define a block for the launch options
  launch_options {
    # Define a block for the boot volume
    boot_volume {
      # Set the size of the boot volume in GB.
      size = 50
      # Set the type of the boot volume.
      # Allowed values: STANDARD, PREMIUM, EXTENDED.
      type = "STANDARD"
    }

    # Enable SSH access to the instance.
    is_ssh_public_key_required = false
  }

  # Define a block for the metadata options
  metadata_options {
    # Define a block for the user data
    user_data {
      # Set the user data as a string
      # Replace with your desired user data
      content = "echo 'Hello from Terraform!'"
    }
  }
}

# Create a security list
resource "oci_network_security_list" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw77777777777777777777777777"
  display_name    = "example-security-list"
  # Define the ingress rules for the security list
  ingress {
    # Define the source for the rule
    source {
      # Set the source to be any address.
      any = true
    }
    # Set the destination port range for the rule
    protocol = "tcp"
    destination_port_range {
      # Set the start port number.
      start = 22
      # Set the end port number.
      end = 22
    }
  }
  # Define the egress rules for the security list
  egress {
    # Define the source for the rule
    source {
      # Set the source to be any address.
      any = true
    }
    # Set the destination port range for the rule
    protocol = "all"
    destination_port_range {
      # Set the start port number.
      start = 0
      # Set the end port number.
      end = 0
    }
  }
}

# Create a subnet
resource "oci_core_subnet" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw77777777777777777777777777"
  display_name    = "example-subnet"
  # The OCID of the VCN that the subnet is being created in.
  vcn_id = "ocid1.vcn.oc1..aaaaaaaaw77777777777777777777777777"
  # Define the CIDR block for the subnet.
  cidr_block = "10.0.0.0/20"
  # Specify the security list to apply to the subnet.
  security_lists = [oci_network_security_list.example.id]
  # The DNS label of the subnet. This label is used in the DNS zone for this VCN to form the fully qualified domain name for instances in the subnet.
  dns_label = "example-subnet"
}

# Create a VCN
resource "oci_core_vcn" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw77777777777777777777777777"
  display_name    = "example-vcn"
  # The CIDR block for the VCN.
  cidr_block = "10.0.0.0/16"
  # Optional: The DNS label of the VCN.
  dns_label = "example-vcn"
}

  

    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Configure your OCI credentials here
  # Refer to OCI documentation for detailed configuration instructions.
}

# Create a compartment
resource "oci_core_compartment" "main" {
  name        = "example-compartment"
  description = "Example compartment for Burstable Instances"
  # Specify the parent compartment ID
  compartment_id = "ocid1.compartment.oc1..."
}

# Create a Burstable Instance
resource "oci_core_instance" "main" {
  availability_domain = "UOC1..."
  compartment_id      = oci_core_compartment.main.id
  shape               = "BM.Standard.2.1"
  display_name        = "Example Burstable Instance"
  source_details {
    source_type      = "image"
    image_id          = "ocid1.image.oc1..."
    boot_volume_size = 100
  }
  # Configure the network details
  # Replace with your subnet ID
  subnet_id = "ocid1.subnet.oc1..."
  # Assign a public IP address
  assign_public_ip = true
  # Configure SSH access
  # Replace with your SSH key information
  ssh_authorized_keys = ["ssh-rsa ..."]
}

# Create a network security group
resource "oci_network_security_group" "main" {
  compartment_id = oci_core_compartment.main.id
  name           = "example-nsg"
  description    = "Example network security group for Burstable Instances"
  # Configure ingress rules
  ingress_security_rules {
    # Allow SSH access from any source
    protocol = "tcp"
    source      = "0.0.0.0/0"
    direction = "ingress"
    tcp_options {
      max = 22
      min = 22
    }
  }
  # Configure egress rules
  egress_security_rules {
    protocol = "all"
    source    = "0.0.0.0/0"
    direction = "egress"
  }
}

# Associate the network security group with the instance
resource "oci_core_instance_network_security_group_attachment" "main" {
  compartment_id = oci_core_compartment.main.id
  instance_id    = oci_core_instance.main.id
  nsg_id         = oci_network_security_group.main.id
}

  
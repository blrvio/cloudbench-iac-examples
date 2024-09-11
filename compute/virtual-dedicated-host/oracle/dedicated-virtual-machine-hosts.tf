
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  fingerprint = "..."
  key_file = "path/to/private/key"
}

# Create a dedicated virtual machine host
resource "oci_core_dedicated_vm_host" "main" {
  availability_domain = "AD-1"
  compartment_id       = "ocid1.compartment.oc1..."
  shape              = "VM.Standard.E4.Flex"
  # Use `oci_core_image.main` for custom image
  # source_details {
  #   image_id = oci_core_image.main.id
  # }
}

# Create a security list to allow SSH access
resource "oci_core_security_list" "ssh" {
  compartment_id = "ocid1.compartment.oc1..."
  display_name  = "ssh_access"
  egress {
    protocol = "all"
    # Allow all egress traffic from the VM
    destination  = "0.0.0.0/0"
    tcp_options  = { source_port_range = "*"
    }
    udp_options  = { source_port_range = "*"
    }
    icmp_options = { type = "*"
    }
  }
  ingress {
    protocol = "tcp"
    source    = "0.0.0.0/0"
    # Allow SSH traffic from anywhere
    tcp_options  = { destination_port_range = "22"
    }
  }
}

# Create a VNIC to connect the VM to the network
resource "oci_core_vnic" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  subnet_id      = "ocid1.subnet.oc1..."
  display_name  = "vnic-for-vm"
  security_lists = [oci_core_security_list.ssh.id]
}

# Create a VM instance on the dedicated host
resource "oci_core_instance" "main" {
  availability_domain = "AD-1"
  compartment_id       = "ocid1.compartment.oc1..."
  # Use `oci_core_image.main` for custom image
  # source_details {
  #   image_id = oci_core_image.main.id
  # }
  # Assign the dedicated VM host
  dedicated_vm_host_id = oci_core_dedicated_vm_host.main.id
  # Assign the VNIC
  vnics             = [oci_core_vnic.main.id]
  shape              = "VM.Standard.E2.1"
  display_name        = "my-dedicated-vm"
}

  
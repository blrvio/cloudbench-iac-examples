
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaatw3q7y77n5b7m4v73q5n5w23225b6f"
  user_ocid = "ocid1.user.oc1..aaaaaaaaz44r5u4f6m6q2t5v55w26b64b3s54"
  fingerprint = "..."
  # Replace with your own values
}

# Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "main" {
  cidr_block = "10.0.0.0/16"
  display_name = "my-vcn"
}

# Create a Subnet within the VCN
resource "oci_core_subnet" "main" {
  compartment_id = oci_core_vcn.main.compartment_id
  vcn_id = oci_core_vcn.main.id
  cidr_block = "10.0.1.0/24"
  display_name = "my-subnet"
}

# Create a Security List
resource "oci_core_security_list" "main" {
  compartment_id = oci_core_vcn.main.compartment_id
  vcn_id = oci_core_vcn.main.id
  display_name = "my-security-list"
  egress {
    protocol = "all"
    destination = "0.0.0.0/0"
  }
  ingress {
    protocol = "tcp"
    source = "0.0.0.0/0"
    destination = "22"
  }
}

# Create a Compute Instance
resource "oci_core_instance" "main" {
  compartment_id = oci_core_vcn.main.compartment_id
  availability_domain = "us-ashburn-1a"
  shape = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    image_id = "ocid1.image.oc1.us-ashburn-1.aaaaaaaaj7n36e74e3d35565n63x24e5z2p535y7"
  }
  display_name = "my-instance"
  subnet_id = oci_core_subnet.main.id
  # Assign a public IP address
  create_vnic_details {
    subnet_id = oci_core_subnet.main.id
    assign_public_ip = true
  }
  # Attach the Security List
  security_lists = [oci_core_security_list.main.id]
}

  
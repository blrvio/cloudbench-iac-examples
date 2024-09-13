
      # Configure o provedor Oracle Cloud
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  fingerprint = "xxxxxxxxxxxxxxxx"
}

# Crie um grupo de segurança
resource "oci_core_network_security_group" "allow_ssh" {
  compartment_id = "ocid1.compartment.oc1..."
  name           = "allow_ssh"
  
  ingress {
    source   = "0.0.0.0/0"
    protocol = "tcp"
    port_range = "22"
  }
}

# Crie um servidor Bare Metal
resource "oci_core_bare_metal_instance" "web_server" {
  compartment_id = "ocid1.compartment.oc1..."
  availability_domain = "AD-1"
  shape = "BM.Standard.2.8"
  network_security_groups = [oci_core_network_security_group.allow_ssh.id]
}

    
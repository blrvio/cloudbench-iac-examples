
      # Configure o provedor Oracle Cloud
provider "oci" {
  region = "us-ashburn-1"
  # Adicione suas credenciais
}

# Crie um VCN para sua rede
resource "oci_core_virtual_network" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  cidr_block = "10.0.0.0/16"
  display_name = "My VCN"
}

# Crie uma sub-rede no VCN
resource "oci_core_subnet" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "My Subnet"
  virtual_network_id = oci_core_virtual_network.example.id
  cidr_block = "10.0.1.0/24"
}

# Crie um grupo de segurança para sua rede
resource "oci_network_security_list" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "My Security List"
  vcn_id = oci_core_virtual_network.example.id

  egress {
    protocol = "all"
    destination = "0.0.0.0/0"
  }

  ingress {
    protocol = "tcp"
    source = "0.0.0.0/0"
    destination = "10.0.1.0/24"
    port_range = "22,80,443"
  }
}

# Crie um grupo de instâncias para seus servidores virtuais
resource "oci_core_instance_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "My Instance Group"
  shape = "VM.Standard.A1.Flex"
  subnet_id = oci_core_subnet.example.id
  availability_domain = "us-ashburn-1a"
  security_list_ids = [oci_network_security_list.example.id]
}

# Crie um servidor virtual
resource "oci_core_instance" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "My Instance"
  shape = "VM.Standard.A1.Flex"
  availability_domain = "us-ashburn-1a"
  subnet_id = oci_core_subnet.example.id
  instance_group_id = oci_core_instance_group.example.id
}

# Crie uma imagem de máquina virtual
resource "oci_core_image" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "My Image"
  source_details {
    source_type = "instance"
    source_id = oci_core_instance.example.id
  }
}

    
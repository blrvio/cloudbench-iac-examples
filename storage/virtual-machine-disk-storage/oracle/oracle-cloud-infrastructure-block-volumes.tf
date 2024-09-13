
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
}

# Crie um volume de bloco
resource "oci_core_volume" "example" {
  availability_domain = "AD-1"
  # Substitua pela sua zona de disponibilidade desejada
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxx"
  # Substitua pelo ID do seu compartimento
  display_name      = "example_volume"
  size_in_gbs       = 100
  # Substitua pelo tamanho do volume em GB
}

# Crie um grupo de anexação de volumes
resource "oci_core_volume_attachment" "example" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxx"
  # Substitua pelo ID do seu compartimento
  instance_id     = "ocid1.instance.oc1..aaaaaaaaxxxxxxxxxx"
  # Substitua pelo ID da sua instância
  volume_id        = oci_core_volume.example.id
}

    
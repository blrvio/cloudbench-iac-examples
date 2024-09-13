
      # Configure o provedor do Oracle Cloud
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
}

# Crie um serviço de DNS
resource "oci_dns_service" "my_dns_service" {
  name = "my-dns-service"
  # Crie uma zona DNS
  resource "oci_dns_zone" "my_zone" {
    name = "example.com"
    # Substitua pelo nome da zona desejado
  }

  # Crie um registro DNS
  resource "oci_dns_record" "my_record" {
    zone_id = oci_dns_zone.my_zone.id
    name = "www"
    type = "A"
    # Substitua pelo nome do registro desejado
  }
}
    
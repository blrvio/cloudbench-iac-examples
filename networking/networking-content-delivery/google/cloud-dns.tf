
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id" # Substitua pelo seu ID do projeto
}

# Crie uma zona DNS
resource "google_dns_managed_zone" "my_zone" {
  name = "my-zone.example.com"
  dns_name = "my-zone.example.com."
}

# Crie um registro DNS
resource "google_dns_record_set" "my_record" {
  managed_zone = google_dns_managed_zone.my_zone.name
  name = "example.com."
  type = "A"
  ttl = 300
  rrdatas = ["1.2.3.4"]
}
    
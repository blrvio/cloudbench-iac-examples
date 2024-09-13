
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie uma peering de VPC
resource "google_compute_global_address" "external_ip_address" {
  name    = "external-ip-address"
  address_type = "EXTERNAL"
  address = "1.2.3.4"
  # Use o IP externo desejado aqui
}

resource "google_compute_address" "internal_ip_address" {
  name    = "internal-ip-address"
  address_type = "INTERNAL"
  project = "your-project-id"
  region  = "us-central1"
}

resource "google_compute_network_peering" "peering" {
  name = "peering-connection"
  project = "your-project-id"
  network = "your-network-name"
  network_project_id = "project-id-da-outra-rede-VPC"
  peer_network = "outra-rede-VPC-name"
  auto_create_routes = true
  export_custom_routes = true
  import_custom_routes = true
  # Use o nome da peering, nome da rede e o ID do projeto
}

resource "google_compute_instance" "instance" {
  name    = "instance"
  machine_type = "n1-standard-1"
  zone    = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      # Use a imagem desejada
    }
  }
  network_interface {
    network = google_compute_network_peering.peering.network
    subnetwork = "projects/your-project-id/regions/us-central1/subnetworks/default"
    # Use a sub-rede desejada
  }
  can_ip_forward = true
  project = "your-project-id"
}

resource "google_compute_forwarding_rule" "forwarding_rule" {
  name = "forwarding-rule"
  network = google_compute_network_peering.peering.network
  project = "your-project-id"
  region = "us-central1"
  ip_protocol = "tcp"
  load_balancing_scheme = "INTERNAL"
  all_ports = true
  target = google_compute_instance.instance.self_link
  # Use o nome da peering, nome da rede, região e IP externo
  subnetwork = "projects/your-project-id/regions/us-central1/subnetworks/default"
  # Use a sub-rede desejada
}

resource "google_compute_url_map" "url_map" {
  name    = "url-map"
  default_service = google_compute_forwarding_rule.forwarding_rule.self_link
  project = "your-project-id"
  # Use o nome da peering, nome da rede e a ID do projeto
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  name = "target-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
  project = "your-project-id"
  # Use o nome da peering, nome da rede e a ID do projeto
}

resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name = "global-forwarding-rule"
  ip_protocol = "TCP"
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  port_range = "80"
  subnetwork = "projects/your-project-id/regions/us-central1/subnetworks/default"
  project = "your-project-id"
  target = google_compute_target_http_proxy.target_http_proxy.self_link
  # Use o nome da peering, nome da rede, região e IP externo
  ip_address = google_compute_global_address.external_ip_address.address
}

resource "google_compute_target_tcp_proxy" "target_tcp_proxy" {
  name = "target-tcp-proxy"
  project = "your-project-id"
  service = google_compute_forwarding_rule.forwarding_rule.self_link
  # Use o nome da peering, nome da rede e a ID do projeto
}
    
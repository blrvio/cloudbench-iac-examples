
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a backend service
resource "google_compute_backend_service" "main" {
  name = "my-backend-service"
  protocol = "HTTP"
  timeout_sec = 5
  port_name = "http"

  # Create a health check
  health_checks = [google_compute_health_check.http.id]

  # Define backend capacity
  capacity_scaler {
    name = "default"
    capacity = 100
  }
}

# Create a HTTP health check
resource "google_compute_health_check" "http" {
  name           = "my-http-health-check"
  check_interval_sec = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  request_path = "/"
  port_name = "http"
  port_specification = "USE_NAMED_PORT"
}

# Create a load balancer
resource "google_compute_target_http_proxy" "main" {
  name         = "my-target-http-proxy"
  url_map      = google_compute_url_map.main.id
  backend_service = google_compute_backend_service.main.id
}

# Create a URL map
resource "google_compute_url_map" "main" {
  name = "my-url-map"
  host_rule {
    hosts = ["*"]
    path_matcher = "all_paths"
  }
  path_matcher {
    name = "all_paths"
    default_service = google_compute_backend_service.main.id
  }
}

# Create a firewall rule
resource "google_compute_firewall" "main" {
  name   = "my-firewall-rule"
  network = "projects/your-project-id/global/networks/default"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Create a network
resource "google_compute_network" "main" {
  name    = "my-network"
  auto_create_subnetworks = false
}

# Create a subnet
resource "google_compute_subnetwork" "main" {
  name           = "my-subnet"
  network        = google_compute_network.main.self_link
  region         = "us-central1"
  ip_cidr_range = "10.128.0.0/20"
}

  
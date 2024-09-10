
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Cloud CDN configuration
resource "google_compute_url_map" "default" {
  name    = "my-cdn-url-map"
  default_service = "my-backend-service"
  host_rule {
    hosts = ["*.example.com"]
    path_matcher = "all-paths"
  }
  path_matcher {
    name    = "all-paths"
    default_service = "my-backend-service"
  }
}

# Create a Cloud CDN backend service
resource "google_compute_backend_service" "default" {
  name           = "my-backend-service"
  load_balancing_scheme = "INTERNAL"
  protocol      = "HTTP"
  port_name      = "http"
  timeout_sec    = 10
  health_checks  = [google_compute_health_check.http.id]
  backends {
    group = google_compute_region_backend_service.default.id
  }
}

# Create a Cloud CDN health check
resource "google_compute_health_check" "http" {
  name  = "my-http-health-check"
  check_interval_sec = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  http_health_check {
    port_name       = "http"
    port_specification = "USE_NAMED_PORT"
    request_path     = "/"
  }
}

# Create a Cloud CDN regional backend service
resource "google_compute_region_backend_service" "default" {
  name = "my-regional-backend-service"
  region = "us-central1"
  protocol = "HTTP"
  timeout_sec = 10
  port_name = "http"
  health_checks = [google_compute_health_check.http.id]
  backends {
    group = google_compute_region_backend_service.default.id
  }
}
  
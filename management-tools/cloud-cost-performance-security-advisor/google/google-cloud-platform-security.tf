
    # Configure the Google Cloud Platform Provider
provider "google" {
  project  = "your-gcp-project-id"
  region   = "us-central1"
  zone     = "us-central1-a"
  features = [
    "Compute Engine",  # Enable compute engine features
    "Storage",  # Enable storage features
  ]
}

# Create a Security Policy
resource "google_compute_security_policy" "main" {
  name = "my-security-policy"
  description = "Example security policy"
  
  # Define the security policy rules
  rule {
    match {
      layer4_config {
        port_range {
          from_port   = 443
          to_port     = 443
        }
      }
    }
    action = "secure"
  }
}

# Create a Network
resource "google_compute_network" "main" {
  name = "my-network"
  auto_create_subnetworks = false
}

# Create a Subnetwork
resource "google_compute_subnetwork" "main" {
  name           = "my-subnet"
  ip_cidr_range = "10.128.0.0/20"
  network        = google_compute_network.main.id
  region         = "us-central1"
}

# Create a Firewall Rule
resource "google_compute_firewall" "main" {
  name       = "my-firewall-rule"
  network    = google_compute_network.main.id
  priority   = 1000
  description = "Example firewall rule"
  # Define the firewall rule
  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }
}

# Attach the Security Policy to a Subnetwork
resource "google_compute_subnetwork_iam_binding" "main" {
  role          = "roles/compute.securityPolicyUser"
  members       = ["serviceAccount:my-service-account@gcp-sa-compute.iam.gserviceaccount.com"]
  condition {
    title = "gcp_security_policy"
    description = "Only allow access from a specific security policy"
    expression = "resource.type == 'compute.subnetwork' && resource.name == 'my-subnet' && resource.labels.gcp_security_policy == 'my-security-policy'"  }
}

  
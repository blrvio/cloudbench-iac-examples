
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Security Health Analytics configuration
resource "google_security_center_security_health_analytics_config" "default" {
  parent = "organizations/your-org-id"
  display_name  = "security-health-analytics-config"
  enable_asset_discovery = true
  config {
    enable_asset_discovery = true
  }
}

# Create a Security Health Analytics custom config
resource "google_security_center_security_health_analytics_custom_config" "default" {
  parent = "organizations/your-org-id"
  display_name = "security-health-analytics-custom-config"
  security_health_analytics_config = google_security_center_security_health_analytics_config.default.name
  finding_sources {
    finding_source_properties {
      resource_types = ["compute.googleapis.com/Disk"]
      threat_types = ["HOSTILE_ACTIVITY"]
    }
  }
}

  

      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um recurso Cloud Armor Security Policy
resource "google_compute_security_policy" "default" {
  name     = "default"
  description = "Security Policy for Cloud Armor"
  type     = "CLOUD_ARMOR"
}

# Crie uma regra de proteção para o recurso Cloud Armor
resource "google_compute_security_policy_rule" "default" {
  security_policy = google_compute_security_policy.default.id
  priority        = 1000
  match           = <<MATCH
  match_version = "V1"
  layer4_config {
    match_criteria = "ANY_MATCH"
    http_options {
      request_header_match_options {
        header_name        = "X-Forwarded-For"
        match_criteria = "ANY_MATCH"
        string_match_options {
          match_criteria  = "CONTAINS"
          contains_string = "192.168.0.1"
        }
      }
    }
  }
  action = "deny"
  MATCH
}

# Crie um recurso de proteção de Cloud Armor
resource "google_compute_firewall_policy" "default" {
  name         = "default"
  description  = "Firewall Policy for Cloud Armor"
  parent        = "projects/your-project-id/global/firewallPolicies"
  priority      = 1000
  display_name = "default"
  enforcement_order = "AFTER_CLASSIC_FIREWALL"
  fingerprint = "your-fingerprint"
  security_policy {
    name = google_compute_security_policy.default.name
  }
}

# Crie uma regra de firewall
resource "google_compute_firewall_policy_rule" "default" {
  firewall_policy = google_compute_firewall_policy.default.id
  priority        = 1000
  match           = <<MATCH
  match_version = "V1"
  layer4_config {
    match_criteria = "ANY_MATCH"
    http_options {
      request_header_match_options {
        header_name        = "X-Forwarded-For"
        match_criteria = "ANY_MATCH"
        string_match_options {
          match_criteria  = "CONTAINS"
          contains_string = "192.168.0.1"
        }
      }
    }
  }
  action = "deny"
  MATCH
}

# Crie um recurso de proteção de Cloud Armor
resource "google_compute_firewall_policy_rule_enforcement_order" "default" {
  firewall_policy = google_compute_firewall_policy.default.id
  priority        = 1000
  enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

# Crie um recurso de proteção de Cloud Armor
resource "google_compute_firewall_policy_rule_match" "default" {
  firewall_policy = google_compute_firewall_policy.default.id
  priority        = 1000
  match           = <<MATCH
  match_version = "V1"
  layer4_config {
    match_criteria = "ANY_MATCH"
    http_options {
      request_header_match_options {
        header_name        = "X-Forwarded-For"
        match_criteria = "ANY_MATCH"
        string_match_options {
          match_criteria  = "CONTAINS"
          contains_string = "192.168.0.1"
        }
      }
    }
  }
  MATCH
}

# Crie um recurso de proteção de Cloud Armor
resource "google_compute_firewall_policy_rule_action" "default" {
  firewall_policy = google_compute_firewall_policy.default.id
  priority        = 1000
  action           = "deny"
}

# Crie um recurso de proteção de Cloud Armor
resource "google_compute_firewall_policy_rule_layer4_config" "default" {
  firewall_policy = google_compute_firewall_policy.default.id
  priority        = 1000
  layer4_config {
    match_criteria = "ANY_MATCH"
    http_options {
      request_header_match_options {
        header_name        = "X-Forwarded-For"
        match_criteria = "ANY_MATCH"
        string_match_options {
          match_criteria  = "CONTAINS"
          contains_string = "192.168.0.1"
        }
      }
    }
  }
}

    
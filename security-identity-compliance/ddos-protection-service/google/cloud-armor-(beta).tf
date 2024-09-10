
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Armor security policy
resource "google_compute_security_policy" "default" {
  name     = "my-security-policy"
  description = "Security policy for my application"
  # Define the security policy rules
  rule {
    # Define a match rule to identify traffic based on the destination URL path
    match {
      # Match if the request path starts with `/api/`
      full_path_match {
        prefix_match = "\/api\/"
      }
    }
    # Define the action to take on matching traffic
    action {
      # Allow access for matching traffic
      allow {}
    }
  }
}

# Create a Cloud Armor security policy rule
resource "google_compute_security_policy_rule" "default" {
  security_policy = google_compute_security_policy.default.id
  priority       = 1000
  match {
    # Match if the request path starts with `/admin/`
    full_path_match {
      prefix_match = "\/admin\/"
    }
  }
  action {
    # Allow access for matching traffic
    allow {}
  }
}

# Create a Cloud Armor security policy rule
resource "google_compute_security_policy_rule" "deny_by_default" {
  security_policy = google_compute_security_policy.default.id
  priority       = 10000
  match {
    # Match all traffic by default
    full_path_match {
      prefix_match = "\/"
    }
  }
  action {
    # Deny access for matching traffic
    deny {}
  }
}

  
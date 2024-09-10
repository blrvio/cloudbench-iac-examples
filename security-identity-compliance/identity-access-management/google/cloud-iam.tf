
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a new IAM role
resource "google_iam_role" "my_role" {
  role_id    = "my-role"
  title     = "My IAM Role"
  description = "Example IAM role"
}

# Create a policy to grant permissions to the role
resource "google_iam_policy" "my_policy" {
  binding {
    role = "roles/storage.objectViewer"
    members = ["group:my-group@example.com"]
  }
  policy_id = "my-policy"
  title = "My IAM Policy"
}

# Attach the policy to the role
resource "google_iam_role_policy_attachment" "my_role_policy" {
  policy_id = google_iam_policy.my_policy.policy_id
  role = google_iam_role.my_role.role_id
}

# Create a service account
resource "google_service_account" "my_service_account" {
  account_id = "my-service-account"
  display_name = "My Service Account"
}

# Bind the role to the service account
resource "google_service_account_iam_binding" "my_service_account_role" {
  member = "serviceAccount:${google_service_account.my_service_account.email}"
  role = google_iam_role.my_role.role_id
}
  
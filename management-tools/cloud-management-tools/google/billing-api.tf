
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Define the billing account
resource "google_billing_account" "main" {
  display_name = "Your Billing Account"
}

# Define a billing budget
resource "google_billing_budget" "main" {
  billing_account_id = google_billing_account.main.account_id
  budget_filter {
    credit_type = "ALL"
  }
  amount {
    specified_amount {
      amount   = "1000"
      currency = "USD"
    }
  }
  name  = "Example Budget"
}

# Define a billing budget threshold rule
resource "google_billing_budget_threshold_rule" "main" {
  budget_id = google_billing_budget.main.id
  threshold_percent = "90"
}

# Define a billing subscription
resource "google_billing_subscription" "main" {
  billing_account_id = google_billing_account.main.account_id
  name              = "Your Subscription"
}

  
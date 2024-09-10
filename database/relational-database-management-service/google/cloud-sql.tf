
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create a Cloud SQL instance
resource "google_sql_database_instance" "default" {
  name         = "my-sql-instance"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-custom-1-3840"
    disk_autoresize = true
    disk_autoresize_limit = 1024
  }
  region = "us-central1" # Replace with your desired region
}

# Create a Cloud SQL database
resource "google_sql_database" "default" {
  name     = "my-database"
  instance = google_sql_database_instance.default.name
}

# Create a Cloud SQL user
resource "google_sql_user" "default" {
  name     = "my-user"
  instance = google_sql_database_instance.default.name
  password = "my-password"
}

# Grant privileges to the user
resource "google_sql_database_user" "default" {
  name     = "my-user"
  instance = google_sql_database_instance.default.name
  database = google_sql_database.default.name
  # Grant all privileges
  privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "ALTER", "DROP", "INDEX", "REFERENCES", "TRIGGER", "CREATE VIEW", "SHOW VIEW", "CREATE ROUTINE", "ALTER ROUTINE", "DROP ROUTINE"]
}

  
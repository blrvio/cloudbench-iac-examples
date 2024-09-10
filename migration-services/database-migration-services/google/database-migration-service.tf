
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Change to your preferred region
}

# Create a Cloud SQL instance
resource "google_sql_database_instance" "main" {
  name           = "my-cloud-sql-instance"
  region         = "us-central1" # Change to your preferred region
  database_version = "MYSQL_8_0"
  settings {
    tier             = "db-f1-micro"
    availability_type = "REGIONAL"
  }
  deletion_protection = false
}

# Create a Database Migration Service (DMS) instance
resource "google_dms_instance" "main" {
  name      = "my-dms-instance"
  location = "us-central1"
  labels = {
    "env" = "dev"
  }
  #  Optional settings for the DMS instance.
  # network = "projects/project-id/global/networks/default"
  # subnet   = "projects/project-id/regions/us-central1/subnetworks/default"
  # optional settings for the DMS instance.
  # machine_type = "dms-n1-standard-2"
  #  optional settings for the DMS instance.
  #  kms_key_name = "projects/project-id/locations/us-central1/keyRings/default/cryptoKeys/key-1"
}

# Create a Database Migration Service (DMS) migration job
resource "google_dms_migration_job" "main" {
  name     = "my-migration-job"
  instance = google_dms_instance.main.name
  source_database {
    # Specify database type and connection details. Example for MySQL
    # database_type = "MYSQL"
    # hostname = "my-mysql-server.com"
    # port = 3306
    # username = "username"
    # password = "password"
  }
  target_database {
    # Specify database type and connection details. Example for Cloud SQL
    # database_type = "CLOUD_SQL"
    # connection_name = "projects/project-id/instances/my-cloud-sql-instance"
  }
  migration_type    = "FULL_LOAD"
  #  Optional settings for the migration job
  #  schedule_config {
  #    enabled = true
  #  }
}

# Create a Cloud SQL database for the migrated data
resource "google_sql_database" "main" {
  name    = "my-migrated-database"
  instance = google_sql_database_instance.main.name
}

  
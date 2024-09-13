
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
}

# Crie uma instância do Cloud SQL
resource "google_sql_database" "default" {
  name     = "my-database"
  instance = google_sql_database_instance.default.name
}

resource "google_sql_database_instance" "default" {
  name                  = "my-sql-instance"
  database_version      = "MYSQL_5_7"
  region                = "us-central1"
  settings              = {
    tier = "db-custom-1-3840"
  }
  deletion_protection = false
}

# Crie um usuário do Cloud SQL
resource "google_sql_user" "default" {
  name     = "my-user"
  instance = google_sql_database_instance.default.name
  password = "my-password"
}
    
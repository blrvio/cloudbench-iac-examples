
      # Configure o provedor do Google Cloud
provider "google" {
  project = "my-gcp-project"
}

# Crie uma instância do Cloud Spanner
resource "google_spanner_instance" "default" {
  name         = "my-spanner-instance"
  config       = "regional-us-central1"
  display_name = "My Spanner Instance"
  node_count   = 1
}

# Crie um banco de dados no Cloud Spanner
resource "google_spanner_database" "default" {
  instance = google_spanner_instance.default.name
  name     = "my-spanner-database"
  ddl      = <<DDL
CREATE TABLE Singers (
  SingerId INT64 NOT NULL,
  FirstName STRING(1024),
  LastName STRING(1024),
  SingerInfo STRING(1024),
PRIMARY KEY (SingerId)
)
DDL
}

# Crie um usuário do Cloud Spanner
resource "google_spanner_database_user" "default" {
  database = google_spanner_database.default.name
  instance = google_spanner_instance.default.name
  name     = "my-spanner-user"
  roles    = ["roles/spanner.databaseReader"]
}
    
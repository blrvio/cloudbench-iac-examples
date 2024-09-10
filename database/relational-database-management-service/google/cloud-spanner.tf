
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Spanner Instance
resource "google_spanner_instance" "default" {
  name     = "my-spanner-instance"
  config   = "regional-us-central1"
  node_count = 1
  display_name = "My Spanner Instance"
}

# Create a Cloud Spanner Database
resource "google_spanner_database" "default" {
  instance  = google_spanner_instance.default.name
  name      = "my-spanner-database"
  ddl_statements = [
    "CREATE TABLE Singers (
      SingerId INT64 NOT NULL,
      FirstName STRING(1024),
      LastName STRING(1024),
      SingerInfo BYTES(MAX)
    ) PRIMARY KEY (SingerId)"
  ]
}

# Create a Cloud Spanner Table
resource "google_spanner_table" "default" {
  instance  = google_spanner_instance.default.name
  database = google_spanner_database.default.name
  name      = "Albums"
  ddl_statements = [
    "CREATE TABLE Albums (
      AlbumId INT64 NOT NULL,
      SingerId INT64,
      AlbumTitle STRING(1024),
      AlbumInfo BYTES(MAX)
    ) PRIMARY KEY (AlbumId),
    FOREIGN KEY (SingerId) REFERENCES Singers(SingerId)"
  ]
}
  
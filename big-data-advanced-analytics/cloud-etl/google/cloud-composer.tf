
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela região desejada
}

# Crie um ambiente Cloud Composer
resource "google_composer_environment" "default" {
  name     = "composer-env"
  location = google_composer_environment.default.location
  config {
    node_config {
      machine_type = "n1-standard-1"
    }
    software_config {
      airflow_config_overrides = {
        "core.scheduler_interval": "30",
        "core.dags_folder": "/usr/local/airflow/dags"
      }
    }
  }
}

# Crie um bucket do Google Cloud Storage para armazenar os DAGs
resource "google_storage_bucket" "dags" {
  name = "composer-dags"
  location = "US"
}

# Crie um serviço de conta de serviço para o Cloud Composer
resource "google_service_account" "composer_service_account" {
  account_id   = "composer-sa"
  display_name = "Cloud Composer Service Account"
  disabled     = false
}

# Crie uma função IAM para o Cloud Composer
resource "google_project_iam_member" "composer_role" {
  role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member = "serviceAccount:${google_service_account.composer_service_account.email}"
}

# Crie um bucket do Google Cloud Storage para armazenar os logs
resource "google_storage_bucket" "logs" {
  name = "composer-logs"
  location = "US"
}

# Crie um sink para coletar os logs do Cloud Composer no bucket
resource "google_logging_sink" "composer_logs" {
  name = "composer-logs"
  destination = "storage.googleapis.com/composer-logs"
  filter = "resource.type="cloudcomposer.googleapis.com/environment" AND logName="cloudcomposer.googleapis.com/audit"
}

# Crie um bucket do Google Cloud Storage para armazenar os arquivos de trabalho do Cloud Composer
resource "google_storage_bucket" "work" {
  name = "composer-work"
  location = "US"
}
    
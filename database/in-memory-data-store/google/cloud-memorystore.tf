
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create a Cloud Memorystore for Redis instance
resource "google_redis_instance" "main" {
  name         = "my-redis-instance"
  location     = "us-central1"
  tier         = "BASIC"
  memory_size_gb = 1 # Minimum memory size
  redis_version = "REDIS_5_0"
}

  
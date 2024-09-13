
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um cluster do Kubernetes Engine
resource "google_container_cluster" "main" {
  name     = "my-cluster"
  location = google_container_cluster.main.location
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
  network = "projects/your-project-id/global/networks/default"
  subnetwork = "projects/your-project-id/regions/us-central1/subnetworks/default"

  ip_allocation_policy {
    use_ip_aliases = true
  }
  master_auth {
    username = "admin"
  }
  network_policy {
    enabled = true
  }
}

# Crie um namespace para os seus aplicativos
resource "google_container_namespace" "default" {
  cluster = google_container_cluster.main.name
  location = google_container_cluster.main.location
  name     = "default"
}

# Importe a imagem Docker do seu aplicativo
resource "google_container_image" "my-app" {
  name    = "my-app"
  location = google_container_cluster.main.location
  cluster = google_container_cluster.main.name
  image_url = "us-docker.pkg.dev/cloudrun/container/hello"
}

# Crie um deployment para o seu aplicativo
resource "google_container_deployment" "my-app" {
  cluster = google_container_cluster.main.name
  location = google_container_cluster.main.location
  name     = "my-app"
  namespace = "default"

  template {
    spec {
      containers {
        image = google_container_image.my-app.name
        name  = "my-app"
        ports {
          container_port = 8080
        }
      }
    }
  }
}

# Crie um service para expor o seu aplicativo
resource "google_container_service" "my-app" {
  cluster = google_container_cluster.main.name
  location = google_container_cluster.main.location
  name     = "my-app"
  namespace = "default"

  spec {
    selector {
      app = "my-app"
    }
    ports {
      port     = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
    
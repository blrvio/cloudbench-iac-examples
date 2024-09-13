
      # Configure o provedor do OpenShift
provider "openshift" {
  # Substitua pelos seus valores
  api_url  = "https://api.openshift.com"
  token    = "your_access_token"
  namespace = "your_namespace"
}

# Crie um namespace
resource "openshift_namespace" "my_namespace" {
  metadata {
    name = "my-namespace"
  }
}

# Crie um deployment
resource "openshift_deployment" "my_deployment" {
  metadata {
    name = "my-deployment"
    namespace = openshift_namespace.my_namespace.metadata.0.name
  }
  spec {
    replicas = 3 # Número de réplicas
    selector {
      match_labels = {
        app = "my-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }
      spec {
        containers {
          name = "my-app"
          image = "nginx:latest"
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

# Crie um service
resource "openshift_service" "my_service" {
  metadata {
    name = "my-service"
    namespace = openshift_namespace.my_namespace.metadata.0.name
  }
  spec {
    selector = {
      app = "my-app"
    }
    ports {
      port       = 80
      target_port = 80
    }
  }
}
    
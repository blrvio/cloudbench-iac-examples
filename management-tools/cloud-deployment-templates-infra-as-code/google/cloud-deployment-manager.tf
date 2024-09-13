
      # Configure o provedor do Google Cloud
provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}

# Crie uma configuração de implantação
resource "google_deployment_manager_deployment" "main" {
  name = "my-deployment"
  manifest = <<MANIFEST
{
  "resources": [
    {
      "type": "compute.v1.instance",
      "name": "my-instance",
      "properties": {
        "machineType": "n1-standard-1",
        "zone": "us-central1-a",
        "disk": {
          "sourceImage": "centos-cloud/centos-7"
        }
      }
    }
  ]
}
MANIFEST
}

    
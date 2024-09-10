
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Define the Deployment Manager deployment
resource "google_deployment_manager_deployment" "main" {
  name     = "my-deployment"
  manifest = <<EOF
resources:
  - type: "compute.v1.instance"
    name: "my-instance"
    properties:
      zone: "us-central1-a"
      machineType: "n1-standard-1"
      disks:
      - sourceImage: "centos-cloud/centos-7"
      networkInterfaces:
      - network: "default"
      name: "my-instance"
      metadata:
        items:
        - key: "startup-script"
          value: |
            #!/bin/bash
            echo "Hello, world!" > /var/www/html/index.html
EOF
}

  
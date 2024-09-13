
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela região desejada
}

# Crie uma instância do Compute Engine
resource "google_compute_instance" "default" {
  name         = "instance-1"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"
  }
}

# Crie um endereço IP externo estático
resource "google_compute_address" "default" {
  name   = "external-ip"
  address_type = "EXTERNAL"
  project = "gcp-project-id"
}

# Associe o endereço IP externo à instância
resource "google_compute_instance_from_template" "default" {
  name    = "instance-1"
  zone    = "us-central1-a"
  machine_type = "n1-standard-1"
  source_instance_template = google_compute_instance_template.default.self_link
  network_interface {
    network = "default"
    subnetwork = "projects/gcp-project-id/regions/us-central1/subnetworks/default"
  }

  network_performance_config {
    total_egress_bandwidth_tier = "DEFAULT"
  }

  can_ip_forward = false

  confidential_instance_config {
    enable_confidential_compute = false
  }

  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
    disk_type = "pd-standard"
    type = "PERSISTENT"
  }

  advanced_machine_features {
    enable_nested_virtualization = false
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  metadata {
    "startup-script" = "#!/bin/bash\n# Update the system\napt-get update -y\n# Install Apache\napt-get install apache2 -y\n# Start Apache\nservice apache2 start\n# Ensure Apache starts on boot\nupdate-rc.d apache2 defaults"
  }
  project = "gcp-project-id"
}

# Crie um template de instância para reutilização
resource "google_compute_instance_template" "default" {
  name_prefix  = "template-instance-"
  machine_type = "n1-standard-1"
  can_ip_forward = false

  confidential_instance_config {
    enable_confidential_compute = false
  }

  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
    disk_type = "pd-standard"
    type = "PERSISTENT"
  }

  advanced_machine_features {
    enable_nested_virtualization = false
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  network_interface {
    network = "default"
    subnetwork = "projects/gcp-project-id/regions/us-central1/subnetworks/default"
  }

  metadata {
    "startup-script" = "#!/bin/bash\n# Update the system\napt-get update -y\n# Install Apache\napt-get install apache2 -y\n# Start Apache\nservice apache2 start\n# Ensure Apache starts on boot\nupdate-rc.d apache2 defaults"
  }
  project = "gcp-project-id"
}
    
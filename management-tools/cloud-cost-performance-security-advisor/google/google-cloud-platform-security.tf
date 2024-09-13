
      # Configure o provedor do GCP
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela região desejada
}

# Crie um grupo de segurança para permitir o acesso SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Crie uma instância do Compute Engine
resource "google_compute_instance" "web_server" {
  name         = "web-server"
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
  network_performance_config {
    total_egress_bandwidth_tier = "DEFAULT"
  }
  can_ip_forward = false
  deletion_protection = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  metadata = {
    "startup-script" = "#!/bin/bash\n# Instale o Apache\nyum update -y\nyum install httpd -y\n# Inicie o servidor web\nsystemctl enable httpd\nsystemctl start httpd"
  }
  project = "gcp-project-id"
}

# Crie um endereço IP externo
resource "google_compute_address" "web_server_ip" {
  name   = "web-server-ip"
  address_type = "EXTERNAL"
  project      = "gcp-project-id"
  region       = "us-central1"
}

# Associe o endereço IP externo à instância do Compute Engine
resource "google_compute_instance_from_template" "web_server_association" {
  name         = "web-server-association"
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
  network_performance_config {
    total_egress_bandwidth_tier = "DEFAULT"
  }
  can_ip_forward = false
  deletion_protection = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  metadata = {
    "startup-script" = "#!/bin/bash\n# Instale o Apache\nyum update -y\nyum install httpd -y\n# Inicie o servidor web\nsystemctl enable httpd\nsystemctl start httpd"
  }
  project = "gcp-project-id"
  network_interface {
    network = "default"
    subnetwork = "projects/gcp-project-id/regions/us-central1/subnetworks/default"
    subnetwork_project = "gcp-project-id"
    network_ip = google_compute_address.web_server_ip.address
  }
  advanced_machine_features {
    enable_nested_virtualization = false
  }
  source_machine_image = "centos-cloud/centos-7"
}
    
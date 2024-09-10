
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Define the target instance template
resource "google_compute_instance_template" "default" {
  name_prefix  = "autoscaler-instance-template-"
  machine_type = "n1-standard-1"
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
  }
  network_interface {
    subnetwork  = "projects/your-gcp-project-id/regions/us-central1/subnetworks/default"
    network_ip = "10.128.0.1"
  }
}

# Define the target instance group manager
resource "google_compute_region_instance_group_manager" "default" {
  name           = "autoscaler-instance-group-manager"
  version         = 0
  base_instance_name = "autoscaler-instance-group"
  list_managed_instances_results = "PAGELESS"
  region          = "us-central1"

  # Configure the instance template
  instance_template = google_compute_instance_template.default.self_link
}

# Define the autoscaler
resource "google_compute_autoscaler" "default" {
  name         = "autoscaler"
  project      = "your-gcp-project-id"
  zone         = "us-central1-a"
  target       = google_compute_region_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target              = 0.5
    }
  }
}
  
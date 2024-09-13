
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um cluster do DataProc
resource "google_dataproc_cluster" "main" {
  name     = "my-dataproc-cluster"
  region   = "us-central1"
  master_config {
    num_instances = 2
    machine_type   = "n1-standard-1"
    disk_config {
      boot_disk_type = "pd-standard"
      boot_disk_size_gb = 100
    }
  }
  worker_config {
    num_instances = 2
    machine_type   = "n1-standard-1"
    disk_config {
      boot_disk_type = "pd-standard"
      boot_disk_size_gb = 100
    }
  }
}

# Crie um job do DataProc
resource "google_dataproc_job" "wordcount" {
  cluster_name = google_dataproc_cluster.main.name
  placement {
    region = google_dataproc_cluster.main.region
  }
  pyspark_job {
    main_python_file_uri = "gs://your-bucket/wordcount.py"
  }
}
    
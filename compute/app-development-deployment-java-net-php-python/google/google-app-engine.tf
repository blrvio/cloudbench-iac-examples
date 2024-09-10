
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create an App Engine application
resource "google_app_engine_application" "main" {
  name = "my-appengine-app"
}

# Create an App Engine service
resource "google_app_engine_service" "main" {
  name     = "my-appengine-service"
  app_id   = google_app_engine_application.main.name
  location = "us-central1"
  # Optional settings
  #  runtime_version = "nodejs18"
  #  threadsafe = false
  #  entry_point = "main"
  #  env = "standard"
  #  basic_scaling {
  #    max_instances = 20
  #    min_instances = 2
  #  }
  #  manual_scaling {
  #    instances = 2
  #  }
  #  network_settings {
  #    ingress { 
  #      all_traffic = true
  #    }
  #    egress { 
  #      all_traffic = true
  #    }
  #  }
  #  ingress {
  #    all_traffic = true
  #  }
  #  egress {
  #    all_traffic = true
  #  }
}

# Create an App Engine version
resource "google_app_engine_version" "main" {
  app_id   = google_app_engine_application.main.name
  service  = google_app_engine_service.main.name
  version  = "v1"
  location = "us-central1"
  # Optional settings
  #  runtime = "nodejs18"
  #  entry_point = "main"
  #  threadsafe = false
  #  env = "standard"
  #  runtime_channel = "default"
  #  serving_status = "SERVING"
  #  basic_scaling {
  #    max_instances = 20
  #    min_instances = 2
  #  }
  #  manual_scaling {
  #    instances = 2
  #  }
  #  network_settings {
  #    ingress { 
  #      all_traffic = true
  #    }
  #    egress { 
  #      all_traffic = true
  #    }
  #  }
  #  ingress {
  #    all_traffic = true
  #  }
  #  egress {
  #    all_traffic = true
  #  }
}

# Create an App Engine deployment
resource "google_app_engine_deployment" "main" {
  app_id   = google_app_engine_application.main.name
  service  = google_app_engine_service.main.name
  version  = "v1"
  location = "us-central1"
  # Optional settings
  #  source {
  #    archive_url = "gs://my-bucket/my-app.zip"
  #  }
  #  source {
  #    storage_source {
  #      bucket = "my-bucket"
  #      object = "my-app.zip"
  #    }
  #  }
  #  source {
  #    zip {
  #      files = [ "src/main/java/com/example/MyServlet.java" ]
  #    }
  #  }
  #  source {
  #    zip {
  #      files = [ "src/main/java/com/example/MyServlet.java" ]
  #      exclude_paths = [ "**/*.txt" ]
  #    }
  #  }
}

  
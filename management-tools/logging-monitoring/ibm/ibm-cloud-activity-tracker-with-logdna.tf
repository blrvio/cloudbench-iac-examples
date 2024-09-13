
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_API_KEY"
}

# Crie um recurso de rastreamento de atividades
resource "ibm_activity_tracker_tracker" "my_tracker" {
  name     = "my_tracker"
  location = "us-south"
}

# Crie um recurso de LogDNA
resource "ibm_logdna_logdna" "my_logdna" {
  name      = "my_logdna"
  region     = "us-south"
  plan      = "basic"
  retention = 30
}

# Configure o LogDNA para receber os eventos de rastreamento
resource "ibm_activity_tracker_logdna_integration" "my_integration" {
  tracker_id = ibm_activity_tracker_tracker.my_tracker.id
  logdna_id  = ibm_logdna_logdna.my_logdna.id
}
    
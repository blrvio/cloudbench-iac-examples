
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Crie um recurso de LogDNA
resource "ibm_logdna_ingestion_key" "logdna_key" {
  org_id = "YOUR_ORG_ID"
  name     = "my-logdna-key"
}

# Crie um recurso de LogDNA
resource "ibm_logdna_source" "logdna_source" {
  org_id = "YOUR_ORG_ID"
  name     = "my-logdna-source"
  key      = ibm_logdna_ingestion_key.logdna_key.id
}

# Crie um recurso de LogDNA
resource "ibm_logdna_dashboard" "logdna_dashboard" {
  org_id = "YOUR_ORG_ID"
  name     = "my-logdna-dashboard"
  source   = ibm_logdna_source.logdna_source.id
}
    

      # Configure o provedor do OCI
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
}

# Crie um job do Data Flow
resource "oci_dataflow_job" "example_job" {
  display_name = "My Data Flow Job"
  description  = "This is an example Data Flow job"
  project_id  = "ocid1.project.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa" # Substitua pelo ID do seu projeto
  runtime_config {
    properties {
      "key1" = "value1"
      "key2" = "value2"
    }
  }
}

# Crie um pipeline do Data Flow
resource "oci_dataflow_pipeline" "example_pipeline" {
  display_name = "My Data Flow Pipeline"
  description  = "This is an example Data Flow pipeline"
  project_id  = "ocid1.project.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa" # Substitua pelo ID do seu projeto
  job_id      = oci_dataflow_job.example_job.id

  schedule_config {
    cron_expression = "0 0 * * * ?" # Substitua pela expressão cron desejada
    timezone        = "America/Los_Angeles" # Substitua pelo fuso horário desejado
  }
}

# Crie um aplicativo do Data Flow
resource "oci_dataflow_application" "example_application" {
  display_name = "My Data Flow Application"
  description  = "This is an example Data Flow application"
  project_id  = "ocid1.project.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa" # Substitua pelo ID do seu projeto
  pipeline_id  = oci_dataflow_pipeline.example_pipeline.id
}

    
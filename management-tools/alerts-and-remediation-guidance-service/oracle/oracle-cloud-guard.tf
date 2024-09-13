
      # Configure o provedor Oracle Cloud
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
}

# Crie uma regra de Cloud Guard
resource "oci_cloud_guard_detector_rule" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Substitua pelo ID do compartimento
  name            = "example-rule"
  description      = "Regra de exemplo para Cloud Guard"
  detector_type   = "DEFAULT"
  detector_subtype = "COMPUTE"
  rule_type       = "PREVENTIVE"

  target_details {
    target_type   = "INSTANCE"
    target_details = "{"ANY"}"
  }

  actions {
    action_type = "ALERT"
  }

  severity        = "HIGH"
  enabled         = true
}

# Crie um detector de Cloud Guard
resource "oci_cloud_guard_detector" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Substitua pelo ID do compartimento
  name            = "example-detector"
  description      = "Detector de exemplo para Cloud Guard"
  enabled         = true
  detector_rule_ids = [oci_cloud_guard_detector_rule.example.id]
}

# Crie uma tarefa de Cloud Guard
resource "oci_cloud_guard_task" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Substitua pelo ID do compartimento
  name            = "example-task"
  description      = "Tarefa de exemplo para Cloud Guard"
  detector_id    = oci_cloud_guard_detector.example.id
  enabled         = true
}


    

      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
}

# Crie um monitoramento
resource "oci_monitoring_monitoring_definition" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw76w377533665455d66y76a"
  display_name   = "My Monitoring Definition"
  
  # Exemplo de regra de monitoramento
  monitoring_rule {
    description = "Monitor the CPU utilization of the instance"
    
    # Contexto da regra
    context {
      namespace = "oci_compute"
      resource_type = "instance"
      resource_id = "ocid1.instance.oc1.us-ashburn-1.aaaaaaaaw76w377533665455d66y76a"
    }
    
    # Critérios para a regra
    criteria {
      condition = "GREATER_THAN"
      threshold = 80
      metric = "cpu_utilization"
      aggregation_type = "AVERAGE"
      period = "1m"
    }
  }
}
    

      # Configure o provedor do IBM Cloud
provider "ibm" {
  region = "us-south"
  # Substitua pela sua região desejada
}

# Crie um monitoramento de aplicação
application_monitoring "my_app_monitor" {
  name     = "My Application Monitor"
  app_id   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  # Substitua pelo ID da sua aplicação
}

# Crie um monitoramento de infraestrutura
infrastructure_monitoring "my_infra_monitor" {
  name     = "My Infrastructure Monitor"
  resource_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  # Substitua pelo ID do seu recurso
}

# Crie um alerta
alert "my_alert" {
  name           = "My Alert"
  monitor_type  = "application"
  # Ou 'infrastructure'
  monitor_id    = ibm_application_monitoring.my_app_monitor.id
  # Ou ibm_infrastructure_monitoring.my_infra_monitor.id
  condition      = "metric_value > 100"
  # Substitua pela sua condição
}

    
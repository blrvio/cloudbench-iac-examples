
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um fluxo de dados do AppFlow
resource "aws_appflow_flow" "example" {
  name = "example-flow"

  flow_config {
    source_flow_config {
      connector_type = "Salesforce"
      connector_properties {
        # Configurações específicas do Salesforce
      }
    }

    destination_flow_config {
      connector_type = "S3"
      connector_properties {
        # Configurações específicas do S3
      }
    }
  }

  trigger_config {
    trigger_type = "Schedule"
    schedule_config {
      schedule_expression = "cron(0 0 * * ? *) # Executa diariamente às 00:00"
    }
  }
}

    
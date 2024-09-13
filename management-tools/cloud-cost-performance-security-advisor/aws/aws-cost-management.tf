
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma tag de custo para identificar recursos
resource "aws_cost_explorer_tag" "example_tag" {
  name = "MyCostTag"
  value = "Development"
}

# Crie um relatório de custos
resource "aws_cost_explorer_report" "example_report" {
  name = "MyCostReport"
  time_unit = "MONTHLY"
  report_type = "COST_AND_USAGE"
  delivery_frequency = "DAILY"

  # Configurações de entrega
  delivery_config {
    s3_bucket = "my-cost-reports-bucket" # Substitua pelo nome do bucket S3
    s3_prefix = "reports/"
  }

  # Filtros de custos
  cost_filter {
    name   = "TagKey"
    values = ["MyCostTag"]
  }
}

    
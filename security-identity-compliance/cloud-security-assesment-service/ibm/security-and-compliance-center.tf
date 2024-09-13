
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Security Hub padrão
resource "aws_securityhub_account" "default" {
  enable_default_standards = true
}

# Crie uma regra de avaliação personalizada
resource "aws_securityhub_insight" "example_insight" {
  name = "Example Insight"
  filters = <<EOF
    { "key": "aws:securityhub:ProductName", "values": ["Amazon S3"] }
    { "key": "aws:securityhub:Severity", "values": ["High"] }
  EOF
}

# Crie uma regra de avaliação personalizada
resource "aws_securityhub_standards_subscription" "example_standards_subscription" {
  standards_subscription_arns = ["arn:aws:securityhub:us-east-1:123456789012:standards/pci_dss_v3_2"] # Substitua pelo ARN do padrão desejado
  standards_input {
    standards_arn = "arn:aws:securityhub:us-east-1:123456789012:standards/pci_dss_v3_2"
  }
}
    
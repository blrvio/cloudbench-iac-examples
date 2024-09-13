
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Habilite o Security Hub
resource "aws_securityhub_account" "this" {
  enable_default_findings = true
  tags = {
    Name = "Security Hub Account"
  }
}

# Crie uma regra de detecção personalizada
resource "aws_securityhub_insight" "this" {
  name     = "My Custom Insight"
  filters = <<FILTER
[{"FindingTypes": [{"Value": "Software and Configuration Checks/AWS Security Best Practices"}]}, {"Severity": [{"Value": "HIGH"}]}]
FILTER
}

    
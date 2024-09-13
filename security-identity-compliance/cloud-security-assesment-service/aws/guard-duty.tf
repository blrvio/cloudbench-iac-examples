
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um detector GuardDuty
resource "aws_guardduty_detector" "example" {
  enable  = true
  finding_publishing_frequency = "ONE_HOUR"
}

# Crie uma regra de detecção personalizada
resource "aws_guardduty_detector_finding_filter" "example" {
  detector_id  = aws_guardduty_detector.example.id
  action       = "ARCHIVE"
  description = "Regra personalizada para bloquear IPs maliciosos"
  filter {
    action      = "ALLOW"
    finding_type = "SuspiciousActivity"
    condition = "EQUALS"
    value      = "malicious_ip"
  }
}
    
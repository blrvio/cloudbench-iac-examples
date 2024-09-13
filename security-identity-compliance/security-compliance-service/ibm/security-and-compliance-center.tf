
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um controle personalizado
resource "aws_securityhub_custom_control" "example" {
  name  = "Example Custom Control"
  type = "CUSTOM_CONTROL"
  description = "Example custom control for testing purposes"
  control_id = "CUSTOM_CONTROL_1"
  disabled    = false
  severity  = "LOW"
  input_parameters = <<EOF
{
  "name": "Example Parameter 1",
  "type": "STRING",
  "description": "This is an example parameter",
  "required": true
}
EOF
  evaluation_parameters = <<EOF
{
  "name": "Example Parameter 1",
  "value": "Example Value 1"
}
EOF
  control_guidance = "Example guidance for this control"
  security_guidance = "Example security guidance for this control"
  remediation_guidance = "Example remediation guidance for this control"
}

# Crie uma regra de auto-remediação para o controle personalizado
resource "aws_securityhub_custom_control_auto_remediation_rule" "example" {
  control_id = aws_securityhub_custom_control.example.id
  action      = "SUPPRESS"
  name        = "Example Auto Remediation Rule"
  rule_details = <<EOF
{
  "name": "Example Parameter 1",
  "value": "Example Value 1"
}
EOF
  disabled = false
}

# Crie uma regra de auto-remediação para um controle integrado
resource "aws_securityhub_auto_remediation_rule" "example" {
  control_id = "AWS_EC2_201"
  action      = "SUPPRESS"
  name        = "Example Auto Remediation Rule"
  rule_details = <<EOF
{
  "name": "Example Parameter 1",
  "value": "Example Value 1"
}
EOF
  disabled = false
}

# Crie uma regra de auto-remediação para um controle integrado
resource "aws_securityhub_auto_remediation_rule" "example" {
  control_id = "AWS_EC2_201"
  action      = "SUPPRESS"
  name        = "Example Auto Remediation Rule"
  rule_details = <<EOF
{
  "name": "Example Parameter 1",
  "value": "Example Value 1"
}
EOF
  disabled = false
}
    
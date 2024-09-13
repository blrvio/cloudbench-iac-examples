
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um endpoint do AWS IoT
resource "aws_iot_endpoint" "example" {
  endpoint_type = "iot:Data-ATS"
}

# Crie uma política para o AWS IoT
resource "aws_iot_policy" "example" {
  name = "example"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Publish",
        "iot:Subscribe"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

# Crie um certificado do AWS IoT
resource "aws_iot_certificate" "example" {
  active = true
}

# Crie uma coisa do AWS IoT
resource "aws_iot_thing" "example" {
  name = "example"
  tags = {
    Name = "example"
  }
}

# Crie um registro de coisa do AWS IoT
resource "aws_iot_thing_registration" "example" {
  certificate_pem = aws_iot_certificate.example.certificate_pem
  thing_name       = aws_iot_thing.example.name
}

# Crie uma regra do AWS IoT
resource "aws_iot_rule" "example" {
  rule_disabled = false
  sql            = "SELECT * FROM 'topic/'"
  aws_iot_sql    = true
  actions = [
    {
      "cloudwatch_metric_action" {
        "metric_name"     = "example"
        "metric_namespace" = "example"
        "metric_value"     = "1"
        "role_arn"        = "arn:aws:iam::xxxxxxxxxxxx:role/example"
      }
    }
  ]
}

    
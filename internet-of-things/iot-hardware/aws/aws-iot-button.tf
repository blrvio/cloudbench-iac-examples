
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie uma regra de endpoint para o botão IoT
resource "aws_iot_endpoint" "button_endpoint" {
  endpoint_type = "iot_button"
  endpoint_id = "my-button-endpoint"
  description  = "Endpoint para o botão IoT"
}

# Crie um tópico do MQTT para o botão IoT
resource "aws_iot_topic_rule" "button_topic_rule" {
  topic = "my-button-topic"
  rule_disabled = false
  sql = "SELECT * FROM '$aws/events/thing/+/button/click'" # Seleciona eventos de clique do botão
  actions {
    cloudwatch_metrics {
      metric_name  = "ButtonClicks"
      metric_namespace = "MyButtonMetrics"
      metric_value = "1"
      metric_unit = "Count"
    }
  }
}

# Crie um certificado para o botão IoT
resource "aws_iot_certificate" "button_certificate" {
  certificate_pem = "-----BEGIN CERTIFICATE-----
[...]
-----END CERTIFICATE-----"
}

# Crie uma política para o botão IoT
resource "aws_iot_policy" "button_policy" {
  name = "button-policy"
  policy = "{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "iot:Publish",
          "iot:Receive"
        ],
        "Resource": "arn:aws:iot:*:*:topic/my-button-topic"
      }
    ]
  }"
}

# Anexa a política ao certificado
resource "aws_iot_certificate_policy" "button_certificate_policy" {
  certificate_id = aws_iot_certificate.button_certificate.id
  policy_name    = aws_iot_policy.button_policy.name
}

# Crie a coisa do IoT para o botão
resource "aws_iot_thing" "button_thing" {
  name = "my-button-thing"
  thing_type_name = "my-button-type"
  tags = {
    Name = "My Button"
  }
}

# Anexa o certificado à coisa do IoT
resource "aws_iot_thing_principal_attachment" "button_attachment" {
  thing_name = aws_iot_thing.button_thing.name
  principal   = aws_iot_certificate.button_certificate.arn
}

    
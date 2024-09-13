
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um certificado de IoT
resource "aws_iot_certificate" "cert" {
  active = true
}

# Crie uma coisa do IoT
resource "aws_iot_thing" "thing" {
  name = "my_thing"
}

# Adicione o certificado à coisa
resource "aws_iot_thing_principal_attachment" "attachment" {
  principal = aws_iot_certificate.cert.arn
  thing = aws_iot_thing.thing.name
}
    
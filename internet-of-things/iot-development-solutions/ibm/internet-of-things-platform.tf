
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um endpoint de coisas
resource "aws_iot_endpoint" "my_endpoint" {
  endpoint_type = "iot:Data"
}

# Crie uma política de coisas
resource "aws_iot_policy" "my_policy" {
  name = "my_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "iot:Connect",
          "iot:Publish",
          "iot:Subscribe"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Crie um certificado de coisa
resource "aws_iot_certificate" "my_certificate" {
  active = true
}

# Crie uma coisa
resource "aws_iot_thing" "my_thing" {
  name = "my_thing"
}

# Adicione a coisa à política
resource "aws_iot_thing_principal_attachment" "my_thing_policy_attachment" {
  principal = aws_iot_certificate.my_certificate.arn
  thing     = aws_iot_thing.my_thing.name
}

# Adicione a coisa ao endpoint
resource "aws_iot_thing_endpoint" "my_thing_endpoint" {
  thing_name   = aws_iot_thing.my_thing.name
  endpoint_type = aws_iot_endpoint.my_endpoint.endpoint_type
}
    
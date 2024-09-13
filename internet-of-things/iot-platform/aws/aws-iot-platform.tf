
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um certificado IoT
resource "aws_iot_certificate" "example" {
  active = true
}

# Crie uma política IoT
resource "aws_iot_policy" "example" {
  name = "example"
  policy = <<POLICY
{
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
}
POLICY
}

# Anexar uma política a um certificado IoT
resource "aws_iot_certificate_attachment" "example" {
  certificate_id = aws_iot_certificate.example.id
  policy_name = aws_iot_policy.example.name
}
    
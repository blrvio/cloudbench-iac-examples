
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um perfil de rastreamento X-Ray
resource "aws_xray_sampling_rule" "default" {
  rule_name    = "default"
  rule_arn     = "arn:aws:xray:us-east-1:123456789012:sampling-rule:default"
  sampling_rate = 0.5 # Taxa de amostragem (0.0 a 1.0)

  service {
    service_name  = "MyService"
    service_type  = "AWS::Lambda::Function"
    host          = "my-service.amazonaws.com"
    http_method   = "GET"
    url_path      = "/my-path"
  }
}

# Crie um grupo de recursos X-Ray
resource "aws_xray_group" "my_group" {
  group_name = "MyGroup"

  filter {
    filter_name = "service"
    filter_value = "MyService"
  }
}

# Crie um mapa de serviços X-Ray
resource "aws_xray_service_map" "my_service_map" {
  group_name = "MyGroup"
  service_map_name = "MyServiceMap"
}

# Crie uma conta de instrumentação X-Ray
resource "aws_xray_encryption_config" "default" {
  key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  # chave KMS para criptografar dados de rastreamento
}
    
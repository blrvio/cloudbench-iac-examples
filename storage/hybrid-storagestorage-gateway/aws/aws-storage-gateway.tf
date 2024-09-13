
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um gateway de armazenamento
resource "aws_storagegateway_gateway" "gateway" {
  gateway_name = "my-gateway"
  gateway_type = "FILE_GATEWAY"
  gateway_timezone = "America/Los_Angeles" # Substitua pelo fuso horário desejado
  gateway_location = "us-east-1" # Substitua pela região desejada
  # ... outras configurações de gateway (opcional)
}

# Crie um volume de gateway
resource "aws_storagegateway_volume" "volume" {
  gateway_arn  = aws_storagegateway_gateway.gateway.arn
  volume_type  = "STORED"
  volume_size_in_bytes = 1073741824 # 1 GB
  # ... outras configurações de volume (opcional)
}

# Crie uma associação de endpoint
resource "aws_storagegateway_endpoint" "endpoint" {
  gateway_arn = aws_storagegateway_gateway.gateway.arn
  endpoint_type  = "FILE_SHARE"
  target_path   = "/mnt/volume1" # Substitua pelo caminho do endpoint
  # ... outras configurações de endpoint (opcional)
}
    
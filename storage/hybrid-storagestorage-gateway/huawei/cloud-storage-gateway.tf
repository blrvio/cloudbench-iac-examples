
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um gateway de armazenamento
resource "aws_storagegateway_gateway" "gateway" {
  gateway_name = "my-gateway"
  gateway_type = "FILE_GATEWAY"
  gateway_location  = "us-east-1"
  gateway_timezone = "America/New_York"
}

# Crie um volume de gateway
resource "aws_storagegateway_volume" "volume" {
  gateway_arn = aws_storagegateway_gateway.gateway.arn
  volume_type = "STORED_VOLUME"
  source_volume_arn = "arn:aws:s3:::my-bucket/my-prefix"
  snapshot_schedule  = "hourly"
}

# Crie um endpoint de gateway
resource "aws_storagegateway_endpoint" "endpoint" {
  gateway_arn = aws_storagegateway_gateway.gateway.arn
  endpoint_type = "S3"
  target_path = "my-path"
  file_share_name = "my-share"
  file_share_access_control = "PRIVATE"
}
    
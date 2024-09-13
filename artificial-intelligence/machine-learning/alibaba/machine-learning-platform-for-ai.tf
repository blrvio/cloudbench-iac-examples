
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um endpoint de inferência
resource "aws_sagemaker_endpoint_config" "my_endpoint_config" {
  name         = "my-endpoint-config"
  endpoint_config_name = "my-endpoint-config"
  production_variants {
    initial_instance_count = 1
    instance_type         = "ml.t2.medium"
    model_name             = "my-model"
    variant_name           = "AllTraffic"
  }
}

resource "aws_sagemaker_endpoint" "my_endpoint" {
  name         = "my-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_config.my_endpoint_config.endpoint_config_name
}
    
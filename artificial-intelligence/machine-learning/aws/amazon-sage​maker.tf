
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um ponto de extremidade do SageMaker
resource "aws_sagemaker_endpoint_config" "example" {
  name = "example-endpoint-config"
  production_variants {
    initial_instance_count = 1
    instance_type          = "ml.t2.medium"
    model_name             = "example-model"
    variant_name            = "AllTraffic"
  }
}

# Crie um ponto de extremidade do SageMaker
resource "aws_sagemaker_endpoint" "example" {
  endpoint_config_name = aws_sagemaker_endpoint_config.example.name
  name                 = "example-endpoint"
}

# Crie um modelo de SageMaker
resource "aws_sagemaker_model" "example" {
  name    = "example-model"
  primary = true
  containers {
    image = "example-container-image"
  }
}
    
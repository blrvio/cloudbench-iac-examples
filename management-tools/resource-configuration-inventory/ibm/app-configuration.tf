
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um aplicativo App Configuration
resource "aws_appconfig_application" "example" {
  name = "example"
}

# Crie um ambiente App Configuration
resource "aws_appconfig_environment" "example" {
  application_id = aws_appconfig_application.example.id
  name          = "example"
}

# Crie um perfil de configuração App Configuration
resource "aws_appconfig_configuration_profile" "example" {
  application_id = aws_appconfig_application.example.id
  name          = "example"
  location_uri  = "s3://bucket-name/key/" # Substitua pelo URI do S3
}

# Crie um recurso de versão App Configuration
resource "aws_appconfig_deployment_strategy" "example" {
  application_id = aws_appconfig_application.example.id
  name          = "example"
  deployment_config {
    canary_interval    = 10
    canary_percentage  = 10
    deployment_duration_in_minutes = 10
    final_bake_time_in_minutes   = 10
  }
}

# Crie um recurso de versão App Configuration
resource "aws_appconfig_deployment_strategy" "example" {
  application_id = aws_appconfig_application.example.id
  name          = "example"
  deployment_config {
    canary_interval    = 10
    canary_percentage  = 10
    deployment_duration_in_minutes = 10
    final_bake_time_in_minutes   = 10
  }
}

# Crie um recurso de versão App Configuration
resource "aws_appconfig_deployment_strategy" "example" {
  application_id = aws_appconfig_application.example.id
  name          = "example"
  deployment_config {
    canary_interval    = 10
    canary_percentage  = 10
    deployment_duration_in_minutes = 10
    final_bake_time_in_minutes   = 10
  }
}

# Crie um recurso de versão App Configuration
resource "aws_appconfig_deployment_strategy" "example" {
  application_id = aws_appconfig_application.example.id
  name          = "example"
  deployment_config {
    canary_interval    = 10
    canary_percentage  = 10
    deployment_duration_in_minutes = 10
    final_bake_time_in_minutes   = 10
  }
}
    

      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um aplicativo CodeDeploy
resource "aws_codedeploy_app" "my_app" {
  name = "my_app"
}

# Crie um grupo de implantação CodeDeploy
resource "aws_codedeploy_deployment_group" "my_group" {
  app_name = aws_codedeploy_app.my_app.name
  service_role_arn = "arn:aws:iam::xxxxxxxx:role/codedeploy-service-role"
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  auto_rollback_configuration {
    enabled = true
    events = ["DEPLOYMENT_FAILURE"]
  }
  ec2_tag_filters {
    key   = "Name"
    type  = "KEY_ONLY"
    value = "web-server"
  }
}

# Crie um artefato CodeDeploy
resource "aws_codedeploy_deployment_config" "my_config" {
  name = "MyDeploymentConfig"
  minimum_healthy_hosts {
    value = 1
    type = "PERCENTAGE"
  }
  canary_interval  = 60 # segundos
  canary_percentage = 10
}
    
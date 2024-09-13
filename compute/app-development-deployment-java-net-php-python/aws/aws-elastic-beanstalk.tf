
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um ambiente Elastic Beanstalk
resource "aws_elastic_beanstalk_environment" "web_app" {
  application_name = "my-web-app" # Substitua pelo nome da sua aplicação
  environment_name = "web-app-env" # Substitua pelo nome do ambiente
  solution_stack_name = "64bit Amazon Linux 2 v3.2.3 running Node.js 14.x" # Substitua pelo stack desejado

  # Opções de configuração opcionais
  # cname_prefix = "my-web-app"
  # tier = "web"
  # version_label = "latest"
}

# Crie um aplicativo Elastic Beanstalk
resource "aws_elastic_beanstalk_application" "my_web_app" {
  name = "my-web-app"
}

    
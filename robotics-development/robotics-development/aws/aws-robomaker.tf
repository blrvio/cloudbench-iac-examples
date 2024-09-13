
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um espaço de trabalho do RoboMaker
resource "aws_robomaker_workspaces" "default" {
  name = "my-robomaker-workspace"
  # Substitua pelo nome do workspace desejado
}

# Crie um aplicativo de simulação do RoboMaker
resource "aws_robomaker_simulation_application" "default" {
  name = "my-simulation-application"
  # Substitua pelo nome do aplicativo de simulação desejado
  source_code = "s3://my-bucket/my-simulation-application.zip"
  # Substitua pelo caminho do código fonte do aplicativo de simulação no S3
  workspace_id = aws_robomaker_workspaces.default.id
}

# Crie uma definição de simulação do RoboMaker
resource "aws_robomaker_simulation_job" "default" {
  name = "my-simulation-job"
  # Substitua pelo nome da definição de simulação desejado
  simulation_application_name = aws_robomaker_simulation_application.default.name
  # Substitua pelo nome do aplicativo de simulação desejado
  output_location = "s3://my-bucket/my-simulation-job-output"
  # Substitua pelo caminho de saída no S3 para o resultado da simulação
}

# Crie uma definição de mundo do RoboMaker
resource "aws_robomaker_world" "default" {
  name = "my-world"
  # Substitua pelo nome da definição de mundo desejado
  workspace_id = aws_robomaker_workspaces.default.id
}

# Crie um robô do RoboMaker
resource "aws_robomaker_robot" "default" {
  name = "my-robot"
  # Substitua pelo nome do robô desejado
  greengrass_group_id = "my-greengrass-group"
  # Substitua pelo ID do grupo Greengrass desejado
  workspace_id = aws_robomaker_workspaces.default.id
}

    
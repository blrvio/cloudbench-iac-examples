
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um experimento de injeção de falhas
resource "aws_fis_experiment" "my_experiment" {
  name = "My Experiment"
  description = "My experiment description"
  targets {
    resource_type = "aws:ec2:instance"
    resource_id = "i-xxxxxxxx" # Substitua pelo ID da sua instância EC2
  }
  actions {
    action_type = "aws:ec2:terminate"
    parameters = {
      instance_id = "i-xxxxxxxx" # Substitua pelo ID da sua instância EC2
    }
  }
}

# Crie um cronograma para executar o experimento
resource "aws_fis_schedule" "my_schedule" {
  name = "My Schedule"
  experiment_arn = aws_fis_experiment.my_experiment.arn
  start_time = "2023-12-31T23:59:59Z"
  end_time = "2024-01-01T00:00:00Z"
  frequency = "onetime"
}

    
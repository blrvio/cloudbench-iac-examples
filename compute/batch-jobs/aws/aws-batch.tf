
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster de computação do AWS Batch
resource "aws_batch_compute_environment" "default" {
  compute_environment_name = "default"
  type                   = "MANAGED"
  service_role           = "arn:aws:iam::123456789012:role/aws-batch-service-role"
  state                  = "ENABLED"
}

# Crie um job do AWS Batch
resource "aws_batch_job_definition" "example" {
  job_definition_name  = "example"
  type                 = "container"
  container_properties {
    image                = "ubuntu:latest"
    command              = ["echo", "hello", "world"]
    memory               = 1024
    vcpus                = 1
  }
  retry_strategy {
    attempts    = 3
    evaluate_on_exit {
      on_status = "FAILED"
      on_reason = "" # Use uma string vazia para ignorar este campo
    }
  }
}

# Envie um job para o AWS Batch
resource "aws_batch_job_queue" "default" {
  job_queue_name = "default"
  priority        = 100
  compute_environment_order {
    order         = 1
    compute_environment = aws_batch_compute_environment.default.id
  }
}

# Execute o job
resource "aws_batch_job" "default" {
  job_definition      = aws_batch_job_definition.example.job_definition_name
  job_queue           = aws_batch_job_queue.default.job_queue_name
  job_name            = "example_job"
  container_overrides {
    command              = ["echo", "hello", "world"]
  }
}

    
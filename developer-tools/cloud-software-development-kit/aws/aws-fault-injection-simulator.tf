
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Fault Injection Simulator Experiment Template
resource "aws_fis_experiment_template" "example" {
  name        = "my-experiment-template"
  description = "Example fault injection experiment template"
  targets {
    # Target type can be "ecs", "lambda", "eks", "ec2"
    type = "ecs"
    # Specify the ECS cluster and task definition where the fault will be injected
    ecs_targets {
      cluster_arn         = "arn:aws:ecs:us-east-1:123456789012:cluster/my-cluster"
      task_definition_arn = "arn:aws:ecs:us-east-1:123456789012:task-definition/my-task-definition:1"
    }
  }
  actions {
    # Actions can be "network-partition", "resource-contention", "network-latency", "cpu-utilization", "memory-utilization", "http-error"
    type = "network-partition"
    # Specify the fault parameters
    network_partition {
      duration     = 30    # Duration of the fault in seconds
      percentage   = 20    # Percentage of traffic affected
      egress_only  = false # If true, only outbound traffic will be affected
      ingress_only = false # If true, only inbound traffic will be affected
    }
  }
}

# Create a Fault Injection Simulator Experiment
resource "aws_fis_experiment" "example" {
  name                   = "my-experiment"
  description            = "Example fault injection experiment"
  experiment_template_id = aws_fis_experiment_template.example.id
  # Schedule the experiment to run at a specific time
  schedule {
    start_time = "2024-01-01T00:00:00Z"
    end_time   = "2024-01-01T01:00:00Z"
    frequency  = "ONCE"
  }
}

  
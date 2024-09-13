
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um workspace do Amazon Managed Service for Prometheus
resource "aws_prometheus_workspace" "default" {
  name = "my-prometheus-workspace"
  alias = "my-prometheus-workspace-alias"
}

# Crie um alerta de Prometheus
resource "aws_prometheus_alert_rule" "default" {
  workspace_id = aws_prometheus_workspace.default.id
  name         = "high_cpu_alert"
  expression    = "sum(rate(cpu{job="node"}[5m])) by (instance) > 0.8"
  labels = {
    severity = "warning"
  }
  annotations = {
    summary = "High CPU utilization on node"
    description = "CPU utilization is exceeding 80%."
  }
}

# Crie um integração com o CloudWatch
resource "aws_prometheus_integration" "default" {
  workspace_id = aws_prometheus_workspace.default.id
  type          = "cloudwatch"
}

    
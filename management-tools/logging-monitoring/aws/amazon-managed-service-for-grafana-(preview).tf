
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um workspace do Amazon Managed Service for Grafana
resource "aws_grafana_workspace" "example" {
  name = "example"
  tags = {
    Name = "example"
  }
}

# Crie um usuário do Amazon Managed Service for Grafana
resource "aws_grafana_user" "example" {
  workspace_id = aws_grafana_workspace.example.id
  username     = "example"
  password     = "example"
}

# Crie um dashboard do Amazon Managed Service for Grafana
resource "aws_grafana_dashboard" "example" {
  workspace_id = aws_grafana_workspace.example.id
  dashboard_json = <<DASHBOARD
{
  "id": null,
  "uid": null,
  "title": "Example Dashboard",
  "tags": [],
  "panels": []
}
DASHBOARD
}
}
    
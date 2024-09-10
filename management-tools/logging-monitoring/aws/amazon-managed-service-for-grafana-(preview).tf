
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a Managed Service for Grafana (Preview) workspace
resource "aws_managed_grafana_workspace" "main" {
  name = "my-grafana-workspace" # Name of your Managed Service for Grafana (Preview) workspace
  # Optional parameters:
  # authentication_mode = "AWS_IAM"
  # auth_provider_arn = "arn:aws:iam::123456789012:role/my-grafana-auth-role"
  #  Tags
  tags = {
    Name = "My Grafana Workspace"
  }
}

# Create a Managed Service for Grafana (Preview) dashboard
resource "aws_managed_grafana_dashboard" "main" {
  workspace_id = aws_managed_grafana_workspace.main.id # ID of the workspace
  name         = "My Dashboard"                        # Name of the dashboard
  # Optional parameters:
  # description      = "My Grafana Dashboard"
  # tags = {
  #   Name = "My Grafana Dashboard"
  # }
  #  dashboard_json  = "{ ... }"  #  JSON structure of the dashboard
}

# Create a Managed Service for Grafana (Preview) data source
resource "aws_managed_grafana_datasource" "main" {
  workspace_id = aws_managed_grafana_workspace.main.id # ID of the workspace
  name         = "My Data Source"                      # Name of the data source
  # Optional parameters:
  # type          = "cloudwatch"
  # access         = "proxy"
  #  region        = "us-east-1"
  #  http_headers  = {
  #    "Authorization" = "Bearer my-token"
  #  }
}

# Create a Managed Service for Grafana (Preview) user
resource "aws_managed_grafana_user" "main" {
  workspace_id = aws_managed_grafana_workspace.main.id # ID of the workspace
  username     = "my-grafana-user"                     # Username of the user
  # Optional parameters:
  # email          = "my-user@example.com"
  #  password      = "my-password"
  #  role          = "Admin"
  #  tags = {
  #    Name = "My Grafana User"
  #  }
  #  auth_provider_arn = "arn:aws:iam::123456789012:role/my-grafana-auth-role"
}

# Create a Managed Service for Grafana (Preview) organization
resource "aws_managed_grafana_organization" "main" {
  workspace_id = aws_managed_grafana_workspace.main.id # ID of the workspace
  name         = "My Organization"                     # Name of the organization
  # Optional parameters:
  #  description  = "My Grafana Organization"
  #  tags = {
  #    Name = "My Grafana Organization"
  #  }
}

  
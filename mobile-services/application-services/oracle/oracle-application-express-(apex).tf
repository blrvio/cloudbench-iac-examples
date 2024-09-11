
    # Configure the Oracle provider
provider "oracle" {
  # Configure the connection details to your Oracle database
  connection_string = "username/password@host:port/service_name"
}

# Create an APEX workspace
resource "oracle_apex_workspace" "main" {
  name = "my_apex_workspace"
  # Other optional configurations can be added here
}

# Create an APEX application
resource "oracle_apex_application" "main" {
  workspace_id = oracle_apex_workspace.main.id
  name         = "my_apex_app"
  # Other optional configurations can be added here
}

# Create an APEX user
resource "oracle_apex_user" "main" {
  workspace_id = oracle_apex_workspace.main.id
  username      = "my_apex_user"
  # Set a password for the user
  password      = "my_password"
  # Define the user's role within the workspace
  role          = "developer"
}

# Create an APEX component
resource "oracle_apex_component" "main" {
  workspace_id = oracle_apex_workspace.main.id
  application_id = oracle_apex_application.main.id
  name         = "my_apex_component"
  # Define the component's type
  type         = "page"
  # Other optional configurations can be added here
}
  
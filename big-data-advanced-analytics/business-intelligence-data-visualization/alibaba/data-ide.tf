
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
  # You can configure the credentials here if needed
}

# Create a Data IDE workspace
resource "alicloud_data_ide_workspace" "main" {
  name = "my-data-ide-workspace" # Replace with your desired workspace name
  # You can configure the workspace settings here, such as the edition and the storage size
  # For example:
  # edition = "standard"
  # storage_size = 100
}

# Create a Data IDE user
resource "alicloud_data_ide_user" "main" {
  # You can configure the user's information here, such as the username, password, and email
  # For example:
  # username = "my-data-ide-user"
  # password = "password123"
  # email = "my-user@example.com"
}

# Create a Data IDE project
resource "alicloud_data_ide_project" "main" {
  workspace_id = alicloud_data_ide_workspace.main.id # ID of the workspace
  name = "my-data-ide-project" # Replace with your desired project name
  # You can configure the project settings here, such as the type and the description
  # For example:
  # type = "notebook"
  # description = "My Data IDE Project"
}

# Create a Data IDE notebook
resource "alicloud_data_ide_notebook" "main" {
  project_id = alicloud_data_ide_project.main.id # ID of the project
  name = "my-data-ide-notebook" # Replace with your desired notebook name
  # You can configure the notebook settings here, such as the language and the environment
  # For example:
  # language = "python"
  # environment = "spark"
}

  
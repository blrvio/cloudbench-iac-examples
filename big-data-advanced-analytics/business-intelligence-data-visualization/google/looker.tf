
      # Configure o provedor Looker
provider "looker" {
  api_token = "looker_api_token"
  host      = "looker.host"
  version   = "4.0"
}

# Crie um grupo de usuários
resource "looker_user_group" "my_group" {
  name    = "My Group"
  user_ids = ["user_1", "user_2"] # Substitua por IDs dos usuários
}

# Crie um projeto
resource "looker_project" "my_project" {
  name     = "My Project"
  space_id = "space_id" # Substitua pelo ID do espaço
}

# Crie um dashboard
resource "looker_dashboard" "my_dashboard" {
  title   = "My Dashboard"
  project_id = looker_project.my_project.id
  dashboard_elements = [ # Defina elementos do dashboard
    {
      type = "looker_tile"
      title = "My Tile"
      look = "look_id"
    }
  ]
}

# Crie um alerta
resource "looker_alert" "my_alert" {
  name  = "My Alert"
  title = "My Alert Title"
  look  = "look_id" # Substitua pelo ID do Look
  project_id = looker_project.my_project.id
}

# Crie um agendamento de dados
resource "looker_scheduled_plan" "my_plan" {
  name      = "My Plan"
  project_id = looker_project.my_project.id
  schedule  = "every 24 hours"
  look = "look_id" # Substitua pelo ID do Look
}

    
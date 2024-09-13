
      # Configure o provedor do Google Cloud
provider "google" {
  project = "project-id"
}

# Crie um repositório de código-fonte
resource "google_sourcerepo_repository" "main" {
  name     = "my-repo"
  project  = "project-id"
}

# Crie um usuário com permissão para acessar o repositório
resource "google_service_account" "repo_user" {
  account_id   = "repo-user"
  display_name = "Cloud Source Repositories User"
}

resource "google_project_iam_member" "repo_user_access" {
  project  = "project-id"
  role     = "roles/source.repo.reader"
  member   = "serviceAccount:${google_service_account.repo_user.email}"
}

# Crie um webhook para integrar o repositório a um sistema externo
resource "google_sourcerepo_repo_webhook" "my_webhook" {
  name     = "my-webhook"
  repo_id  = google_sourcerepo_repository.main.id
  project  = "project-id"
  url      = "https://example.com/webhook"
  event    = "PULL_REQUEST"
  config   = <<EOF
{
  "secret": "my-secret"
}
EOF
}

# Crie um branch dentro do repositório
resource "google_sourcerepo_branch" "main_branch" {
  name     = "main"
  repo_id  = google_sourcerepo_repository.main.id
  project  = "project-id"
}

    
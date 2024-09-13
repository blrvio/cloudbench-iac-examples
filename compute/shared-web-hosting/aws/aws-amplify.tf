
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um aplicativo Amplify
resource "aws_amplify_app" "my_app" {
  name = "my-app"
}

# Crie um branch do aplicativo Amplify
resource "aws_amplify_branch" "main_branch" {
  app_id = aws_amplify_app.my_app.id
  name    = "main"
  stage   = "PRODUCTION"

  basic_auth_config {
    enable_basic_auth = false
  }

  build_spec {
    version   = "1.0"
    frontend {
      framework = "NONE"
    }
  }

  environment_variables {
    # Defina as variáveis de ambiente do aplicativo
  }
}

# Crie um domínio personalizado para o aplicativo
resource "aws_amplify_domain" "my_domain" {
  app_id = aws_amplify_app.my_app.id
  domain  = "my-domain.com"
  subdomain = "www"

  # Defina a configuração do certificado SSL
}

# Configure o acesso ao backend
resource "aws_amplify_backend_environment" "my_backend" {
  app_id     = aws_amplify_app.my_app.id
  environment = "development"

  # Defina as configurações de segurança do backend
  # ...
}

# Crie um recurso de backend
resource "aws_amplify_backend_api" "my_api" {
  app_id = aws_amplify_app.my_app.id
  api_name = "my-api"

  # Defina a configuração do API
  # ...
}

# Configure o acesso ao backend para o aplicativo
resource "aws_amplify_backend_auth" "my_auth" {
  app_id = aws_amplify_app.my_app.id
  auth_type = "USER_POOLS"

  # Defina as configurações de autenticação do backend
  # ...
}
    
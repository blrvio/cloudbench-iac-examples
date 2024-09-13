
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um pool de usuários Cognito
resource "aws_cognito_user_pool" "main" {
  name = "my-user-pool"
}

# Crie um grupo de usuários Cognito
resource "aws_cognito_user_pool_group" "admin" {
  user_pool_id = aws_cognito_user_pool.main.id
  name          = "admin"
}

# Crie uma identidade federada Cognito
resource "aws_cognito_identity_pool" "main" {
  identity_pool_name = "my-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    provider_name = "cognito-idp.us-east-1.amazonaws.com/us-east-1_xxxxxxxx"
    client_id     = "xxxxxxxx"
  }
}

# Crie um aplicativo Cognito
resource "aws_cognito_user_pool_client" "web" {
  user_pool_id = aws_cognito_user_pool.main.id
  client_name  = "web-client"
  generate_secret = false

  allowed_o_auth_flows = ["code"]
  allowed_o_auth_scopes = ["phone", "email", "openid", "profile"]
  callback_urls      = ["https://www.example.com"] # Substitua pela URL do seu aplicativo
  logout_urls         = ["https://www.example.com"] # Substitua pela URL do seu aplicativo
}
    
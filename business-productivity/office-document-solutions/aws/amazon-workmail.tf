
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um organização WorkMail
resource "aws_workmail_organization" "main" {
  name = "my-workmail-org"
  # ... outros parâmetros
}

# Crie um grupo de usuários WorkMail
resource "aws_workmail_user" "user1" {
  organization_id = aws_workmail_organization.main.id
  name = "john.doe"
  email = "john.doe@example.com"
  # ... outros parâmetros
}

# Crie um grupo de usuários WorkMail
resource "aws_workmail_group" "group1" {
  organization_id = aws_workmail_organization.main.id
  name = "team-one"
  # ... outros parâmetros
}
    
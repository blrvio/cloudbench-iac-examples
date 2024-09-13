
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Outpost
resource "aws_outposts_outpost" "example" {
  name    = "example-outpost"
  site_id = "site-xxxxxxxx" # Substitua pelo ID do site

  # Define a configuração do Outpost
  # Opções como tipo de hardware, capacidade de computação, etc.
  configuration {
    # ...
  }
}

# Crie um local do Outpost
resource "aws_outposts_site" "example" {
  name  = "example-site"
  region = "us-east-1" # Substitua pela sua região desejada

  # Define a configuração do local
  # Opções como endereço, contato de contato, etc.
  configuration {
    # ...
  }
}
    
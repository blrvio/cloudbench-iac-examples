
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um repositório ECR
resource "aws_ecr_repository" "my_repo" {
  name = "my_repo"
}

# Crie uma imagem Docker localmente
# docker build -t my_image:latest .

# Faça push da imagem para o repositório ECR
# docker tag my_image:latest <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/my_repo:latest
# docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/my_repo:latest
    
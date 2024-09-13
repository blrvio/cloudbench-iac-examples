
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um conjunto de dados de usuários
resource "aws_personalize_dataset" "users" {
  name   = "users"
  dataset_type = "USERS"
  schema_arn = "arn:aws:personalize:us-east-1:123456789012:schema/schema-123456789012-123456789012"
}

# Crie um conjunto de dados de itens
resource "aws_personalize_dataset" "items" {
  name   = "items"
  dataset_type = "ITEMS"
  schema_arn = "arn:aws:personalize:us-east-1:123456789012:schema/schema-123456789012-123456789012"
}

# Crie um conjunto de dados de interações
resource "aws_personalize_dataset" "interactions" {
  name   = "interactions"
  dataset_type = "INTERACTIONS"
  schema_arn = "arn:aws:personalize:us-east-1:123456789012:schema/schema-123456789012-123456789012"
}

# Crie um modelo de recomendação
resource "aws_personalize_solution" "recommendations" {
  name     = "recommendations"
  recipe_arn = "arn:aws:personalize:us-east-1:123456789012:recipe/recipe-123456789012-123456789012"
  dataset_group_arn = aws_personalize_dataset_group.dataset_group.arn
}

# Crie um grupo de conjuntos de dados
resource "aws_personalize_dataset_group" "dataset_group" {
  name = "dataset_group"
}

# Importe os dados para os conjuntos de dados
resource "aws_personalize_dataset_import" "users_import" {
  dataset_arn = aws_personalize_dataset.users.arn
  data_source  = "s3://my-bucket/users.csv"
}

resource "aws_personalize_dataset_import" "items_import" {
  dataset_arn = aws_personalize_dataset.items.arn
  data_source  = "s3://my-bucket/items.csv"
}

resource "aws_personalize_dataset_import" "interactions_import" {
  dataset_arn = aws_personalize_dataset.interactions.arn
  data_source  = "s3://my-bucket/interactions.csv"
}

# Treine o modelo de recomendação
resource "aws_personalize_solution" "recommendations_training" {
  name     = "recommendations"
  recipe_arn = "arn:aws:personalize:us-east-1:123456789012:recipe/recipe-123456789012-123456789012"
  dataset_group_arn = aws_personalize_dataset_group.dataset_group.arn
}

    
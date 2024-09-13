
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um grupo Greengrass
resource "aws_greengrass_group" "example" {
  name = "example"
}

# Crie um núcleo Greengrass
resource "aws_greengrass_core" "example" {
  group_id  = aws_greengrass_group.example.id
  thing_name = "example"
}

# Crie uma função Lambda para o Greengrass
resource "aws_lambda_function" "example" {
  function_name = "example"
  runtime       = "nodejs14.x"
  handler      = "index.handler"
  memory_size   = 128
  timeout      = 30
  code = {
    zip_file = "# Supress código da função Lambda"
  }
}

# Crie uma função Lambda para o Greengrass
resource "aws_greengrass_function_definition" "example" {
  name = "example"
  function {
    id = aws_lambda_function.example.arn
    function_configuration {
      memory_size = 128
      timeout     = 30
    }
  }
}

# Crie uma definição de recurso para o Greengrass
resource "aws_greengrass_resource_definition" "example" {
  name = "example"
  resource {
    id = aws_greengrass_function_definition.example.id
  }
}

# Crie uma definição de subscrição para o Greengrass
resource "aws_greengrass_subscription_definition" "example" {
  name = "example"
  subscription {
    id               = aws_greengrass_resource_definition.example.id
    source            = "aws/greengrass/example"
    target           = "aws/greengrass/example"
    subject           = "# Supress assunto da subscrição"
    qos              = "at_least_once"
    retry_interval_seconds = 60
    timeout_in_seconds   = 60
    max_queue_size     = 10
  }
}

# Crie uma definição de grupo Greengrass
resource "aws_greengrass_group_version" "example" {
  group_id = aws_greengrass_group.example.id
  definition {
    function_definitions = [aws_greengrass_function_definition.example.id]
    resource_definitions = [aws_greengrass_resource_definition.example.id]
    subscription_definitions = [aws_greengrass_subscription_definition.example.id]
  }
}

# Crie uma versão do grupo Greengrass
resource "aws_greengrass_group_version" "example" {
  group_id = aws_greengrass_group.example.id
  definition {
    function_definitions = [aws_greengrass_function_definition.example.id]
    resource_definitions = [aws_greengrass_resource_definition.example.id]
    subscription_definitions = [aws_greengrass_subscription_definition.example.id]
  }
}
    
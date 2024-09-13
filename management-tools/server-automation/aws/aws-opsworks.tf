
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um stack OpsWorks
resource "aws_opsworks_stack" "main" {
  name         = "main-stack"
  service_role_arn = "arn:aws:iam::xxxxxxxx:role/opsworks_service_role"
  # Substitua pelo ARN do seu papel de serviço
  default_instance_profile_arn = "arn:aws:iam::xxxxxxxx:role/opsworks_instance_profile"
  # Substitua pelo ARN do seu perfil de instância padrão
  default_os = "Amazon Linux 2"
  # Substitua pelo SO padrão desejado
  default_ssh_key_name = "key_name"
  # Substitua pelo nome da sua chave SSH
  default_root_device_type = "ebs"
  # Substitua pelo tipo de dispositivo raiz padrão
  default_availability_zone = "us-east-1a"
  # Substitua pela zona de disponibilidade padrão desejada
  custom_cookbooks_source {
    type     = "git"
    url      = "git@github.com:your-organization/cookbooks.git"
    # Substitua pela URL do seu repositório de cookbooks
    revision = "master"
    # Substitua pelo branch desejado
  }
  custom_json = <<JSON
    {
      "MyCustomOption": "MyCustomValue"
    }
  JSON
}

# Crie um layer OpsWorks
resource "aws_opsworks_layer" "custom_layer" {
  stack_id     = aws_opsworks_stack.main.id
  name         = "Custom Layer"
  shortname    = "custom"
  type         = "custom"
  # Substitua pelo tipo de layer desejado
  auto_assign_elastic_ips = false
  # Define se IPs elásticos devem ser atribuídos automaticamente
  auto_assign_public_ips = false
  # Define se IPs públicos devem ser atribuídos automaticamente
  use_ebs_optimized_instances = false
  # Define se as instâncias devem ser otimizadas para EBS
  custom_recipes {
    setup  = ["recipe1.rb", "recipe2.rb"]
    # Lista de receitas para o setup
    configure = ["configure1.rb", "configure2.rb"]
    # Lista de receitas para configuração
    deploy = ["deploy1.rb", "deploy2.rb"]
    # Lista de receitas para deploy
    undeploy = ["undeploy1.rb", "undeploy2.rb"]
    # Lista de receitas para undeploy
  }
  custom_json = <<JSON
    {
      "MyCustomOption": "MyCustomValue"
    }
  JSON
}

# Crie uma instância OpsWorks
resource "aws_opsworks_instance" "app_server" {
  stack_id     = aws_opsworks_stack.main.id
  layer_ids    = [aws_opsworks_layer.custom_layer.id]
  instance_type = "t2.micro"
  # Substitua pelo tipo de instância desejado
  # ... other options ...
}

# Crie um aplicativo OpsWorks
resource "aws_opsworks_app" "app" {
  stack_id = aws_opsworks_stack.main.id
  name      = "My App"
  type      = "rails"
  # Substitua pelo tipo de aplicativo desejado
  shortname = "myapp"
  # ... other options ...
  app_source {
    type     = "git"
    url      = "git@github.com:your-organization/myapp.git"
    # Substitua pela URL do seu repositório de código
    revision = "master"
    # Substitua pelo branch desejado
  }
}
    
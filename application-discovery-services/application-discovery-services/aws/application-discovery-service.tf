
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um agente de descoberta de aplicativos
resource "aws_applicationdiscovery_agent" "agent" {
  name = "agent"
  tags = {
    Name = "Application Discovery Agent"
  }
}

# Crie um configuração de descoberta de aplicativos
resource "aws_applicationdiscovery_configuration" "config" {
  name = "config"
  tags = {
    Name = "Application Discovery Configuration"
  }
}

# Configure o agente de descoberta de aplicativos para usar a configuração de descoberta
resource "aws_applicationdiscovery_agent_configuration" "agent_config" {
  agent_id = aws_applicationdiscovery_agent.agent.id
  configuration_id = aws_applicationdiscovery_configuration.config.id
}

# Crie um perfil de descoberta
resource "aws_applicationdiscovery_profile" "profile" {
  name = "profile"
  tags = {
    Name = "Application Discovery Profile"
  }
}
    
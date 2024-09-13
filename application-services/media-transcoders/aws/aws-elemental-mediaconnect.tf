
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um fluxo de mídia
resource "aws_mediaconnect_flow" "example" {
  name = "example-flow"
  source {
    # ...
  }
  outputs {
    # ...
  }
}

# Crie uma conexão de fluxo
resource "aws_mediaconnect_flow_vpc_interface" "example" {
  flow_arn = aws_mediaconnect_flow.example.arn
  # ...
}

# Crie uma conexão de fluxo
resource "aws_mediaconnect_flow_output" "example" {
  flow_arn = aws_mediaconnect_flow.example.arn
  # ...
}
    
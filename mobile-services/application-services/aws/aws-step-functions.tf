
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma máquina de estado do Step Functions
resource "aws_sfn_state_machine" "my_state_machine" {
  name     = "my-state-machine"
  definition = <<EOF
  {
    "Comment": "Exemplo de máquina de estado do Step Functions",
    "StartAt": "HelloWorld",
    "States": {
      "HelloWorld": {
        "Type": "Task",
        "Resource": "arn:aws:lambda:us-east-1:123456789012:function:HelloWorld",
        "End": true
      }
    }
  }
EOF
}

    
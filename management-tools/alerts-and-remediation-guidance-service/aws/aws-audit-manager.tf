
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma avaliação de segurança
resource "aws_auditmanager_assessment" "example" {
  name            = "MyAssessment"
  description     = "Example Audit Manager Assessment"
  framework       = "NIST CSF"
  assessment_scope = "account"

  # Adicione controles à avaliação
  controls {
    control_id = "NIST-CSF-AC-1"
    selected   = true
  }
}

# Crie um conjunto de controle
resource "aws_auditmanager_control_set" "example" {
  name            = "MyControlSet"
  description     = "Example Audit Manager Control Set"
  framework       = "NIST CSF"
  control_set_type = "standard"
  controls {
    control_id = "NIST-CSF-AC-1"
  }
}

# Adicione um controle personalizado
resource "aws_auditmanager_control" "example" {
  name            = "MyCustomControl"
  description     = "Example Audit Manager Custom Control"
  control_type     = "custom"
  control_source   = "aws"
  assessment_id   = aws_auditmanager_assessment.example.id
  control_set_id  = aws_auditmanager_control_set.example.id
  control_mapping {
    source_id  = "NIST-CSF-AC-1"
    source_type = "framework"
  }
}

    
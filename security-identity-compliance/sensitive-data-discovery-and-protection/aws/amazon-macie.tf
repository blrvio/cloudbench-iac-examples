
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um perfil de segurança
resource "aws_macie_member_account" "example" {
  account_id = "123456789012"
}

# Ative o Amazon Macie
resource "aws_macie_session" "example" {
  status = "ENABLED"
}

# Crie um detector de ameaças
resource "aws_macie_findings_filter" "example" {
  name = "example-filter"
  description = "Exemplo de filtro de descobertas"
  finding_criteria {
    criterion {
      field     = "s3Bucket"
      operator  = "EQUALS"
      value     = "my-bucket"
    }
  }
}

# Crie um trabalho de classificação
resource "aws_macie_classification_job" "example" {
  job_name = "example-job"
  s3_resources {
    bucket_name = "my-bucket"
  }
  job_type = "ONE_TIME"
}

    
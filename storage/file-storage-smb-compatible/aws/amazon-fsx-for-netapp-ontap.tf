
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um sistema de arquivos FSx para NetApp ONTAP
resource "aws_fsx_ontap_volume" "main" {
  availability_zone = "us-east-1a"
  backup_policy_id = "fsx-backup-policy-xxxxxxxx"
  kms_key_id      = "arn:aws:kms:us-east-1:xxxxxxxxxxxxx:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  security_style   = "strict"
  subnet_ids = ["subnet-xxxxxxxx"] # Substitua pelo ID da sua subnet
  throughput_capacity = 128
  volume_type = "ONTAP_STANDARD"
}

    
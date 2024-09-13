
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um agente DataSync
resource "aws_datasync_agent" "example" {
  activation_key = "xxxxxxxxxxxxxxxxxxxxxxxx"
  name           = "example-agent"
  tags = {
    Name = "example-agent"
  }
}

# Crie uma localização de origem S3
resource "aws_datasync_location_s3" "source" {
  bucket_name = "example-bucket"
  subdirectory  = "path/to/source/directory"
  
  # Define a configuração para a localização de origem
  # Ex: 
  # configuration = <<EOF
  # {
  #   "Excludes": ["*ignore.txt"],
  #   "Includes": ["*file.txt"]
  # }
  # EOF
  
  # Define as credenciais para acessar o bucket S3
  # Ex: 
  # credentials = <<EOF
  # {
  #   "AccessKey": "AKIAXXXXXXXXXXXX",
  #   "SecretKey": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  #   "RoleArn": "arn:aws:iam::123456789012:role/my-role"
  # }
  # EOF
}

# Crie uma localização de destino EFS
resource "aws_datasync_location_efs" "destination" {
  efs_file_system_arn = "arn:aws:elasticfilesystem:us-east-1:123456789012:file-system/fs-xxxxxxxx"
  subdirectory  = "path/to/destination/directory"
  
  # Define as credenciais para acessar o sistema de arquivos EFS
  # Ex: 
  # credentials = <<EOF
  # {
  #   "AccessKey": "AKIAXXXXXXXXXXXX",
  #   "SecretKey": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  #   "RoleArn": "arn:aws:iam::123456789012:role/my-role"
  # }
  # EOF
}

# Crie uma tarefa de transferência de dados
resource "aws_datasync_task" "example" {
  name = "example-task"
  
  # Configure a tarefa de transferência
  # source_location_arn = aws_datasync_location_s3.source.arn
  # destination_location_arn = aws_datasync_location_efs.destination.arn
  # schedule = "schedule"
  #  Ex: schedule = "cron(0 0 * * ? *) # Diariamente às 00:00"
  #  Ex: schedule = "cron(0 */12 * * ? *) # A cada 12 horas"
  #  Ex: schedule = "cron(0 0/5 * * ? *) # A cada 5 minutos"
  # options = "options"
  #  Ex: options = "{"OverwriteMode":"ALWAYS","PreserveDeletedFiles":"true","PreserveMetadata":"true"}  "
  #  Ex: options = "{"OverwriteMode":"PRESERVE","PreserveDeletedFiles":"false","PreserveMetadata":"false"}  "

  # Adicione tags à tarefa
  tags = {
    Name = "example-task"
  }
}

    
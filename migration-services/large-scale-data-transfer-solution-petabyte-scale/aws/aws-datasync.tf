
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DataSync Location for your On-premises Storage
resource "aws_datasync_location_smb" "onprem" {
  name         = "onprem-location"
  subdirectory = "/my/data/directory" # Specify the subdirectory on your SMB share
  # Provide your SMB server credentials for access
  # Refer to the AWS documentation for supported authentication methods
  # such as username/password, domain, or Kerberos
  username = "my-smb-user"
  password = "my-smb-password"
  # Replace with your SMB server hostname or IP address
  hostname = "my-smb-server.example.com"
  # Optional: Enable Kerberos authentication (if applicable)
  kerberos_config {
    # Replace with your Kerberos realm
    realm = "EXAMPLE.COM"
    # Replace with your Kerberos KDC hostname
    kdc_hostname = "kdc.example.com"
    # Optional: Set the Kerberos service principal
    service_principal = "cifs/my-smb-server.example.com@EXAMPLE.COM"
    # Optional: Set the Kerberos keytab file path
    keytab_file = "path/to/keytab"
  }
}

# Create a DataSync Location for your AWS S3 bucket
resource "aws_datasync_location_s3" "s3" {
  name = "s3-location"
  # Replace with your S3 bucket name
  bucket_name = "my-s3-bucket"
  # Optional: Specify a specific S3 path for your data
  # The default is the root of the bucket
  s3_path = "my/s3/path"
}

# Create a DataSync Task
resource "aws_datasync_task" "main" {
  name = "my-data-sync-task"
  # Specify the source location
  source_location_arn = aws_datasync_location_smb.onprem.arn
  # Specify the destination location
  destination_location_arn = aws_datasync_location_s3.s3.arn
  # Schedule the task execution
  schedule {
    # Configure the task execution frequency (e.g., hourly, daily, weekly)
    # Refer to the AWS documentation for supported scheduling options
    # For example, hourly executions
    # schedule_expression = "cron(0 * * * ? *)"
  }

  # Optional: Configure task options
  options {
    # Optional: Set the number of concurrent threads used during the task
    # execution (default is 10)
    # num_tasks = 10
    # Optional: Enable the overwrite option for existing files at the
    # destination (default is false)
    # overwrite_mode = true
  }
}

  
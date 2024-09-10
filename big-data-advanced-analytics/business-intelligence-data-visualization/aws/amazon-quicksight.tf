
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a QuickSight Account
resource "aws_quicksight_account" "main" {
  name = "my-quicksight-account"
  # Optional
  email = "user@example.com"
  # Optional
  namespace = "default"
}

# Create a QuickSight User
resource "aws_quicksight_user" "main" {
  email = "user@example.com"
  # Optional
  identity_type = "IAM"
  # Optional
  iam_arn = "arn:aws:iam::123456789012:user/user-name"
  # Optional
  role = "ADMIN"
  # Optional
  user_name = "user-name"
  # Optional
  # Specify the QuickSight account ID
  aws_account_id = aws_quicksight_account.main.aws_account_id
}

# Create a QuickSight Dataset
resource "aws_quicksight_dataset" "main" {
  name = "my-quicksight-dataset"
  # Specify the QuickSight account ID
  aws_account_id = aws_quicksight_account.main.aws_account_id
  # Choose the data source type
  data_source_arn = aws_quicksight_data_source.main.arn
  # Optional
  # Specify the data source format
  # data_source_format = "PARQUET"
  # Optional
  # Specify the data source parameters
  # data_source_parameters = {
  #   # Specify the data source parameters based on the data source type
  # }
}

# Create a QuickSight Data Source
resource "aws_quicksight_data_source" "main" {
  name = "my-quicksight-data-source"
  # Specify the QuickSight account ID
  aws_account_id = aws_quicksight_account.main.aws_account_id
  # Choose the data source type
  type = "S3"
  # Optional
  # Specify the data source credentials
  # credentials {
  #   # Specify the credentials based on the data source type
  # }
  # Optional
  # Specify the data source parameters
  # data_source_parameters = {
  #   # Specify the data source parameters based on the data source type
  # }
}

# Create a QuickSight Analysis
resource "aws_quicksight_analysis" "main" {
  name = "my-quicksight-analysis"
  # Specify the QuickSight account ID
  aws_account_id = aws_quicksight_account.main.aws_account_id
  # Specify the dataset ARN
  dataset_arns = [aws_quicksight_dataset.main.arn]
  # Optional
  # Specify the analysis parameters
  # parameters = {
  #   # Specify the analysis parameters
  # }
}

# Create a QuickSight Dashboard
resource "aws_quicksight_dashboard" "main" {
  name = "my-quicksight-dashboard"
  # Specify the QuickSight account ID
  aws_account_id = aws_quicksight_account.main.aws_account_id
  # Specify the analysis ARN
  analysis_arns = [aws_quicksight_analysis.main.arn]
  # Optional
  # Specify the dashboard parameters
  # parameters = {
  #   # Specify the dashboard parameters
  # }
}
  

    # Configure AWS CLI credentials
# You can use environment variables, a configuration file, or IAM roles

# Example using environment variables:
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY
export AWS_REGION=us-east-1

# Or using a configuration file (~/.aws/credentials):
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
region = us-east-1

# Example using an IAM role:
# (No configuration needed, your role will be automatically assumed)

# Install AWS CLI
# On Linux/macOS:
# sudo apt install awscli # Debian/Ubuntu
# brew install awscli # Homebrew
# On Windows:
# Download and install from: https://aws.amazon.com/cli/

# Verify installation
aws --version

# List your EC2 instances
aws ec2 describe-instances

# Create a new S3 bucket
aws s3 mb s3://my-new-bucket

# Upload a file to S3
aws s3 cp my-file.txt s3://my-new-bucket/my-file.txt

# Explore AWS CLI commands
aws help

  
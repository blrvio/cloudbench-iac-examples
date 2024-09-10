
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud API key
  api_key = "YOUR_API_KEY"
}

# Create a Cloud Object Storage bucket
resource "ibm_cos_bucket" "main" {
  name = "my-archive-bucket"
  # Set the storage class to "archive"
  storage_class = "archive"
}

# Create a file to upload
resource "local_file" "my_file" {
  content = "This is some sample data for archive storage."
  filename = "my_file.txt"
}

# Upload the file to the Cloud Object Storage bucket
resource "ibm_cos_object" "my_file" {
  bucket = ibm_cos_bucket.main.name
  key = "my_file.txt"
  # Set the storage class to "archive"
  storage_class = "archive"
  source = local_file.my_file.filename
}
  
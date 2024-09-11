
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaay6s2b7q5l76g5b4x3v7b6c5d4c6i3j4s773v5w35a6q"
  user_ocid   = "ocid1.user.oc1..aaaaaaaay6s2b7q5l76g5b4x3v7b6c5d4c6i3j4s773v5w35a6q"
  fingerprint = ""
}

# Create a Data Flow Application
resource "oci_dataflow_application" "main" {
  name      = "my-dataflow-app"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaay6s2b7q5l76g5b4x3v7b6c5d4c6i3j4s773v5w35a6q"
  # Define a simple data flow application
  definition = <<EOF
  {
    "version": "0.1",
    "steps": [
      {
        "name": "my-source",
        "type": "File",
        "properties": {
          "location": "s3://my-bucket/my-file.csv"
        }
      },
      {
        "name": "my-transform",
        "type": "Map",
        "properties": {
          "script": "// Transform logic here"
        }
      },
      {
        "name": "my-sink",
        "type": "File",
        "properties": {
          "location": "s3://my-bucket/transformed-file.csv"
        }
      }
    ]
  }
  EOF
}

# Create a Data Flow Job
resource "oci_dataflow_job" "main" {
  application_id = oci_dataflow_application.main.id
  name            = "my-dataflow-job"
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaay6s2b7q5l76g5b4x3v7b6c5d4c6i3j4s773v5w35a6q"
}

  
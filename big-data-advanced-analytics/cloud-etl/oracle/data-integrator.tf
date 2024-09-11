
    # Configure the Oracle Cloud Provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your desired region
  tenancy_id = "ocid1.tenancy.oc1..."
  # Replace with your tenancy ID
  user_ocid  = "ocid1.user.oc1..."
  # Replace with your user OCID
  fingerprint = "23:45:67:89:AB:CD:EF:01:23:45:67:89:AB:CD:EF:01"
  # Replace with your fingerprint
  private_key_path = "./path/to/your/private_key"
  # Replace with the path to your private key
}

# Create a Data Integration Instance
resource "oci_data_integration_instance" "main" {
  display_name = "my-data-integration-instance"
  # Replace with your desired instance name
  shape = "DATA_INTEGRATION_INSTANCE_SHAPE_1"
  # Replace with your desired instance shape
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  # Other optional attributes can be set here
}

# Create a Data Integration Pipeline
resource "oci_data_integration_pipeline" "main" {
  display_name = "my-data-integration-pipeline"
  # Replace with your desired pipeline name
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  # Other optional attributes can be set here
  instance_id = oci_data_integration_instance.main.id
  # Reference the instance created above
}

# Create a Data Integration Connection
resource "oci_data_integration_connection" "main" {
  display_name = "my-data-integration-connection"
  # Replace with your desired connection name
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  # Other optional attributes can be set here
  instance_id = oci_data_integration_instance.main.id
  # Reference the instance created above
}

# Create a Data Integration Task
resource "oci_data_integration_task" "main" {
  display_name = "my-data-integration-task"
  # Replace with your desired task name
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  # Other optional attributes can be set here
  instance_id = oci_data_integration_instance.main.id
  # Reference the instance created above
  pipeline_id = oci_data_integration_pipeline.main.id
  # Reference the pipeline created above
}

# Create a Data Integration Schedule
resource "oci_data_integration_schedule" "main" {
  display_name = "my-data-integration-schedule"
  # Replace with your desired schedule name
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your compartment ID
  # Other optional attributes can be set here
  task_id = oci_data_integration_task.main.id
  # Reference the task created above
}

  
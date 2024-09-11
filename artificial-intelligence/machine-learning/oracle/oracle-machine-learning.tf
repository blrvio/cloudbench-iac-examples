
    # Configure the Oracle Cloud provider
provider "oci" {
  # Replace with your Oracle Cloud credentials
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  fingerprint = "..."
  private_key = "..."
}

# Create a Machine Learning Model
resource "oci_data_science_model" "example" {
  compartment_id = "ocid1.compartment.oc1..."
  display_name  = "my-ml-model"
  model_type     = "AUTOML_CLASSIFICATION"
  # Replace with your actual training data details
  training_data_details {
    data_source_type = "OCI_OBJECT_STORAGE"
    object_storage_details {
      namespace = "my-namespace"
      bucket   = "my-bucket"
      prefix    = "my-data/train"
    }
  }
  # Replace with your actual target column
  target_column = "target_column"
  # Configure the model training parameters
  automl_classification_config {
    # Set the evaluation metric
    evaluation_metric = "AUC"
    # Specify the target accuracy
    target_accuracy = 0.95
  }
}

# Deploy the model to an endpoint
resource "oci_data_science_model_deployment" "example" {
  compartment_id  = "ocid1.compartment.oc1..."
  model_id       = oci_data_science_model.example.id
  display_name   = "my-model-endpoint"
  endpoint_type = "REST"
}

  
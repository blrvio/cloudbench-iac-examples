
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaz7k7d76j764"
  user    = "ocid1.user.oc1..aaaaaaaasg3w7g6464"
  key     = "your_api_key"
}

# Create a Stream
resource "oci_streaming_stream" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw54t575563"
  name            = "my-stream"
  # Optional: Set the stream's retention duration in hours
  retention_duration_in_hours = 24
  # Optional: Enable encryption at rest
  encryption_in_transit_config {
    # Define encryption in transit configurations for the stream
  }
  # Optional: Define the stream's partitions
  # partitions { 
  #  partition_key_name = "partition_key"
  # }
}

# Create a Stream Consumer Group
resource "oci_streaming_consumer_group" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw54t575563"
  stream_id     = oci_streaming_stream.main.id
  name            = "my-consumer-group"
}

# Create a Stream Producer
resource "oci_streaming_producer" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw54t575563"
  stream_id     = oci_streaming_stream.main.id
  name            = "my-producer"
}

  
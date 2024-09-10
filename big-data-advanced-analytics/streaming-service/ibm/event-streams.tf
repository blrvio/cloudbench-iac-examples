
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API key
}

# Create an Event Streams instance
resource "ibm_eventstreams_instance" "main" {
  name     = "my-eventstreams-instance" # Unique name for your Event Streams instance
  plan     = "standard" # Choose a plan (e.g., standard, enterprise)
  region   = "us-south" # Region where the instance will be created
  service  = "event-streams" # Service name
  instance_id = "your_instance_id" # Your Event Streams instance ID
}

# Create a Kafka topic
resource "ibm_eventstreams_kafka_topic" "main" {
  instance_id = ibm_eventstreams_instance.main.id # ID of the Event Streams instance
  name     = "my-topic" # Name of the Kafka topic
  partitions = 3 # Number of partitions for the topic
  replication_factor = 1 # Replication factor for the topic
  # Optionally, define other configuration parameters
}

# Configure the Event Streams instance settings
resource "ibm_eventstreams_instance_config" "main" {
  instance_id = ibm_eventstreams_instance.main.id # ID of the Event Streams instance
  # Define the settings for the instance
  # For example, you can configure the quota for the instance
  # quota {
  #   max_topic_size = 10 # Maximum size of topics in the instance
  #   max_consumer_groups = 5 # Maximum number of consumer groups in the instance
  #   # Other quota settings...
  # }
}

  
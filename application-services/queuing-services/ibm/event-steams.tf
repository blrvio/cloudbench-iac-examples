
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud API key
}

# Create an Event Streams instance
resource "ibm_eventstreams_instance" "main" {
  name     = "my-eventstreams-instance"
  # Replace with your chosen name
  plan     = "lite"
  # Choose the instance plan
  region   = "us-south"
  # Replace with your chosen region
}

# Create a topic in Event Streams
resource "ibm_eventstreams_topic" "main" {
  instance_id = ibm_eventstreams_instance.main.id
  # ID of the Event Streams instance
  name     = "my-eventstreams-topic"
  # Replace with your chosen name
  partition_count = 1
  # Number of partitions for the topic
}

# Create a consumer group
resource "ibm_eventstreams_consumer_group" "main" {
  instance_id = ibm_eventstreams_instance.main.id
  # ID of the Event Streams instance
  topic_name = ibm_eventstreams_topic.main.name
  # Name of the topic
  name     = "my-consumer-group"
  # Replace with your chosen name
}
  
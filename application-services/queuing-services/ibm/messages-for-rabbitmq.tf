
    # Configure the IBM Cloud provider
provider "ibm" {
  region        = "us-south"
  api_key      = "YOUR_IBM_CLOUD_API_KEY"
  account_id   = "YOUR_IBM_CLOUD_ACCOUNT_ID"
  organization = "YOUR_IBM_CLOUD_ORGANIZATION"
}

# Create a Messages for RabbitMQ instance
resource "ibm_rabbitmq_instance" "main" {
  name = "my-rabbitmq-instance"
  plan = "standard-1"
  location = "us-south"
  # Optional settings
  # tags = {
  #   "my-tag" = "my-value"
  # }
  # password = "YOUR_PASSWORD"
}

# Create a RabbitMQ vhost
resource "ibm_rabbitmq_vhost" "main" {
  instance_id = ibm_rabbitmq_instance.main.id
  name = "my-vhost"
  # Optional settings
  # access_control  = "restricted"
}

# Create a RabbitMQ user
resource "ibm_rabbitmq_user" "main" {
  instance_id = ibm_rabbitmq_instance.main.id
  name = "my-user"
  password = "YOUR_PASSWORD"
  # Optional settings
  # tags = {
  #   "my-tag" = "my-value"
  # }
}

# Create a RabbitMQ permission
resource "ibm_rabbitmq_permission" "main" {
  instance_id = ibm_rabbitmq_instance.main.id
  user        = "my-user"
  vhost       = "my-vhost"
  configure = "true"
  write      = "true"
  read       = "true"
}

  
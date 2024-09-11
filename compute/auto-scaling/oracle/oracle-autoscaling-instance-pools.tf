
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaw7g74qrr"
  # Replace with your user OCID
  user_ocid    = "ocid1.user.oc1..aaaaaaaaw7g74qrr"
  # Replace with your region
  region       = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_ocid = "ocid1.compartment.oc1..aaaaaaaaw7g74qrr"
  # Replace with your private key file path
  private_key_file = "~/.oci/oci_api_key.pem"
}

# Create an Autoscaling Instance Pool
resource "oci_core_instance_pool" "main" {
  compartment_id = oci.compartment_ocid
  display_name = "my-instance-pool"
  # Configure the instance pool with a single instance configuration
  instance_config {
    # Replace with the OCID of your desired instance shape
    shape = "VM.Standard.E2.1"
    # Define the number of instances to be launched
    # in this instance configuration
    instance_count = 1
  }
  # Configure the placement configuration for the instance pool
  placement_config {
    # Choose a specific availability domain if required
    # availability_domain = "us-ashburn-1a"
  }
  # Configure the availability domain for the instance pool
  availability_domain = "us-ashburn-1a"
}

# Create a Launch Configuration
resource "oci_core_launch_config" "main" {
  compartment_id = oci.compartment_ocid
  display_name  = "my-launch-config"
  # Set the image to be used for launching instances
  image_id = "ocid1.image.oc1..aaaaaaaaw7g74qrr"
  # Replace with the OCID of your desired subnet
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaw7g74qrr"
  # Configure the instance shape for the launch configuration
  shape = "VM.Standard.E2.1"
}

# Create an Autoscaling Configuration
resource "oci_core_autoscaling_config" "main" {
  compartment_id       = oci.compartment_ocid
  display_name         = "my-autoscaling-config"
  instance_pool_id     = oci_core_instance_pool.main.id
  launch_config_id     = oci_core_launch_config.main.id
  # Set the minimum and maximum number of instances to be launched
  min_instances         = 1
  max_instances         = 3
  # Set the cooldown period for the autoscaling policy
  cooldown_in_seconds = 300
}

# Create an Autoscaling Policy
resource "oci_core_autoscaling_policy" "main" {
  compartment_id       = oci.compartment_ocid
  display_name         = "my-autoscaling-policy"
  autoscaling_config_id = oci_core_autoscaling_config.main.id
  # Define the metrics and thresholds for the autoscaling policy
  # Example: Scale up if CPU utilization is over 80%
  # metrics {
  #   name        = "CpuUtilization"
  #   statistic   = "Average"
  #   threshold   = 80
  #   period_in_seconds = 60
  #   comparison_operator = "GreaterThanThreshold"
  #   evaluation_periods  = 1
  # }
  # Example: Scale down if CPU utilization is below 20%
  # metrics {
  #   name        = "CpuUtilization"
  #   statistic   = "Average"
  #   threshold   = 20
  #   period_in_seconds = 60
  #   comparison_operator = "LessThanThreshold"
  #   evaluation_periods  = 1
  # }
}

# Start the Autoscaling Policy
resource "oci_core_autoscaling_policy_deployment" "main" {
  autoscaling_policy_id = oci_core_autoscaling_policy.main.id
}

  
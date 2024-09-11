
    # Configure the Oracle Cloud provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
}

# Create an Oracle Cloud IoT service
resource "oci_iot_service" "example" {
  name     = "iot-service-example"
  compartment_id = "ocid1.compartment.oc1..."

  # Optional attributes
  description  = "Example IoT service"
  display_name = "Example IoT service"
  tags         = {
    "Name" = "Example IoT service"
  }
}

# Create an Oracle Cloud IoT device
resource "oci_iot_device" "example" {
  device_type_id = oci_iot_device_type.example.id
  service_id      = oci_iot_service.example.id
  name            = "device-example"
  compartment_id  = "ocid1.compartment.oc1..."

  # Optional attributes
  description  = "Example IoT device"
  display_name = "Example IoT device"
  tags         = {
    "Name" = "Example IoT device"
  }
}

# Create an Oracle Cloud IoT device type
resource "oci_iot_device_type" "example" {
  name           = "device-type-example"
  compartment_id = "ocid1.compartment.oc1..."

  # Optional attributes
  description  = "Example IoT device type"
  display_name = "Example IoT device type"
  tags         = {
    "Name" = "Example IoT device type"
  }
}

# Create an Oracle Cloud IoT rule
resource "oci_iot_rule" "example" {
  name           = "rule-example"
  service_id      = oci_iot_service.example.id
  compartment_id = "ocid1.compartment.oc1..."

  # Optional attributes
  description  = "Example IoT rule"
  display_name = "Example IoT rule"
  tags         = {
    "Name" = "Example IoT rule"
  }
}

# Create an Oracle Cloud IoT action
resource "oci_iot_action" "example" {
  name           = "action-example"
  compartment_id = "ocid1.compartment.oc1..."

  # Optional attributes
  description  = "Example IoT action"
  display_name = "Example IoT action"
  tags         = {
    "Name" = "Example IoT action"
  }
}

# Create an Oracle Cloud IoT rule action
resource "oci_iot_rule_action" "example" {
  rule_id     = oci_iot_rule.example.id
  action_id   = oci_iot_action.example.id
  compartment_id = "ocid1.compartment.oc1..."

  # Optional attributes
  description  = "Example IoT rule action"
  display_name = "Example IoT rule action"
  tags         = {
    "Name" = "Example IoT rule action"
  }
}
  
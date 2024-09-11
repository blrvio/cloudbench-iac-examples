
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaax77y757757"
  user_ocid  = "ocid1.user.oc1..aaaaaaaaw77y757757"
  fingerprint = "53:99:76:9C:A6:B9:71:29:42:C0:53:1D:48:B2:41:FB"
}

# Create a Traffic Management Policy
resource "oci_traffic_management_policy" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaay77y757757"
  display_name    = "My Traffic Management Policy"
  description     = "A policy for managing traffic"
  traffic_rules = [
    {
      name  = "rule1"
      match = {
        # Define the matching criteria for the traffic rule
        source_address_block = "0.0.0.0/0"
      }
      action = {
        # Define the action to take on the traffic
        forward_to = ["ocid1.loadbalancer.oc1..aaaaaaaaz77y757757"]
      }
    }
  ]
}

# Create a Traffic Management Association
resource "oci_traffic_management_association" "main" {
  compartment_id     = "ocid1.compartment.oc1..aaaaaaaay77y757757"
  traffic_management_policy_id = oci_traffic_management_policy.main.id
  target_type    = "INSTANCE"
  target_id      = "ocid1.instance.oc1..aaaaaaaab77y757757"
}

# Create a Traffic Management Association using a Load Balancer as target
resource "oci_traffic_management_association" "lb_target" {
  compartment_id     = "ocid1.compartment.oc1..aaaaaaaay77y757757"
  traffic_management_policy_id = oci_traffic_management_policy.main.id
  target_type    = "LOAD_BALANCER"
  target_id      = "ocid1.loadbalancer.oc1..aaaaaaaaz77y757757"
}

  
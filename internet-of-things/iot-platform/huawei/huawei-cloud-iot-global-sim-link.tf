
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1"
}

# Create a Global SIM Link Profile
resource "huaweicloud_iot_global_sim_link_profile" "main" {
  name = "my-global-sim-link-profile"
  description = "Example Global SIM Link Profile"
}

# Create a Global SIM Link Device
resource "huaweicloud_iot_global_sim_link_device" "main" {
  name           = "my-global-sim-link-device"
  profile_id     = huaweicloud_iot_global_sim_link_profile.main.id
  sim_iccid      = "SIM_ICCID_PLACEHOLDER"
  device_id     = "DEVICE_ID_PLACEHOLDER"
  device_type   = "DEVICE_TYPE_PLACEHOLDER"
  description = "Example Global SIM Link Device"
  # Optional configurations can be added here
}

  
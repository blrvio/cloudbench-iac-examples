
    # Configure the AzureRM Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Recovery Services Vault
resource "azurerm_recovery_services_vault" "example" {
  name                = "example-vault"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku                 = "Standard"
}

# Create a Protected Virtual Machine
resource "azurerm_recovery_services_protected_vm" "example" {
  name                                    = "example-vm"
  recovery_services_vault_id              = azurerm_recovery_services_vault.example.id
  virtual_machine_id                        = "example-vm"
  protection_state                         = "Protected"
  replication_protection_status           = "Protected"
  replication_health_status               = "Healthy"
  last_replication_time                   = "2023-10-27T00:00:00Z"
  last_replicated_time                   = "2023-10-27T00:00:00Z"
  source_location                          = "example-location"
  recovery_point_type                      = "Latest"
  replication_provider_type              = "HyperV"
  replication_health_error_details        = "None"
  replication_status_details              = "None"
  replication_health_status_description   = "The VM is protected and replicated successfully."
  planned_failover_health_status         = "Not applicable"
  planned_failover_health_status_details = "Not applicable"
  test_failover_health_status           = "Not applicable"
  test_failover_health_status_details   = "Not applicable"
  primary_fabric_id                        = "example-fabric"
  primary_fabric_location                  = "example-location"
  target_fabric_id                        = "example-fabric"
  target_fabric_location                  = "example-location"
  replication_source_disk_details  = [{"diskName": "disk0", "diskType": "Standard", "diskSizeGB": 1023}]
  replication_target_disk_details = [{"diskName": "disk0", "diskType": "Standard", "diskSizeGB": 1023}]
  target_resource_group_name           = "example-resources"
  target_location                    = "westus2"
  target_resource_group_location        = "westus2"
}

# Create a Recovery Plan
resource "azurerm_recovery_services_recovery_plan" "example" {
  name                                = "example-recovery-plan"
  recovery_services_vault_id         = azurerm_recovery_services_vault.example.id
  primary_fabric_id                   = "example-fabric"
  primary_fabric_location             = "example-location"
  target_fabric_id                   = "example-fabric"
  target_fabric_location             = "example-location"
  replication_provider_type         = "HyperV"
  failover_direction                   = "PrimaryToRecovery"
  replication_group_id                 = "example-replication-group"
  recovery_plan_group_id               = "example-recovery-plan-group"
  recovery_plan_properties {
    recovery_plan_replication_groups {
      replication_group_id = "example-replication-group"
      recovery_group_id     = "example-recovery-group"
      replicated_items      = ["example-vm"]
    }
  }
}

  
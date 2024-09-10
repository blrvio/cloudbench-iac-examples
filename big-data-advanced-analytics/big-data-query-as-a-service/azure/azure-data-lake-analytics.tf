
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable Azure features
}

# Create a Data Lake Analytics Account
resource "azurerm_data_lake_analytics_account" "example" {
  name                     = "example-adla"
  location                 = "westus2"
  resource_group_name     = "example-rg"
  default_data_lake_store = "example-store"
  # optional:  data_lake_store_accounts = ["example-store"]
}

# Create a Data Lake Store Account
resource "azurerm_data_lake_store_account" "example" {
  name                = "example-store"
  resource_group_name = "example-rg"
  location            = "westus2"
}

# Create a Data Lake Analytics Job
resource "azurerm_data_lake_analytics_job" "example" {
  name                = "example-job"
  account_name         = azurerm_data_lake_analytics_account.example.name
  resource_group_name = "example-rg"
  # Optional parameters
  # job_properties = <<EOF
  # { "Runtime": "U-SQL", "DataLakeStoreName": "example-store"}
  # EOF
  # priority = 1
  # max_degree_of_parallelism = 16
  # continue_on_error = true
  # submit_as_user = "example-user"
  # timeout = "PT1H"
}

  

    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Batch account
resource "azurerm_batch_account" "example" {
  name                = "mybatchaccount"
  resource_group_name = "myresourcegroup"
  location            = "westus2"

  # Optional settings
  auto_pool_specification {
    pool_lifetime_option = "job
    keep_alive {
      duration  = 3600 # Keep pool alive for 1 hour (in seconds)
    }
  }
}

# Create a Batch pool
resource "azurerm_batch_pool" "example" {
  name                 = "mybatchpool"
  batch_account_name   = azurerm_batch_account.example.name
  resource_group_name = azurerm_batch_account.example.resource_group_name
  vm_size             = "Standard_A2_v2"
  # Optional settings
  start_task {
    command_line = "echo 'Start task running'" # Specify a start task command
  }
  resize_operation {
    target_dedicated_nodes      = 10 # Specify a target number of dedicated nodes
    target_low_priority_nodes = 10 # Specify a target number of low priority nodes
    timeout_duration          = 600 # Set a timeout for the resize operation (in seconds)
  }
}

# Create a Batch job
resource "azurerm_batch_job" "example" {
  name                 = "mybatchjob"
  batch_account_name   = azurerm_batch_account.example.name
  resource_group_name = azurerm_batch_account.example.resource_group_name
  pool_id             = azurerm_batch_pool.example.id
  # Optional settings
  on_all_tasks_complete = "terminatejob"
  # Define the job's tasks
  job_preparation_task {
    command_line = "echo 'Job preparation task running'" # Specify a job preparation task command
  }
  job_release_task {
    command_line = "echo 'Job release task running'" # Specify a job release task command
  }
  task {
    command_line = "echo 'Task running'" # Specify a task command
  }
}

# Create a Batch task
resource "azurerm_batch_task" "example" {
  name                 = "mybatchtask"
  batch_account_name   = azurerm_batch_account.example.name
  resource_group_name = azurerm_batch_account.example.resource_group_name
  pool_id             = azurerm_batch_pool.example.id
  job_id              = azurerm_batch_job.example.id
  # Optional settings
  command_line      = "echo 'Task running'" # Specify a task command
  constraints        = "maximumretrycount=3" # Set task constraints
  user_identity      = "autoUser"
  affinity_id       = "myaffinity"
  affinity_group_name = "myaffinitygroup"
  # Define task dependencies
  depends_on = [azurerm_batch_task.example]
}

  
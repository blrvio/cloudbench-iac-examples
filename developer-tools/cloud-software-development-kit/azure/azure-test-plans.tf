
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use o recurso para habilitar as últimas funcionalidades
}

# Crie um plano de teste
resource "azurerm_test_plan" "example" {
  name     = "example-test-plan"
  project_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitua pelo ID do projeto
}

# Crie um conjunto de testes
resource "azurerm_test_suite" "example" {
  name     = "example-test-suite"
  plan_id = azurerm_test_plan.example.id
}

# Crie um caso de teste
resource "azurerm_test_case" "example" {
  name        = "example-test-case"
  suite_id    = azurerm_test_suite.example.id
  area_path   = "example-area"
  iteration_path = "example-iteration"
}

# Crie um ponto de verificação
resource "azurerm_test_point" "example" {
  name     = "example-test-point"
  case_id = azurerm_test_case.example.id
  result    = "Passed"
}

# Crie uma execução de teste
resource "azurerm_test_run" "example" {
  name         = "example-test-run"
  plan_id      = azurerm_test_plan.example.id
  suite_id     = azurerm_test_suite.example.id
  start_date  = "2023-01-01T00:00:00Z"
  end_date    = "2023-01-02T00:00:00Z"
  assigned_to = "example-user"
  state       = "Completed"
}

# Crie um resultado de teste
resource "azurerm_test_result" "example" {
  run_id      = azurerm_test_run.example.id
  case_id     = azurerm_test_case.example.id
  outcome    = "Passed"
  duration    = 120
  started_date = "2023-01-01T00:00:00Z"
  completed_date = "2023-01-01T00:01:00Z"
}
    
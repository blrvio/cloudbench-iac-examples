
      # Configure o provedor Oracle Cloud
provider "oci" {
  region = "us-ashburn-1"
}

# Crie um função
resource "oci_functions_function" "my_function" {
  name  = "my_function"
  runtime = "java11"
  source_code = "// Código da função em Java
import com.oracle.bmc.functions.runtime.Context;

public class MyFunction {
  public String handleRequest(Context context, String input) {
    return "Olá, mundo!";
  }
}"
  handler = "MyFunction.handleRequest"
  memory = 128
  timeout_in_seconds = 60
}

# Crie um endpoint para a função
resource "oci_functions_function_endpoint" "my_endpoint" {
  function_id = oci_functions_function.my_function.id
  name       = "my_endpoint"
}

    

    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Qiskit runtime program
resource "ibm_qiskit_runtime_program" "main" {
  name = "my-quantum-program"
  # Replace with the path to your Qiskit runtime program file
  program_file = "path/to/my-program.py"
  # Replace with the name of your Qiskit runtime program
  program_name = "my-program"
  # Select the quantum runtime version
  runtime_version = "0.10"
  # Select the quantum backend
  backend = "ibmq_jakarta"
}

# Create a Qiskit runtime session
resource "ibm_qiskit_runtime_session" "main" {
  program_id = ibm_qiskit_runtime_program.main.id
  # Optional: Specify a maximum execution time (in seconds)
  max_execution_time = 600
}

# Use the Qiskit runtime session to execute your program
output "session_id" {
  value = ibm_qiskit_runtime_session.main.id
}

  
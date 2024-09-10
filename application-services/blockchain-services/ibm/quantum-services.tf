
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create a Quantum system
resource "ibm_quantum_system" "my_quantum_system" {
  name = "my-quantum-system"
  # Define the IBM Cloud account ID
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
}

# Create a Quantum program
resource "ibm_quantum_program" "my_quantum_program" {
  name = "my-quantum-program"
  # Define the IBM Cloud account ID
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
  # Define the Quantum system ID
  system_id = ibm_quantum_system.my_quantum_system.id

  # Specify the source code for the quantum program
  source_code = <<EOF
// Define the quantum circuit
OPENQASM 2.0;
include "qelib1.inc";

qreg q[2];
creg c[2];

h q[0];
cx q[0],q[1];
measure q[0] -> c[0];
measure q[1] -> c[1];
EOF
}

# Create a Quantum job
resource "ibm_quantum_job" "my_quantum_job" {
  name = "my-quantum-job"
  # Define the IBM Cloud account ID
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
  # Define the Quantum program ID
  program_id = ibm_quantum_program.my_quantum_program.id
}

  
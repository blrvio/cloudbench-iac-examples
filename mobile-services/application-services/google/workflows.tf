
    # Configure the Google Cloud provider
provider "google" {
  project  = "your-project-id"
  region   = "us-central1"
  zone     = "us-central1-a"
}

# Create a Workflow
resource "google_workflows_workflow" "main" {
  name     = "my-workflow"
  location = "us-central1"

  # Example workflow code
  source = <<EOF
package main

import (
  "context"
  "log"

  "cloud.google.com/go/workflows/apiv1beta"
)

func main() {
  ctx := context.Background()

  // Create a Workflow Client
  client, err := workflows.NewClient(ctx)
  if err != nil {
    log.Fatalf("Failed to create Workflow Client: %v", err)
  }
  defer client.Close()

  // Create a new Workflow
  workflow := &workflowspb.Workflow{
    Name: "my-workflow",
  }

  // Create the Workflow
  createdWorkflow, err := client.CreateWorkflow(ctx, workflow)
  if err != nil {
    log.Fatalf("Failed to create Workflow: %v", err)
  }
  log.Printf("Workflow created: %s", createdWorkflow.Name)
}
EOF
}

# Create a Workflow Execution
resource "google_workflows_execution" "main" {
  workflow = google_workflows_workflow.main.name
  location = google_workflows_workflow.main.location
}

  
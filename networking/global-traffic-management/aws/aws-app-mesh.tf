
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma malha do App Mesh
resource "aws_appmesh_mesh" "example" {
  name = "example"
  # ...
}

# Crie um virtual service
resource "aws_appmesh_virtual_service" "example" {
  mesh_name = aws_appmesh_mesh.example.name
  name      = "example"
  # ...
}

# Crie um virtual router
resource "aws_appmesh_virtual_router" "example" {
  mesh_name = aws_appmesh_mesh.example.name
  name      = "example"
  virtual_service_name = aws_appmesh_virtual_service.example.name
  # ...
}

# Crie uma rota
resource "aws_appmesh_route" "example" {
  mesh_name = aws_appmesh_mesh.example.name
  name      = "example"
  virtual_router_name = aws_appmesh_virtual_router.example.name
  # ...
}

# Crie um virtual node
resource "aws_appmesh_virtual_node" "example" {
  mesh_name = aws_appmesh_mesh.example.name
  name      = "example"
  # ...
}

# Crie um listener
resource "aws_appmesh_virtual_node_listener" "example" {
  mesh_name     = aws_appmesh_mesh.example.name
  virtual_node_name = aws_appmesh_virtual_node.example.name
  # ...
}

# Crie um backend
resource "aws_appmesh_virtual_node_backend" "example" {
  mesh_name     = aws_appmesh_mesh.example.name
  virtual_node_name = aws_appmesh_virtual_node.example.name
  # ...
}
    
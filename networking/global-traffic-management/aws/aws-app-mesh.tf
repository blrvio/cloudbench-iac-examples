
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS App Mesh Virtual Node
resource "aws_appmesh_virtual_node" "main" {
  mesh_name = "my-appmesh"
  name      = "my-virtual-node"
  spec {
    backend {
      virtual_service {
        virtual_service_name = "my-virtual-service"
      }
    }
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
    service_discovery {
      aws_cloud_map {
        namespace_name = "my-namespace"
        service_name   = "my-service"
      }
    }
  }
  tags = {
    Name = "My Virtual Node"
  }
}

# Create an AWS App Mesh Virtual Router
resource "aws_appmesh_virtual_router" "main" {
  mesh_name = "my-appmesh"
  name      = "my-virtual-router"
  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
    route {
      http_route {
        action {
          weighted_targets {
            weighted_target {
              virtual_node = aws_appmesh_virtual_node.main.name
              weight       = 100
            }
          }
        }
        match {
          prefix = "/my-path"
        }
      }
    }
  }
  tags = {
    Name = "My Virtual Router"
  }
}

# Create an AWS App Mesh Virtual Service
resource "aws_appmesh_virtual_service" "main" {
  mesh_name = "my-appmesh"
  name      = "my-virtual-service"
  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.main.name
      }
    }
  }
  tags = {
    Name = "My Virtual Service"
  }
}
  
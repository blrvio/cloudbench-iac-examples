
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um cluster EKS
resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = "arn:aws:iam::123456789012:role/eks-cluster-role"
  # Supressão de long strings (certificado e outros campos)
}

# Crie um nó do worker EKS
resource "aws_eks_node_group" "example" {
  cluster_name = aws_eks_cluster.example.name
  nodegroup_name = "example"
  # Supressão de long strings (configurações do nó)
}

# Crie um serviço Kubernetes
resource "kubernetes_manifest" "nginx" {
  # Supressão de long strings (YAML do serviço)
}

# Crie um deployment Kubernetes
resource "kubernetes_manifest" "nginx_deployment" {
  # Supressão de long strings (YAML do deployment)
}
    
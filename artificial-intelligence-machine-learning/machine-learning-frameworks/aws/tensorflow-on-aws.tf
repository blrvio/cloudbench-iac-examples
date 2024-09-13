
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster do EKS
resource "aws_eks_cluster" "tf_eks_cluster" {
  name     = "tf-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  # ...
}

# Crie um role IAM para o cluster do EKS
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
  # ...
}

# Crie um role IAM para o serviço TensorFlow
resource "aws_iam_role" "tensorflow_role" {
  name = "tensorflow_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
  # ...
}

# Crie um perfil IAM para o serviço TensorFlow
resource "aws_iam_instance_profile" "tensorflow_profile" {
  name = "tensorflow_profile"
  role = aws_iam_role.tensorflow_role.name
}

# Crie uma instância EC2 para executar o TensorFlow
resource "aws_instance" "tensorflow_instance" {
  ami           = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH
  # ...
  iam_instance_profile = aws_iam_instance_profile.tensorflow_profile.name
  # ...
}

# Crie um serviço Kubernetes para executar o TensorFlow
resource "kubernetes_manifest" "tensorflow_service" {
  # ...
  manifest = <<EOF
apiVersion: v1
kind: Service
metadata:
  name: tensorflow-service
  namespace: default
spec:
  selector: 
    app: tensorflow
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
EOF
}

# Crie um deployment Kubernetes para executar o TensorFlow
resource "kubernetes_manifest" "tensorflow_deployment" {
  # ...
  manifest = <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tensorflow-deployment
  namespace: default
spec:
  replicas: 1
  selector: 
    matchLabels: 
      app: tensorflow
  template:
    metadata:
      labels: 
        app: tensorflow
    spec:
      containers:
      - name: tensorflow
        image: tensorflow/tensorflow:latest
        ports:
        - containerPort: 80
EOF
}
    
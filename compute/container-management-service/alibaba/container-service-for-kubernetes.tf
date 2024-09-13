
      # Configure o provedor do Kubernetes
provider "kubernetes" {
  host     = "<YOUR_CLUSTER_ENDPOINT>"
  cluster_ca_certificate = "<YOUR_CA_CERT>"
  token    = "<YOUR_ACCESS_TOKEN>"
}

# Crie um namespace
resource "kubernetes_namespace" "example" {
  metadata {
    name = "example"
  }
}

# Crie um deployment
resource "kubernetes_manifest" "deployment" {
  manifest = <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: example
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
EOF
}

# Crie um service
resource "kubernetes_manifest" "service" {
  manifest = <<EOF
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: example
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
EOF
}
    
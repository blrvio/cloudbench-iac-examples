
      # Configure o provedor do RabbitMQ
provider "rabbitmq" {
  host = "rabbitmq.example.com" # Substitua pelo host do seu servidor RabbitMQ
  port = 5672 # Substitua pela porta do seu servidor RabbitMQ
  user = "guest" # Substitua pelo usuário do seu servidor RabbitMQ
  password = "guest" # Substitua pela senha do seu servidor RabbitMQ
}

# Crie uma exchange
resource "rabbitmq_exchange" "my_exchange" {
  name   = "my_exchange"
  type   = "direct"
  durable = true
}

# Crie uma fila
resource "rabbitmq_queue" "my_queue" {
  name   = "my_queue"
  durable = true
}

# Crie uma ligação entre a exchange e a fila
resource "rabbitmq_binding" "my_binding" {
  exchange = rabbitmq_exchange.my_exchange.name
  queue    = rabbitmq_queue.my_queue.name
  routing_key = "my_key"
}

    
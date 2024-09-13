
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Substitua com recursos extras se necessário
}

# Crie um espaço de trabalho do Stream Analytics
resource "azurerm_stream_analytics_job" "example" {
  name                = "example-stream-analytics-job"
  resource_group_name = "example-resource-group"
  location            = "westus2"

  streaming_jobs {
    eventsource {
      eventhub {
        eventhub_name    = "example-eventhub"
        eventhub_namespace = "example-eventhub-namespace"
        consumer_group     = "$Default"
        # Substitua com as credenciais reais para a sua conta do Azure
        shared_access_policy_name = "example-shared-access-policy"
        shared_access_key      = "example-shared-access-key"
      }
    }

    transformation {
      select {
        # Defina os campos para serem selecionados e transformados
        # Aqui, selecionamos o campo "message" do evento
        "message" = "input.message"
      }
    }

    output {
      blob {
        # Substitua com a string de conexão para o armazenamento de blobs do Azure
        connection_string = "example-connection-string"
      }
    }
  }
}

# Crie um espaço de trabalho do Stream Analytics
resource "azurerm_stream_analytics_job" "example" {
  name                = "example-stream-analytics-job"
  resource_group_name = "example-resource-group"
  location            = "westus2"

  streaming_jobs {
    eventsource {
      eventhub {
        eventhub_name    = "example-eventhub"
        eventhub_namespace = "example-eventhub-namespace"
        consumer_group     = "$Default"
        # Substitua com as credenciais reais para a sua conta do Azure
        shared_access_policy_name = "example-shared-access-policy"
        shared_access_key      = "example-shared-access-key"
      }
    }

    transformation {
      select {
        # Defina os campos para serem selecionados e transformados
        # Aqui, selecionamos o campo "message" do evento
        "message" = "input.message"
      }
    }

    output {
      blob {
        # Substitua com a string de conexão para o armazenamento de blobs do Azure
        connection_string = "example-connection-string"
      }
    }
  }
}

    
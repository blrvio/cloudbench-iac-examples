
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use as novas features do Azure
}

# Crie um namespace do Event Hub
resource "azurerm_eventhub_namespace" "example" {
  name                = "example-namespace"
  location            = "westus"
  resource_group_name = "example-resources"
  sku                 = "Basic"
}

# Crie um Event Hub
resource "azurerm_eventhub" "example" {
  name                = "example-eventhub"
  namespace_name     = azurerm_eventhub_namespace.example.name
  resource_group_name = "example-resources"
  partition_count     = 2
  message_retention   = "P7"
}

# Configure a conexão com o Event Hub no aplicativo
# Substitua o nome da sua aplicação e o nome da sua conexão pelo nome do Event Hub
# Exemplo:
// importanto o SDK do Azure para Node.js
const { EventHubClient } = require("@azure/event-hubs");
const connectionString = "Endpoint=sb://example-namespace.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const client = new EventHubClient(connectionString);

// Enviando uma mensagem para o Event Hub
const sendEvent = async () => {
  const batch = await client.createBatchSender(example-eventhub); // Substitua por `example-eventhub`
  const message = { body: "Olá, mundo!" };
  batch.send(message);
  console.log(`Mensagem enviada: ${message.body}`);
}

sendEvent().catch(error => console.error(error));
    
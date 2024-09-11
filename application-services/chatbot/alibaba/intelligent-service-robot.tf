
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a chatbot
resource "alicloud_bot_bot" "main" {
  name = "my-chatbot"
  # Optional fields
  instance_type = "basic"
  # Define the bot's language
  lang = "zh-CN"
  # Define the bot's default welcome message
  welcome_message = "Hello, welcome to my chatbot!"
  # Define the bot's default farewell message
  farewell_message = "Goodbye!"
}

# Create a chatbot dialogue
resource "alicloud_bot_dialogue" "main" {
  bot_id = alicloud_bot_bot.main.id
  name = "my-dialogue"
  # Optional fields
  intent_type = "text"
  # Define the dialogue's trigger words
  trigger_words = ["hello", "hi"]
  # Define the dialogue's response message
  response_message = "Hello, how can I help you today?"
}

# Create a chatbot intent
resource "alicloud_bot_intent" "main" {
  bot_id = alicloud_bot_bot.main.id
  name = "my-intent"
  # Optional fields
  intent_type = "text"
  # Define the intent's trigger words
  trigger_words = ["weather", "forecast"]
  # Define the intent's response message
  response_message = "The weather today is ..."
}

# Create a chatbot knowledge base
resource "alicloud_bot_knowledge_base" "main" {
  bot_id = alicloud_bot_bot.main.id
  name = "my-knowledge-base"
  # Optional fields
  knowledge_base_type = "custom"
  # Define the knowledge base's content
  content = "My knowledge base content"
}

  
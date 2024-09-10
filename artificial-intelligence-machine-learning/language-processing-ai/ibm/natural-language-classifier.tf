
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Natural Language Classifier
resource "ibm_natural_language_classifier" "main" {
  name     = "my-classifier"
  language = "en"
  training_data = <<EOF
  [ 
    {
      "text": "I love this product!",
      "class": "positive"
    },
    {
      "text": "This product is terrible!",
      "class": "negative"
    }
  ]
  EOF
}

  
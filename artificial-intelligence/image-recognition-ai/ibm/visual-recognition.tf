
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_API_KEY"
}

# Create a Visual Recognition classifier
resource "ibm_visual_recognition_classifier" "my_classifier" {
  name = "my_classifier"
  classifier_type = "custom"
  # Add your training data here
  # Positive examples
  positive_examples = [ "path/to/your/positive/image.jpg" ]
  # Negative examples
  negative_examples = [ "path/to/your/negative/image.jpg" ]
}

# Use the classifier to classify an image
resource "ibm_visual_recognition_classify" "classify_image" {
  classifier_id = ibm_visual_recognition_classifier.my_classifier.id
  image_url = "https://example.com/image.jpg"
}

# Output the classification results
output "classification_results" {
  value = ibm_visual_recognition_classify.classify_image.classes
}
  
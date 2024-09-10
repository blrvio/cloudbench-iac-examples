
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Google Cloud Storage bucket for storing audio files
resource "google_storage_bucket" "main" {
  name     = "speech-api-bucket"
  location = "US"
  force_destroy = true # Allow bucket deletion even if it contains objects
}

# Create a Cloud Function to transcribe audio files
resource "google_cloudfunctions_function" "main" {
  name        = "speech-to-text"
  runtime     = "nodejs16"
  entry_point = "transcribe"
  source_archive_bucket = google_storage_bucket.main.name
  source_archive_object = "speech-to-text.zip"
  trigger_http  = true
  memory = 128 # Set the memory allocation in MB
  timeout = 60  # Set the timeout in seconds

  # Define the environment variables for the function
  environment = {
    GOOGLE_APPLICATION_CREDENTIALS = "path/to/your/credentials.json"
  }
}

# Define the Cloud Function code (transcribe.js)
resource "google_storage_bucket_object" "transcribe_code" {
  bucket = google_storage_bucket.main.name
  name = "speech-to-text.zip"
  source = <<EOF
const functions = require('firebase-functions');
const { SpeechClient } = require('@google-cloud/speech');

const client = new SpeechClient();

const transcribe = functions.https.onRequest((req, res) => {
  // Get the audio file from the request
  const audio = req.body.audio;

  // Configure the speech recognition request
  const config = {
    encoding: 'LINEAR16', // Audio encoding
    sampleRateHertz: 16000,  // Sample rate
    languageCode: 'en-US', // Language
  };

  const audioConfig = {
    audioEncoding: config.encoding,
    sampleRateHertz: config.sampleRateHertz,
    audioSource: {
      uri: audio,
    },
  };

  // Recognize the audio file
  client.recognize(config, audioConfig)
    .then(responses => {
      const transcription = responses[0].results.map(result => {
        return result.alternatives[0].transcript;
      }).join('');

      // Send the transcription back as a response
      res.send(transcription);
    })
    .catch(err => {
      console.error('Error during transcription:', err);
      res.status(500).send('Error during transcription');
    });
});

module.exports = {
  transcribe
};
EOF
}

  
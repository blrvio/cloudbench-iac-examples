
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Crie um job de análise de vídeo
resource "google_video_intelligence_job" "video_analysis" {
  input_uri = "gs://bucket-name/video.mp4"
  features  = ["LABEL_DETECTION", "OBJECT_TRACKING"]
  output_uri = "gs://bucket-name/output"
}

# Acesse os resultados da análise
output "analysis_results" {
  value = google_video_intelligence_job.video_analysis.output_uri
}
    
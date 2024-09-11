
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a Text-to-Speech project
resource "huaweicloud_tts_project" "main" {
  name = "my-tts-project"
}

# Create a Text-to-Speech voice
resource "huaweicloud_tts_voice" "main" {
  project_id = huaweicloud_tts_project.main.id
  name       = "my-tts-voice"
  language  = "en-US"
  gender     = "female"
}

# Create a Text-to-Speech synthesis job
resource "huaweicloud_tts_synthesis_job" "main" {
  project_id = huaweicloud_tts_project.main.id
  voice_id   = huaweicloud_tts_voice.main.id
  text       = "Hello, world!"
  output_format = "mp3"
}

  
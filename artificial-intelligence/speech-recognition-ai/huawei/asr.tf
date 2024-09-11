
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your Huawei Cloud region
  region = "cn-north-1"
}

# Create an ASR instance
resource "huaweicloud_asr_instance" "main" {
  # Replace with a valid ASR instance name
  name = "my-asr-instance"
  # Replace with a valid ASR instance type
  type = "standard"
  # Replace with a valid ASR instance language
  language = "en-US"
}

# Create an ASR task
resource "huaweicloud_asr_task" "main" {
  # Replace with a valid ASR task name
  name = "my-asr-task"
  # Replace with a valid ASR instance ID
  asr_instance_id = huaweicloud_asr_instance.main.id
  # Replace with a valid ASR task audio URL
  audio_url = "https://example.com/audio.wav"
  # Replace with a valid ASR task language
  language = "en-US"
}

  
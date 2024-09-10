
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Elemental MediaConvert Job Template
resource "aws_mediaconvert_job_template" "main" {
  name = "my-job-template"

  # Define the settings for the job template
  settings {
    # Configure the input settings
    inputs {
      # Define the input source
      audio_selectors {
        # Select the audio track
        audio_pid = "101"
        # Set the audio language code
        language_code = "en-US"
      }
      # Specify the input file or stream
      file_source_settings {
        # Provide the path to the input file
        s3_input_source {
          bucket_name = "my-bucket"
          key          = "input-file.mp4"
        }
      }
    }

    # Configure the output settings
    outputs {
      # Specify the output container format
      container_settings {
        # Use the MP4 container format
        mp4_settings {
          # Set the MP4 output file name prefix
          file_name_prefix = "output"
        }
      }

      # Configure the output video settings
      video_description {
        # Set the output video codec
        codec_settings {
          # Use the H.264 video codec
          h264_settings {
            # Specify the output video resolution
            resolution = "1280x720"
          }
        }
      }

      # Configure the output audio settings
      audio_description {
        # Set the output audio codec
        codec_settings {
          # Use the AAC audio codec
          aac_settings {
            # Specify the output audio bitrate
            bitrate = 128
          }
        }
      }
    }
  }
}

# Create an AWS Elemental MediaConvert Job
resource "aws_mediaconvert_job" "main" {
  # Specify the job template to use
  job_template_id = aws_mediaconvert_job_template.main.id

  # Define the settings for the job
  settings {
    # Configure the input settings
    inputs {
      # Select the audio track
      audio_selectors {
        # Select the audio track
        audio_pid = "101"
        # Set the audio language code
        language_code = "en-US"
      }
      # Specify the input file or stream
      file_source_settings {
        # Provide the path to the input file
        s3_input_source {
          bucket_name = "my-bucket"
          key          = "input-file.mp4"
        }
      }
    }

    # Configure the output settings
    outputs {
      # Specify the output container format
      container_settings {
        # Use the MP4 container format
        mp4_settings {
          # Set the MP4 output file name prefix
          file_name_prefix = "output"
        }
      }

      # Configure the output video settings
      video_description {
        # Set the output video codec
        codec_settings {
          # Use the H.264 video codec
          h264_settings {
            # Specify the output video resolution
            resolution = "1280x720"
          }
        }
      }

      # Configure the output audio settings
      audio_description {
        # Set the output audio codec
        codec_settings {
          # Use the AAC audio codec
          aac_settings {
            # Specify the output audio bitrate
            bitrate = 128
          }
        }
      }
    }
  }
}

  
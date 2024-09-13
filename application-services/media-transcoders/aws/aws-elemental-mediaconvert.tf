
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma fila de conversão
resource "aws_mediaconvert_queue" "default" {
  name = "my-media-convert-queue"
}

# Crie um endpoint de MediaConvert
resource "aws_mediaconvert_endpoint" "default" {
  name = "my-media-convert-endpoint"
}

# Crie uma tarefa de conversão
resource "aws_mediaconvert_job" "example" {
  role           = "arn:aws:iam::123456789012:role/mediaconvert-role" # Substitua pelo ARN do seu papel IAM
  queue         = aws_mediaconvert_queue.default.id
  settings       = {
    inputs       = [
      {
        audio_selectors = [
          {
            audio_pid           = "1"
            selector_type       = "pid"
            selector_settings = {
              pid               = 1
            }
          }
        ]
        file_source_settings = {
          s3_settings = {
            bucket_name = "my-bucket" # Substitua pelo nome do seu bucket S3
            object_key  = "my-file.mp4" # Substitua pelo nome do seu arquivo de mídia
          }
        }
      }
    ]
    output_groups = [
      {
        name = "HLS Output"
        output_group_settings = {
          hls_group_settings = {
            ad_markers                 = "none"
            segment_length             = 5
            stream_inf_resolution       = "include"
            destination_settings       = {
              s3_settings = {
                bucket_name = "my-bucket" # Substitua pelo nome do seu bucket S3
                canned_acl  = "bucket-owner-full-control"
              }
            }
            hls_manifest_settings = {
              manifest_name_modifier  = "my-hls"
              ad_markers               = "none"
              playlist_type            = "event"
              playlist_duration_constraint = "max"
            }
          }
        }
        outputs = [
          {
            audio_description = [
              {
                audio_type_control = "follow_input"
                codec_settings = {
                  aac_settings = {
                    bitrate     = 128
                    coding_mode = "stereo"
                    profile     = "lc"
                    rate_control_mode = "cbr"
                  }
                }
                language_code       = "en"
                language_code_control = "follow_input"
                sampling_rate = 48000
              }
            ]
            caption_descriptions = [
              {
                caption_selector_settings = {
                  language_code = "en"
                }
                destination_settings = {
                  s3_settings = {
                    bucket_name = "my-bucket" # Substitua pelo nome do seu bucket S3
                  }
                }
                language_code = "en"
              }
            ]
            container_settings = {
              fmp4_settings = {
                audio_duration = 0
              }
            }
            video_description = [
              {
                scaling_behavior = "default"
                width            = 1280
                height           = 720
                codec_settings = {
                  h264_settings = {
                    bitrate                  = 2000
                    framerate                = 24
                    par                  = "16:9"
                    rate_control_mode       = "cbr"
                    interlace_mode           = "progressive"
                    scan_type               = "progressive"
                    profile                 = "high"
                    level                   = "auto"
                    adaptive_quantization = "auto"
                  }
                }
                height_control    = "specify_resolution"
                width_control      = "specify_resolution"
                resolution_mode    = "fixed_resolution"
                aspect_ratio_mode  = "fixed_aspect_ratio"
                frame_rate_mode = "follow_input"
                afv_mode           = "none"
                color_metadata = "bt709"
              }
            ]
          }
        ]
      }
    ]
  }
  status = "start"
}

    
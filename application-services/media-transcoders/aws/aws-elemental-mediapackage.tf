
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um canal MediaPackage
resource "aws_mediapackage_channel" "example" {
  id          = "example"
  description = "Example MediaPackage Channel"
  ingest {
    id = "example"
  }
  egress_endpoint {
    packaging_configuration_id = aws_mediapackage_packaging_configuration.example.id
  }
}

# Crie uma configuração de embalagem MediaPackage
resource "aws_mediapackage_packaging_configuration" "example" {
  id   = "example"
  name = "example"

  cmaf_package {
    encryption {
      speke_key_provider {
        resource_id = "example"
        url         = "https://example.com"
      }
    }
  }
}

# Crie um provedor de chave SPEKE
resource "aws_mediapackage_origin_endpoint" "example" {
  id                 = "example"
  channel_id         = aws_mediapackage_channel.example.id
  manifest_name      = "example"
  startover_window_seconds = 0
  time_delay_seconds     = 0

  hls_package {
    ad_markers = "NONE"
  }

  source_endpoint {
    source_selection = "AUTO"
  }
}
    
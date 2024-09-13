
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um perfil de origem
resource "aws_mediatailor_origin_endpoint" "my_origin_endpoint" {
  name              = "my_origin_endpoint"
  channel_name       = "my_channel"
  origin_manifest_url = "https://example.com/manifest.mpd"
  source_selection  = "SINGLE_SOURCE"
  playback_mode    = "LIVE"
}

# Crie um canal
resource "aws_mediatailor_channel" "my_channel" {
  name     = "my_channel"
  playback_mode  = "LIVE"
  hls_ingest {
    ingest_endpoints = [aws_mediatailor_origin_endpoint.my_origin_endpoint.ingest_endpoint]
  }
}

# Crie um perfil de entrega
resource "aws_mediatailor_playback_configuration" "my_playback_configuration" {
  name    = "my_playback_configuration"
  ad_decision_server_url  = "https://example.com/ads"
  manifest_name           = "my_manifest"
  channel_name            = aws_mediatailor_channel.my_channel.id
}

# Crie um usuário
resource "aws_mediatailor_user" "my_user" {
  name  = "my_user"
  role  = "VIEWER"
  ad_marker_passthrough = false
}

# Crie um token para o usuário
resource "aws_mediatailor_token" "my_token" {
  user_id = aws_mediatailor_user.my_user.id
}

    
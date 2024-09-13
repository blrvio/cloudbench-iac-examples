
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  # Configure as suas credenciais e região
}

# Crie um CDN domínio
resource "alicloud_cdn_domain" "example" {
  domain  = "example.com"
  sources = ["https://example.com"]
  # Configure as configurações adicionais como necessário
}

# Crie um CDN configuração de cache
resource "alicloud_cdn_domain_config" "example" {
  domain  = alicloud_cdn_domain.example.domain
  # Configure as configurações de cache como necessário
}

# Crie um CDN configuração de origem
resource "alicloud_cdn_domain_origin" "example" {
  domain = alicloud_cdn_domain.example.domain
  # Configure as configurações de origem como necessário
}
    
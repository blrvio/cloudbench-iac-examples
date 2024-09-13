
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  region = "cn-hangzhou" # Substitua pela sua região desejada
}

# Crie um projeto de log
resource "alicloud_log_project" "default" {
  name = "my-log-project"
}

# Crie um logstore
resource "alicloud_log_store" "default" {
  project = alicloud_log_project.default.id
  name     = "my-log-store"
}

# Crie um índice de log
resource "alicloud_log_index" "default" {
  project = alicloud_log_project.default.id
  logstore = alicloud_log_store.default.id
  name     = "my-log-index"
  keys      = ["timestamp", "message"]
}

# Crie uma regra de exportação de log
resource "alicloud_log_export" "default" {
  project = alicloud_log_project.default.id
  logstore = alicloud_log_store.default.id
  name     = "my-log-export"
  destination = "oss://my-oss-bucket/logs"
  filter   = "timestamp > 1600000000"
}

# Crie uma regra de ingestão de log
resource "alicloud_log_ingest_rule" "default" {
  project = alicloud_log_project.default.id
  logstore = alicloud_log_store.default.id
  name = "my-ingest-rule"
  content = "{
      "condition": "timestamp > 1600000000",
      "action": "drop"
  }"
}
    
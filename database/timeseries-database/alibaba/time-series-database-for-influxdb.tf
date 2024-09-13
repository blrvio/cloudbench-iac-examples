
      # Configure the InfluxDB provider
provider "influxdb" {
  url     = "https://example.com"
  token   = "example_token"
  org     = "example_org"
  bucket  = "example_bucket"
}

# Create a measurement
resource "influxdb_measurement" "my_measurement" {
  name     = "my_measurement"
  database = "my_database"
  fields   = {
    "value" = "float"
  }
}

# Write data to the measurement
resource "influxdb_write" "write_data" {
  measurement = influxdb_measurement.my_measurement.name
  database   = influxdb_measurement.my_measurement.database
  data       = <<EOF
my_measurement,tag1=value1,tag2=value2 value=1.0
EOF
}

# Query data from the measurement
resource "influxdb_query" "query_data" {
  query = <<EOF
SELECT * FROM my_measurement WHERE time > now() - 1h
EOF
}
    
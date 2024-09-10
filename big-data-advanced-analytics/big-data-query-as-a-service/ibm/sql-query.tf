
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Create a SQL Query service instance
resource "ibm_sql_query_instance" "main" {
  name     = "my-sql-query-instance"
  plan     = "lite"
  location = "us-south"
}

# Create a database in the SQL Query service
resource "ibm_sql_query_database" "main" {
  name      = "my-database"
  instance  = ibm_sql_query_instance.main.name
  database  = "db2"
}

# Create a user in the SQL Query service
resource "ibm_sql_query_user" "main" {
  name      = "my-user"
  instance  = ibm_sql_query_instance.main.name
  database  = ibm_sql_query_database.main.name
  password  = "my-password"
}

# Create a table in the SQL Query service
resource "ibm_sql_query_table" "main" {
  name     = "my-table"
  instance  = ibm_sql_query_instance.main.name
  database  = ibm_sql_query_database.main.name
  schema    = "MYSCHEMA"
  columns = [
    {
      name   = "id"
      type   = "INT"
      length = 4
    },
    {
      name   = "name"
      type   = "VARCHAR"
      length = 255
    }
  ]
}
  
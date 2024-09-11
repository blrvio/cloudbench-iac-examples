
    # Configure the Oracle provider
provider "oracle" {
  # Replace with your Oracle Cloud credentials
  username = "YOUR_USERNAME"
  password = "YOUR_PASSWORD"
  # Replace with your tenancy identifier
  tenancy = "YOUR_TENANCY"
}

# Create a MySQL database
resource "oracle_mysql_db" "main" {
  # Replace with the name of your database
  name = "my-database"
  # Choose an appropriate database version
  version = "8.0"
  # Define the compartment where the database will be created
  compartment_id = "YOUR_COMPARTMENT_ID"
  # Set the database size in GB
  size = 10
}

# Create a MySQL user
resource "oracle_mysql_user" "main" {
  # Replace with the name of your user
  name = "my-user"
  # Replace with the password for your user
  password = "YOUR_PASSWORD"
  # Link the user to the database
  db_name = oracle_mysql_db.main.name
  # Define the compartment where the user will be created
  compartment_id = "YOUR_COMPARTMENT_ID"
}

# Grant privileges to the user
resource "oracle_mysql_privilege" "main" {
  # Define the user and database
  user_name = oracle_mysql_user.main.name
  db_name = oracle_mysql_db.main.name
  # Grant all privileges to the user
  privileges = ["ALL"]
}

  
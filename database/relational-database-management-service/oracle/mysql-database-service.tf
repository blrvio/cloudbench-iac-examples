
    # Configure the provider
provider "mysql" {
  # Set the hostname of the MySQL server
  host = "localhost"
  # Set the port number of the MySQL server
  port = 3306
  # Set the username to connect to the MySQL server
  username = "root"
  # Set the password to connect to the MySQL server
  password = "your_password"
}

# Create a database
resource "mysql_database" "main" {
  name = "my_database"
}

# Create a user
resource "mysql_user" "main" {
  name = "my_user"
  # Set the password for the user
  password = "your_password"
  # Grant privileges to the user
  privileges = ["ALL PRIVILEGES"]
  # Specify the database to grant privileges on
  database = mysql_database.main.name
}

  
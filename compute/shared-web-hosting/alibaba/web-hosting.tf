
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud credentials
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region     = "cn-hangzhou" # Replace with your desired region
}

# Create a Web Hosting Instance
resource "alicloud_hosting_instance" "main" {
  # Replace with your desired instance configuration
  package_id     = "hosting_basic_package_1"
  duration     = 1
  period_unit  = "Month"
  instance_name = "my-hosting-instance"
  # You can further customize the instance settings based on your needs
}

# Create a Web Hosting Domain
resource "alicloud_hosting_domain" "main" {
  # Replace with your desired domain name
  domain_name    = "example.com"
  instance_id  = alicloud_hosting_instance.main.id
  # You can further configure the domain settings based on your needs
}

# Create a Web Hosting FTP Account
resource "alicloud_hosting_ftp" "main" {
  # Replace with your desired FTP account details
  username       = "user1"
  password       = "password1"
  instance_id    = alicloud_hosting_instance.main.id
  # You can further configure the FTP account settings based on your needs
}

  
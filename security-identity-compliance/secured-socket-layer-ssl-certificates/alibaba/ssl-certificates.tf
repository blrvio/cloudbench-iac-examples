
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
  # Add your Access Key ID and Secret Access Key here
  # ...
}

# Create an SSL Certificate
resource "alicloud_ssl_certificate" "main" {
  common_name = "example.com" # Replace with your domain name
  csr          = "-----BEGIN CERTIFICATE REQUEST-----
MIIDGTCCAgGgAwIBAgIRAJl13y65391W7Z5F44502cwDQYJKoZIhvcNAQELBQAw
EjEQMA4GA1UEChMHQWNtZSBDbzAgFw0yMzAzMDkyMTEyMzZaGA8yNjA2MDYy
MTExMjM2WjBFMQwwDgYDVR0PAQH/BAQDAgKkMBMGA1UdJQQMMAoGCCsGAQUFBwMB
MA8GA1UdEwEB/wQFMAMBAf8wLgYDVR0RBCcwJYILZXhhbXBsZS5jb22HBH8AAAG
EAAAAAAAAAAAAAAAAAAAAAAAEwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AN0/y+3q9Q5o68fW+d/eD0J9C+8V52W0j+k8iV3pP+pK/wM4h1h63pO9+v1o80
B/F2bZ26fF4w+t07x+J+w+f7r7e69XwQ46r+r3y5+k+uN/07f5c3vW395w+g
7J/a0/P7j0v9B847n0v3/v/6x/v/3688+f/m/gX3u/4b/y8H/7f/z98B+kD/u
/9r/v/8v/v/v/z//7/z/3/w//w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/w/
-----END CERTIFICATE REQUEST-----
  }
}

  
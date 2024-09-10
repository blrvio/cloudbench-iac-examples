
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AppStream 2.0 Stack
resource "aws_appstream_stack" "main" {
  name = "my-appstream-stack"
  # Define the stack properties
  display_name = "My AppStream Stack"
  # You can specify the desired capacity by configuring the fleet
  # Configure the fleet
  fleet {
    compute_capacity = "STANDARD"
    instance_type    = "stream.standard.small"
    # You can configure the fleet based on the operating system used by the application
    # Specify the OS
    # operating_system = "WINDOWS_SERVER_2019"
    # operating_system = "AMAZON_LINUX_2"
    # Configure the fleet image
    fleet_image {
      name       = "my-fleet-image"
      description = "Fleet image for my AppStream stack"
      # Specify the image type
      # image_type = "AMAZON_LINUX_2"
      # image_type = "WINDOWS_SERVER_2019"
      # You can configure the image settings
      # image_settings {
      #   # Configure the image settings for the applications
      #   applications {
      #     name           = "my-app"
      #     icon_s3_location = "s3://my-bucket/my-app-icon.ico"
      #   }
      #   # Configure the desktop settings for the image
      #   desktop_settings {
      #     desktop_name = "my-desktop"
      #     # Configure the desktop background
      #     # desktop_background {
      #     #   path = "s3://my-bucket/my-desktop-background.jpg"
      #     # }
      #   }
      #   # Configure the user settings
      #   user_settings {
      #     # Configure the user profile settings
      #     # user_profile {
      #     #   # Customize the user settings
      #     #   # name     = "my-profile"
      #     #   # icon     = "s3://my-bucket/my-profile-icon.ico"
      #     #   # file_path = "s3://my-bucket/my-profile-file.txt"
      #     # }
      #     # Configure the local storage settings
      #     # local_storage {
      #     #   # Customize the local storage size
      #     #   size_in_gb = 10
      #     # }
      #   }
      # }
    }
  }
  # Configure the application settings
  # application_settings {
  #   # Configure the application settings for the applications
  #   applications {
  #     name           = "my-app"
  #     icon_s3_location = "s3://my-bucket/my-app-icon.ico"
  #   }
  # }
}

# Create an AppStream 2.0 User
resource "aws_appstream_user" "main" {
  stack_name = aws_appstream_stack.main.name
  # Define the user properties
  username         = "my-user"
  first_name       = "My"
  last_name        = "User"
  # Configure the user settings
  # user_settings {
  #   # Configure the user profile settings
  #   # user_profile {
  #   #   # Customize the user settings
  #   #   # name     = "my-profile"
  #   #   # icon     = "s3://my-bucket/my-profile-icon.ico"
  #   #   # file_path = "s3://my-bucket/my-profile-file.txt"
  #   # }
  #   # Configure the local storage settings
  #   # local_storage {
  #   #   # Customize the local storage size
  #   #   size_in_gb = 10
  #   # }
  # }
  # You can configure the user authentication
  # authentication {
  #   type = "USER_POOL"
  #   # Configure the user pool authentication settings
  #   user_pool_authentication {
  #     # Configure the user pool ID
  #     # user_pool_id = "us-east-1_xxxxxxxxxxxxx"
  #   }
  # }
}

  
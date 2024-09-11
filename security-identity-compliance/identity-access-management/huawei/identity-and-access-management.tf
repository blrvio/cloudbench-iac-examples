
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1"
}

# Create a user
resource "huaweicloud_iam_user" "main" {
  name = "my-user"
  # Optional attributes
  # description = "My user description"
}

# Create a group
resource "huaweicloud_iam_group" "main" {
  name = "my-group"
  # Optional attributes
  # description = "My group description"
}

# Add the user to the group
resource "huaweicloud_iam_group_member" "main" {
  group_name = huaweicloud_iam_group.main.name
  user_name = huaweicloud_iam_user.main.name
}

# Create an access key for the user
resource "huaweicloud_iam_access_key" "main" {
  user_name = huaweicloud_iam_user.main.name
  # Optional attributes
  # description = "My access key description"
}

# Create a policy
resource "huaweicloud_iam_policy" "main" {
  name = "my-policy"
  # Define the policy document
  policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:ListTasks",
        "ecs:DescribeTasks",
        "ecs:RunTask",
        "ecs:StopTask",
        "ecs:DescribeServices",
        "ecs:UpdateService",
        "ecs:CreateService",
        "ecs:DeleteService"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the policy to the user
resource "huaweicloud_iam_user_policy" "main" {
  user_name = huaweicloud_iam_user.main.name
  policy_name = huaweicloud_iam_policy.main.name
}

# Attach the policy to the group
resource "huaweicloud_iam_group_policy" "main" {
  group_name = huaweicloud_iam_group.main.name
  policy_name = huaweicloud_iam_policy.main.name
}

  
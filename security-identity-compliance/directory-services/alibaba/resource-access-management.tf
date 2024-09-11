
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Create an Access Group
resource "alicloud_ram_access_group" "main" {
  name     = "example_access_group"
  comment  = "This is an example access group"
  # You can use tags to categorize your resources.
  tags = {
    Name = "example-tag-key"
    Value = "example-tag-value"
  }
}

# Create a Policy
resource "alicloud_ram_policy" "main" {
  name     = "example_policy"
  document = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["ecs:ListTasks","ecs:DescribeTasks","ecs:DescribeTaskDefinition", "ecs:RunTask", "ecs:StopTask", "ecs:StartTask", "ecs:DeleteTask", "ecs:RunTaskWithOverrides", "ecs:CreateTaskDefinition", "ecs:UpdateTaskDefinition", "ecs:RegisterTaskDefinition", "ecs:DeregisterTaskDefinition" ],
      "Resource": "*"
    }
  ]
}
EOF
  # You can use tags to categorize your resources.
  tags = {
    Name = "example-tag-key"
    Value = "example-tag-value"
  }
}

# Attach the policy to the access group
resource "alicloud_ram_policy_attachment" "main" {
  policy_name = alicloud_ram_policy.main.name
  group_name = alicloud_ram_access_group.main.name
}

# Create a Role
resource "alicloud_ram_role" "main" {
  name     = "example_role"
  comment  = "This is an example role"
  # You can use tags to categorize your resources.
  tags = {
    Name = "example-tag-key"
    Value = "example-tag-value"
  }
}

# Attach the policy to the role
resource "alicloud_ram_policy_attachment" "role_attachment" {
  policy_name = alicloud_ram_policy.main.name
  role_name  = alicloud_ram_role.main.name
}

  
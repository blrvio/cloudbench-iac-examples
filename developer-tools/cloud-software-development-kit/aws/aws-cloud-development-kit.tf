
    # Configure the AWS CDK environment
env = core.NewEnvironment(account="123456789012", region="us-east-1")

# Define a stack
stack = cdk.NewStack(app, "MyStack", props=cdk.StackProps(env=env))

# Create an S3 bucket
bucket = s3.NewBucket(stack, "MyBucket", props=s3.BucketProps(versioned=True))

# Grant read access to the bucket for everyone
bucket.GrantRead(iam.NewAllUsersPrincipal())

# Define an IAM role
role = iam.NewRole(stack, "MyRole", props=iam.RoleProps(assumed_by=iam.NewServicePrincipal("ec2.amazonaws.com")))

# Add permissions to the IAM role
role.AddToPolicy(iam.PolicyStatement(actions=['s3:*'], resources=['arn:aws:s3:::MyBucket/*'], effect=iam.Effect.ALLOW))

# Create an EC2 instance
instance = ec2.NewInstance(stack, "MyInstance", props=ec2.InstanceProps(instance_type=ec2.InstanceType.T2_MICRO, machine_image=ec2.MachineImage.LatestAmazonLinux2(), role=role))

# Output the EC2 instance's public IP address
output = cdk.NewOutput(stack, "InstancePublicIP", value=instance.InstancePublicIp())

# Deploy the stack
app.Synth()
  
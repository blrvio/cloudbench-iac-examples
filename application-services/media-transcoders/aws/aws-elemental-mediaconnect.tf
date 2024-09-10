
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a MediaConnect Flow
resource "aws_mediaconnect_flow" "main" {
  name = "my-media-connect-flow"
  # Specify the source of the flow
  source {
    # Use a live source from a device like a camera
    # or a video encoder
    # `decode` specifies that the flow should decode the
    # incoming stream
    decryption_settings {
      # Specifies a key for decryption
      # Use a value from an AWS Secrets Manager Secret or a KMS key
      # in this case, `aws_kms_key`
      # You need to configure these resources in your Terraform code
      # as well
      # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
      # and https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
      # for more details
      # `provider` and `region` should be configured for the resource
      # being referenced
      provider = "aws"
      # Example using KMS key
      # key_id = aws_kms_key.main.arn
      # Example using AWS Secrets Manager
      # secret_id = aws_secretsmanager_secret.main.arn
    }
    # For UDP source, specify the UDP endpoint information
    # For other source types, these fields will be ignored
    # You can refer to the AWS documentation for more information:
    # https://docs.aws.amazon.com/mediaconnect/latest/apireference/flow-source-udp.html
    udp {
      # The IP address of the source device
      # Replace with your device's IP address
      # The value can also be a variable for ease of management
      # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/variables
      # for more details
      ip = "10.0.0.1"
      # The port number for the source device
      port = 5004
    }
    # Specify the type of the source
    # The supported source types are:
    # `RTMP_SOURCE` and `UDP_SOURCE`
    type = "UDP_SOURCE"
  }

  # Specify the outputs of the flow
  outputs {
    # The first output will be a UDP stream
    # `description` is an optional field
    # The name of the output is also optional
    description = "My first output"
    # The IP address of the destination device
    # Replace with your device's IP address
    # The value can also be a variable for ease of management
    # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/variables
    # for more details
    ip = "10.0.0.2"
    # The port number of the destination device
    port = 5004
    # `decode` specifies whether the output should decode the
    # stream for the destination
    decode = false
    # Specify the encoding settings for the output
    # `encoding_name` is an optional field and is the name of the
    # encoding
    # `encoding_type` specifies the type of the encoding
    # Currently, the supported encoding types are:
    # `H264_VIDEO` and `AAC_AUDIO`
    encoding {
      # Specify the encoding name
      encoding_name = "My H.264 Video Encoding"
      # Specify the encoding type
      encoding_type = "H264_VIDEO"
    }
    # Specify the destination type for the output
    # The supported types are:
    # `UDP_OUTPUT` and `RTMP_OUTPUT`
    # `RTMP_OUTPUT` is not supported at the time of writing
    type = "UDP_OUTPUT"
  }

  # Define the encryption settings for the flow
  # `encryption` specifies whether the flow should be encrypted
  # The `algorithm` field specifies the encryption algorithm
  # The supported algorithm is `AES_128`
  # Currently, `algorithm` is required if `encryption` is set to `true`
  encryption {
    algorithm = "AES_128"
    # Specify whether the flow should be encrypted
    encryption = false
  }

  # Specifies the minimum latency for the flow
  # This specifies the minimum time it takes for a packet to travel
  # from the source to the destination
  # The value is expressed in milliseconds
  minimum_latency {
    # The minimum latency for the flow in milliseconds
    value = 100
  }
  # Defines the transport settings of the flow
  # The `protocol` field specifies the transport protocol to use
  # The currently supported protocol is `Zixi`
  # `max_bitrate` is an optional field that specifies the maximum
  # bitrate in bits per second (bps) for the flow
  # The `max_bitrate` field cannot be used with the Zixi transport
  # protocol
  # `max_latency` is an optional field that specifies the maximum
  # latency for the flow in milliseconds
  # The `max_latency` field cannot be used with the Zixi transport
  # protocol
  transport {
    # The transport protocol to use
    # The value must be "Zixi"
    protocol = "Zixi"
    # The maximum bitrate for the flow in bits per second
    # This field is optional
    #max_bitrate = 10000000 # 10 Mbps
    # The maximum latency for the flow in milliseconds
    # This field is optional
    #max_latency = 100
  }
}

# Create a MediaConnect Source
# You can create a source for a MediaConnect flow
# This is useful for sending content to the flow from a device
# like a camera or a video encoder
# resource "aws_mediaconnect_source" "main" {
#  # The name of the MediaConnect source
#  name = "my-source"
#  # The ID of the flow that the source will be associated with
#  flow_arn = aws_mediaconnect_flow.main.arn
#  # Specifies the encryption settings for the source
#  # `encryption` specifies whether the source should be encrypted
#  # The `algorithm` field specifies the encryption algorithm
#  # The supported algorithm is `AES_128`
#  # Currently, `algorithm` is required if `encryption` is set to `true`
#  encryption {
#    algorithm = "AES_128"
#    # Specify whether the source should be encrypted
#    encryption = false
#  }
#  # Specify the destination type for the source
#  # The supported types are:
#  # `UDP_SOURCE` and `RTMP_SOURCE`
#  # Currently, only `UDP_SOURCE` is supported
#  type = "UDP_SOURCE"
#  # Specify the transport settings of the source
#  # The `protocol` field specifies the transport protocol to use
#  # The currently supported protocol is `Zixi`
#  # `max_bitrate` is an optional field that specifies the maximum
#  # bitrate in bits per second (bps) for the source
#  # The `max_bitrate` field cannot be used with the Zixi transport
#  # protocol
#  # `max_latency` is an optional field that specifies the maximum
#  # latency for the source in milliseconds
#  # The `max_latency` field cannot be used with the Zixi transport
#  # protocol
#  transport {
#    # The transport protocol to use
#    # The value must be "Zixi"
#    protocol = "Zixi"
#    # The maximum bitrate for the source in bits per second
#    # This field is optional
#    #max_bitrate = 10000000 # 10 Mbps
#    # The maximum latency for the source in milliseconds
#    # This field is optional
#    #max_latency = 100
#  }
#}

# Create a MediaConnect Output
# You can create an output for a MediaConnect flow
# This is useful for sending content from the flow to a device
# like a video encoder or a streaming platform
# resource "aws_mediaconnect_output" "main" {
#  # The name of the MediaConnect output
#  name = "my-output"
#  # The ID of the flow that the output will be associated with
#  flow_arn = aws_mediaconnect_flow.main.arn
#  # Specifies the encryption settings for the output
#  # `encryption` specifies whether the output should be encrypted
#  # The `algorithm` field specifies the encryption algorithm
#  # The supported algorithm is `AES_128`
#  # Currently, `algorithm` is required if `encryption` is set to `true`
#  encryption {
#    algorithm = "AES_128"
#    # Specify whether the output should be encrypted
#    encryption = false
#  }
#  # Specify the destination type for the output
#  # The supported types are:
#  # `UDP_OUTPUT` and `RTMP_OUTPUT`
#  # Currently, only `UDP_OUTPUT` is supported
#  type = "UDP_OUTPUT"
#  # Specify the transport settings of the output
#  # The `protocol` field specifies the transport protocol to use
#  # The currently supported protocol is `Zixi`
#  # `max_bitrate` is an optional field that specifies the maximum
#  # bitrate in bits per second (bps) for the output
#  # The `max_bitrate` field cannot be used with the Zixi transport
#  # protocol
#  # `max_latency` is an optional field that specifies the maximum
#  # latency for the output in milliseconds
#  # The `max_latency` field cannot be used with the Zixi transport
#  # protocol
#  transport {
#    # The transport protocol to use
#    # The value must be "Zixi"
#    protocol = "Zixi"
#    # The maximum bitrate for the output in bits per second
#    # This field is optional
#    #max_bitrate = 10000000 # 10 Mbps
#    # The maximum latency for the output in milliseconds
#    # This field is optional
#    #max_latency = 100
#  }
#}

  
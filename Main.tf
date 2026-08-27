# Specifies Terraform block with required providers and versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"      # Specifies the source for the AWS provider
      version = "~> 4.16"            # Version constraint for the AWS provider
    }
  }
  required_version = ">= 1.9.8"      # Minimum Terraform version required
}

# Configures the AWS provider with a specific region
provider "aws" {
  region = "ap-south-1"              # AWS region (e.g., ap-south-1 for Asia Pacific, Mumbai)
}

# Defines an EC2 instance resource
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-04a37924ffe27da53"  # Amazon Linux 2 AMI ID (adjust to your region)
  instance_type = "t2.micro"                # Instance type (e.g., t2.micro)
  count         = 2                         # Number of instances to create (2 in this case)

  # Tags help to identify and manage resources
  tags = {
    Name = "terraform-instance-${count.index + 1}"  # Tag instances with unique names
  }
}

# Outputs the public IPs of the created EC2 instances
output "ec2_public_ips" {
  value = aws_instance.my_ec2_instance[*].public_ip  # Outputs the public IP addresses as a list
}
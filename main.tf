terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
  // Defines the AWS provider with version constraint for compatibility and reproducibility.
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  ec2_metadata_service_endpoint = ""
  // The region specifies where AWS resources will be provisioned.
  // The ec2_metadata_service_endpoint is left empty — can be removed if not used for custom endpoint configuration.
}

# EC2 Instance Resource
resource "aws_instance" "meghavm" {
  ami           = "ami-020cba7c55df1f615"   // Amazon Linux 2 AMI (make sure it's still valid and public).
  instance_type = "t2.micro"                // Free tier eligible instance type.
  subnet_id     = "subnet-07af1672b9c751ce8" // Subnet ID for the instance placement.
  key_name      = "megha-key"               // SSH key name used to access the instance.

  tags = {
    Name = "meghavm"                        // Tag used for easier identification in AWS console.
  }

  // Suggestion: Consider adding `security_groups` or `vpc_security_group_ids` for network control.
}

# Elastic IP Allocation
resource "aws_eip" "lb" {
  instance = aws_instance.meghavm.id // Associates the Elastic IP with the EC2 instance.
  domain   = "vpc"                   // Specifies that the EIP is in a VPC.
  // Suggestion: If using a NAT Gateway or Load Balancer later, this EIP can be reused or dynamically referenced.
}

# Output the public IP of the Elastic IP resource
output "public_IP" {
  value = aws_eip.lb.public_ip
  // Outputs the public IP address assigned to the instance for SSH or app access.
}

# Output the private IP of the instance
output "private_IP" {
  value = aws_instance.meghavm.private_ip
  // Outputs the private IP, useful for internal networking or inventory management.
}

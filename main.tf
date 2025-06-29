terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  ec2_metadata_service_endpoint = ""
}
resource "aws_instance" "meghavm" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  subnet_id     = "subnet-07af1672b9c751ce8"
  key_name = "megha-key"

  tags = {
    Name = "meghavm"
  }
}
resource "aws_eip" "lb" {
  instance = aws_instance.meghavm.id
  domain   = "vpc"
}
output "public_IP" {
  value = aws_eip.lb.public_ip
}

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
  access_key = "AKIA2S2Y4QHFVCTDM4L3"
  secret_key = "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"

}
resource "aws_instance" "meghavm" {
  ami           = "ami-0731becbf832f281e"
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
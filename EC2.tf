terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "SocksMachine" {
  ami = "ami-08ca3fed11864d6bb"
  instance_type = "t2.micro"
  count = 2

  tags = {
    Name = "SocksMachine"
    Owner = "ILYA"
  }

  ebs_block_device {
    device_name = "root"
    volume_size = 20
    volume_type = "gp2"
  }

    ebs_block_device {
    device_name = "data"
    volume_size = 10
    volume_type = "gp2"
  }

  security_groups = [
    aws_security_group.SecGroup1.id
  ]
}

resource "aws_security_group" "SecGroup1" {
  name = "SecGroup1"
  description = "Security Group for Developers"
  ingress {
    from_port = 22
    protocol  = "TCP"
    to_port   = 22
    description = "ILYA HOME"
    cidr_blocks = [
      "79.176.95.128/32"
    ]
  }
}


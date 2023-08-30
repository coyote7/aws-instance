terraform {
   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.16"
    }
  }
}
provider "aws" {
  region  = "us-east-2"
  profile = "ronte"
}

resource "aws_instance" "test-server" {
  ami              = ""
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.test-sgrp.id]
  user_data              = <<-EOF
               #!/bin/bash
               echo "Welcome to Our   Portal">index.html
               nohup busybox http -f -p  8080
                EOF
  user_data_replace_on_change = true

}
resource "aws_security_group" "test-sgrp" {
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

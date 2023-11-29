terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "iac-alura"
  # user_data =  <<-EOF
  #                 #!/bin/bash
  #                 cd /home/ubuntu
  #                 echo "<h1>Feito com TerraForm</h1>" > index2.html
  #                 nohup busybox httpd -f -p 8080 &
  #               EOF
  tags = {
    Name = "Terraform - Ansible - Python"
  }
}

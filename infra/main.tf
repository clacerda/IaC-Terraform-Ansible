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
  region  = var.region_aws
}

resource "aws_instance" "app_server" {
  ami           = var.ami_aws
  instance_type = var.instancia
  key_name = var.chave

  tags = {
    Name = "Terraform - Ansible - Python"
  }
}


resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
  
}

output "IP_publico" {
  value = aws_instance.app_server.public_ip
}
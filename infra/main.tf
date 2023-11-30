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
  ami           = "ami-0fc5d935ebf8bc3bc"
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
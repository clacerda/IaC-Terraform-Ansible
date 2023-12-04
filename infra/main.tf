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

resource "aws_launch_template" "maquina" {
  # ami           = var.ami_aws
  image_id = var.ami_aws
  instance_type = var.instancia
  key_name = var.chave

  tags = {
    Name = "Terraform - Ansible - Python"
  }
  # security_group_name = [var.security_group_name]
}

resource "aws_autoscaling_group" "grupo"{
  availability_zones = ["${var.region_aws}a"]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}

# resource "aws_instance" "instancia_com_template"{
#     launch_template {
#       id = aws_launch_template.maquina.id
#       version = "$Latest"
#     }
# }


resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
  
}

# output "IP_publico" {
#   value = aws_instance.app_server.public_ip
# }
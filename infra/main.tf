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

  user_data = var.producao ? filebase64("ansible.sh") : ""

  # security_group_name = [var.security_group_name]
}

resource "aws_autoscaling_group" "grupo"{
  availability_zones = ["${var.region_aws}a", "${var.region_aws}b"  ]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }

  target_group_arns = var.producao ? [ aws_lb_target_group.alvoLoadBalancer[0].arn ] : []

}


resource "aws_autoscaling_schedule" "ligarMaquina" {
  scheduled_action_name  = "ligarMaquina"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 1
  start_time             = timeadd(timestamp(), "12m")
  recurrence             = "0 7 * * MON-FRI"
  # end_time               = "2016-12-12T06:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.grupo.name
}

resource "aws_autoscaling_schedule" "desligarMaquina" {
  scheduled_action_name  = "desligarMaquina"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 0
  start_time             =  timeadd(timestamp(), "10m")
  recurrence             = "0 18 * * MON-FRI"
  # end_time               = "2016-12-12T06:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.grupo.name
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.region_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.region_aws}b"
}

resource "aws_lb" "loadBalancer" {
  internal = false
  subnets = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
  count = var.producao ? 1 : 0
}

resource "aws_lb_target_group" "alvoLoadBalancer" {
  name = "maquinasAlvo"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
  count = var.producao ? 1 : 0
}

resource "aws_default_vpc" "default" {

}

resource "aws_lb_listener" "entradaLoadBalancer" {
  load_balancer_arn = aws_lb.loadBalancer[0].arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alvoLoadBalancer[0].arn
  }

  count = var.producao ? 1 : 0
}

resource "aws_autoscaling_policy" "escala-Producao" {
  name = "terraform-escala"
  autoscaling_group_name = var.nomeGrupo
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  count = var.producao ? 1 : 0
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
module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  region_aws = "us-east-1"
  chave = "IaC-DEV"
  ami_aws = "ami-06aa3f7caf3a30282"
  security_group_name = "acesso_Dev"

  minimo = 0
  maximo = 1
  nomeGrupo = "DEV"
}

output "IP" {
  value = module.aws-dev.IP_publico
}
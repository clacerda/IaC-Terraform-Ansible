module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  region_aws = "us-east-1"
  chave = "IaC-PROD"
  ami_aws = "ami-0fc5d935ebf8bc3bc"
  security_group_name = "acesso_Prod"

  minimo = 1
  maximo = 10
  nomeGrupo = "Prod"

  producao = true
}

# output "IP_Prod" {
#   value = module.aws-prod.IP_publico
# }
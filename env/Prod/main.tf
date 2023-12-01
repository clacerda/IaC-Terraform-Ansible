module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  region_aws = "us-east-1"
  chave = "IaC-PROD"
  ami_aws = "ami-0fc5d935ebf8bc3bc"
  security_group_name = "acesso_Prod"
}

output "IP_Prod" {
  value = module.aws-prod.IP_publico
}
module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  region_aws = "us-east-1"
  chave = "IaC-DEV"
  ami_aws = "ami-06aa3f7caf3a30282"
}

output "IP" {
  value = module.aws-dev.IP_publico
}
module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  region_aws = "us-east-1"
  chave = "IaC-DEV"
}
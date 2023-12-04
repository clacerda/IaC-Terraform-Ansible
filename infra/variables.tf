variable "region_aws" {
  type = string
}

variable "chave" {
  type = string
}

variable "instancia" {
  type = string
}

variable "ami_aws" {
  type = string
}

variable "security_group_name" {
  description = "Nome do Grupo de Segurança"
  default     = "acesso_geral"
}

variable "minimo" {
  type = number
}

variable "maximo" {
  type = number
}

variable "nomeGrupo" {
  type = string
}



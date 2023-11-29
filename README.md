# INSTANCIANDO UBUNTU NA AWS COM TERRAFORM E ANSIBLE

Este é o resultado de um curso de provisionamento de recursos de infraestrutura utilizando IaC.

## Pontos interessantes:
Com este curso básico tive acesso aos comandos básicos do terraform e ansible, além de caso de uso sobre a ferramenta.

O terraform é responsável por provisionar o recurso;
O Ansible é responsável por automatizar rotinas tendo um trabalho de simbiose com o terraform.

No contexto deste caso, como é uma criação de Ubuntu vou explicar sobre este case.

Antes de tudo é necessário baixar o python3, ansible e terraform e gerar chaves de acesso dentro da AWS (arquivo .PEM) utilizado para a autenticação.

Para executar a máquina no Terraform você precisará saber o "ami" da máquina desejada, isto pode ser consultado no EC2; Após isto você precisa conhecer 3 comandos:

Inicia o projeto, baixa as dependências necessárias.
```bash
terraform init
```
Mostra a execução planejada, se vai criar, alterar ou deletar recursos.
```bash
terraform plan
```

```bash
terraform apply
```

Tem também o comando:

```bash
terraform destroy
```

Mas você precisa pesquisar sobre estes comandos e saberá quando usar cada um.

Com isto já deve criar uma máquina com o código acima.

Para a execução do Ansible,

```bash
ansible-playbook playbook.yml -u ubuntu --private-key iac-alura.pem -i hosts.yml
```

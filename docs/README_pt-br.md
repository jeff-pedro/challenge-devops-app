<a id="top"></a>
<div align="center">

  # Challenge DevOps

  > Deploy de uma aplicação na nuvem através de um container docker.

  <a>Potuguese</a> -
  <a href="./README_en.md">English</a>

</div>

<div align="center" >

  ![Tests](https://img.shields.io/github/actions/workflow/status/jeff-pedro/challenge-devops-app/deployment.yml?branch=main&style=flat-square&label=test)
  ![Build](https://img.shields.io/github/actions/workflow/status/jeff-pedro/challenge-devops-app/ecs.yml?branch=main&style=flat-square)
  ![Release](https://img.shields.io/github/v/release/jeff-pedro/challenge-devops-app?display_name=tag&include_prereleases&style=flat-square)
  ![Django Version](https://img.shields.io/badge/Django-3.1.5-blueviolet?style=flat-square&logo=django)
  ![Python Version](https://img.shields.io/pypi/pyversions/Django?style=flat-square&logo=python&color=orange)
 
</div>
Aluraflix

* criamos um aplicativo conteinerizado / compila uma imagem de container
* fazemos o push para o um repositório do ECR
* implantamos o aplicativo no ECS como fluxo de implantação continua (CD) 
---

## Sobre
Este projeto faz o deploy de uma aplicação na nuvem através de um container docker.

Para realizar o deploy é compilado uma imagem de container **Docker**, adicionado a imagem no **Amazon Elastic Container Repository (ECR)** e implantando o aplicativo no **Amazon Elastic Container Service (ECS)**. 

Todo o processo acontece de maneira automatizada como fluxo de implantação contínua (CD) usando rotinas de **CI** e **CD** do **Github Actions**. Onde a cada solicitação de **Pull Request** ao repostório da **_branch principal_** é disparado a execução das rotinas para **testar**, **construir** e **implantar** a aplicação no provedor da nuvem.


## Tecnologias usadas
- **Container**: Docker
- **Provedor**: AWS
- **Container Runner**: Amazon Elastic Container Service (ECS)
- **Repositório de Imagens**: Amazon Elastic Container Repository (ECR)
- **Infraestrutura**: Terraform


## Arquitetura
<div align="center" >

  <img src="/docs/img/architecture.svg"  alt="imagem da arquitetura da solução" width="400" align="center"/>

</div>

## Infraestrutura
- [challenge-devops-infra](https://github.com/jeff-pedro/challenge-devops-infra)


---
[Voltar ao topo da página](#top)

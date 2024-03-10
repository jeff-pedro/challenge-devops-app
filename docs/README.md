<a id="top"></a>

<div align="center">

  # Challenge DevOps

  > Deploy an application in the cloud using docker container.

  <a>English</a> -
  <a href="./README.md">Portuguese</a>

</div>

<div align="center" >

  ![Tests](https://img.shields.io/github/actions/workflow/status/jeff-pedro/challenge-devops-app/deployment.yml?branch=main&style=flat-square&label=test)
  ![Build](https://img.shields.io/github/actions/workflow/status/jeff-pedro/challenge-devops-app/ecs.yml?branch=main&style=flat-square)
  ![Release](https://img.shields.io/github/v/release/jeff-pedro/challenge-devops-app?display_name=tag&include_prereleases&style=flat-square)
  ![Django Version](https://img.shields.io/badge/Django-3.1.5-blueviolet?style=flat-square&logo=django)
  ![Python Version](https://img.shields.io/pypi/pyversions/Django?style=flat-square&logo=python&color=orange)
 
 
</div>

---

## About
This project deploys an application to the cloud using a docker container.

To perform the deployment, a **Docker** image is built, the image is added to the **Amazon Elastic Container Repository (ECR)** and the container is run on the **Amazon Elastic Container Service (ECS)**.

The entire process takes place in an automated manner using **CI** and **CD** workflows from **Github Actions**. Where each **_push_** to the repository in the **_main branch_** triggers the execution of workflows to **test**, **build** and **deploy** the application on the cloud provider.


## Technologies
- **Container**: Docker
- **Provider**: AWS
- **Container Runner**: Amazon Elastic Container Service (ECS)
- **Image Repository**: Amazon Elastic Container Repository (ECR)
- **Infrastructure**: Terraform


## Architecture
<div align="center" >

  <img src="/docs/img/architecture.svg" alt="architecture solution image" width="400" align="center"/>

</div>

## Infrastructure
- [challenge-devops-infra](https://github.com/jeff-pedro/challenge-devops-infra)


---
[Back to top](#top)

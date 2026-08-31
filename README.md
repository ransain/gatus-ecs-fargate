# Gatus App ECS Fargate

## Overview

This project deploys Gatus, an application for endpoint health monitoring, running on AWS ECS Fargate and deployed with Docker, with the Infrastructure created and modularised via Terraform, and CI/CD to automate the process, while following real DevOps practices

---

## Architecture

![Architecture Diagram](./images/gatus-architecture.jpeg)

---

## Repository Structure
```
gatus-ecs/
│
├── .github/
│   └── workflows/
│       ├── build-and-push.yml
│       ├── terraform-deploy.yml
│       └── terraform-destroy.yml
│
├── app/
│   └── Dockerfile
│
├── infra/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   │
│   └── modules/
│       ├── acm/
│       ├── alb/
│       ├── ecr/
│       ├── ecs/
│       ├── route53/
│       └── vpc/
│
├── .gitignore
│
└── README.md
```

---

## Local Development

(Docker must be installed)

```
git clone https://github.com/ransain/gatus-ecs.git
cd /app
docker build -t gatus .
docker run -p 8080 -d gatus:latest

Then visit
http://localhost:8080
```
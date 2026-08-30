# Gatus ECS Project!

## Overview

Uptime monitoring application, running on ECS. Infrastructure created with Terraform and application deployed end to end via GitHub Actions (CI/CD)

---

## Architecture

![Architecture Diagram] (./images/gatus-architecture.jpeg)

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
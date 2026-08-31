# Gatus on AWS ECS Fargate

## Overview

This project deploys Gatus, an endpoint health monitoring application, on AWS ECS Fargate. The application is containerised with Docker, with the AWS infrastructure provisioned using modular Terraform and deployments automated through GitHub Actions

---

## Key Features

- **~96% Docker image size reduction** — Optimised the container image from approximately 305 MB to 13 MB using a multi-stage build and minimal `scratch` runtime image.
- **Infrastructure as Code**-AWS infrastructure is provisioned and modularised using Terraform.
- **OIDC authentication**-GitHub Actions authenticates with AWS using OIDC, avoiding long-lived AWS access keys.
- **Container security scanning**-Docker images are scanned with Grype for known vulnerabilities before being pushed to Amazon ECR.
- **Automated CI/CD**-GitHub Actions automates image builds, security scanning, ECR publishing and Terraform deployments.
- **HTTPS & custom domain**-Application exposed through an Application Load Balancer with ACM-managed TLS and Route 53 DNS.
- **AWS ECS Fargate**-Application runs as a containerised workload on a serverless ECS deployment

---

## Live App

![App Running](./images/gatus-running.png)

---

## Architecture

The application runs as a container on ECS Fargate within an AWS VPC. An Application Load Balancer handles incoming traffic and forwards requests to the ECS service. HTTPS is provided through AWS Certificate Manager, with Route 53 handling DNS for the custom domain. Container images are stored in Amazon ECR, while Terraform manages the infrastructure

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
│   └── .dockerignore
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
cd app
docker build -t gatus .
docker run -p 8080 -d gatus:latest

Then visit
http://localhost:8080
```

---

## Docker

The application is containerised using a multi-stage Docker build, separating the build environment from the final runtime image

- Multi-stage build to keep the final image lightweight
- Uses a minimal `scratch` runtime image
- Runs as a non-root user
- Includes a `.dockerignore` to reduce unnecessary build context

The initial Docker image was approximately **305 MB**. After optimising the image, the final image was reduced to approximately **13 MB**, a reduction of around **96%**.

---

## CI/CD

GitHub Actions is used to automate the build, security scanning, infrastructure deployment and destruction process

#### Build & Push Pipeline
- Creates a Docker image of the application with a SHA commit tag
- Runs a Grype scan for identifying vulnerabilities 
- Pushes the image to ECR and updates the task definition

![Build & Push](./images/image-pipeline.png)

#### Deploy Pipeline
- Initialises Terraform and configure remote backend (S3)
- Runs linting, formatting, and validation checks
- Plan & Apply the infrastructure to deploy to AWS

![Deploy](./images/deploy-pipeline.png)

#### Destroy Pipeline
- Tears down all the infrastructure safely

![Destroy](./images/destroy-pipeline.png)
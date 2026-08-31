# Gatus on AWS ECS Fargate

## Overview

This project deploys Gatus, an endpoint health monitoring application, on AWS ECS Fargate. The application is containerised with Docker, with the AWS infrastructure provisioned using modular Terraform and deployments automated through GitHub Actions.

---

## Key Features

- **~96% Docker image size reduction**: Optimised the container image from approximately 305 MB to 13 MB using a multi-stage build and minimal `scratch` runtime image
- **Infrastructure as Code**: AWS infrastructure is provisioned and modularised using Terraform
- **OIDC authentication**: GitHub Actions authenticates with AWS using OIDC, avoiding long-lived AWS access keys
- **Container security scanning**: Docker images are scanned with Grype for known vulnerabilities before being pushed to Amazon ECR
- **Automated CI/CD**: GitHub Actions automates image builds, security scanning, ECR publishing and Terraform deployments
- **HTTPS & custom domain**: Application exposed through an Application Load Balancer with ACM-managed TLS and Route 53 DNS
- **AWS ECS Fargate**: Application runs as a containerised workload on a serverless ECS deployment

---

## Live App

![App Running](./images/gatus-running.png)

---

## Architecture

The application runs as a container on **ECS Fargate** within an **AWS VPC**. An **Application Load Balancer** handles incoming traffic and forwards requests to the ECS service. HTTPS is provided through **AWS Certificate Manager**, with **Route 53** handling DNS for the custom domain. Container images are stored in **Amazon ECR**, while **Terraform** manages the infrastructure.

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
│   ├── Dockerfile
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

Docker must be installed.

```bash
git clone https://github.com/ransain/gatus-ecs.git
cd app
docker build -t gatus .
docker run -p 8080 -d gatus:latest
```

Then visit `http://localhost:8080`

---

## Docker

The application is containerised using a multi-stage Docker build, separating the build environment from the final runtime image.

- Multi-stage build to keep the final image lightweight
- Uses a minimal `scratch` runtime image
- Runs as a non-root user
- Includes a `.dockerignore` to reduce unnecessary build context

The initial Docker image was approximately **305 MB**. After optimising the image, the final image was reduced to approximately **13 MB**, a reduction of around **96%**.

---

## Infrastructure

The AWS infrastructure is provisioned using **Terraform** and organised into reusable modules.

The infrastructure includes:

- **VPC** with subnets and networking components
- **ECS Fargate** cluster and service
- **Amazon ECR** for container image storage
- **Application Load Balancer** for routing traffic to the ECS service
- **AWS Certificate Manager (ACM)** for HTTPS
- **Route 53** for DNS
- **IAM** roles and permissions
- **Security Groups** for controlling network access
- **Amazon S3** for remote Terraform state

---

## CI/CD

GitHub Actions is used to automate the **application build**, **security scanning**, **container publishing** and **infrastructure deployment** process. All workflows are **manually triggered** to provide control over when changes are built, deployed or destroyed.

#### Build & Push Pipeline

- Builds the Docker image and tags it using the **Git commit SHA**
- Runs a **Grype vulnerability scan**
- Authenticates to AWS using **OIDC**
- Pushes the image to **Amazon ECR**
- Updates the **ECS task definition** with the new image

![Build & Push](./images/image-pipeline.png)

#### Terraform Deploy Pipeline

- Configures the **S3 remote backend**
- Runs **Terraform formatting, validation and linting**
- Creates a **Terraform plan**
- Applies the infrastructure changes to AWS

![Deploy](./images/deploy-pipeline.png)

#### Terraform Destroy Pipeline

- Runs Terraform to safely **destroy the deployed infrastructure**

![Destroy](./images/destroy-pipeline.png)

---

## Application

### 1. What is Gatus?

**Gatus** is an open-source application used to monitor the availability and health of websites, APIs and other services.

It regularly checks configured services and shows their current status through a simple dashboard. If a service becomes unavailable or stops responding as expected, Gatus can detect the issue and provide alerts.

This gives development, DevOps and infrastructure teams a simple way to see whether their services are up and running and quickly identify when something goes wrong.

### 2. Why did you choose Gatus?

I chose Gatus because it is a genuinely useful application for companies, particularly for development, DevOps and infrastructure teams that need visibility into service availability.

### 3. Why host it on ECS Fargate?

I chose **ECS Fargate** to replicate a more production-like container deployment while avoiding the need to manage the underlying servers.

EC2 or another VM could also run Gatus, but Fargate allowed me to focus on the containerised application and surrounding AWS infrastructure while AWS manages the underlying compute.

I chose AWS rather than a free hosting platform because it gives me control over the **underlying infrastructure** and allows the environment to be fully managed using **Terraform**. This includes provisioning the networking, compute, load balancing, security and supporting AWS services as infrastructure as code, rather than having these components abstracted away by the hosting platform.

### 4. How many users are there or how many are you expecting?

Expecting very few. This is primarily demonstrating a Cloud/DevOps deployment rather than a production service with a large user base. In a real world deployment, the expected users would likely be DevOps, development or infrastructure teams who need to view the health of their applications and services.
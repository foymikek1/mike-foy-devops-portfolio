# Mike Foy - Devops Portfolio  

Welcome to my DevOps portfolio! This repository showcases my work on various DevOps projects using different technologies and tools. Below you'll find the links to my projects, along with a brief description of each.

---

## 1. ECS Containerized API
A simple backend API, containerized with Docker, and deployed to AWS ECS using Terraform.

**Key Features:**  
- ✅ Dockerized REST API with basic endpoints   
- ✅ Terraform locally managed container stack (ECR, ECS & ALB)  
- CI/CD: build & push Docker image, Terraform apply with GitHub Actions  

**Technologies Used:**  
Docker · AWS ECS & ECR · Terraform · GitHub Actions

---

## 2. CloudFront-Hosted UI
A simple front-end UI deployed with AWS S3 & CloudFront using Terraform.

**Key Features:**  
- Environment-driven API integration   
- S3 static site hosting + CloudFront CDN  
- CI/CD: build automation, S3 sync & CloudFront cache invalidation  

**Technologies Used:**  
AWS S3 & CloudFront · Terraform · GitHub Actions

---

## 3. Network Infrastructure  
Foundational AWS VPC setup to house FE & BE apps.

**Key Features:**  
- Resilient VPC with two public, private, and database subnets
- KMS encryption 
- ACM managed certificates on ALB 

**Technologies Used:**  
AWS VPC, Subnets, Internet/NAT Gateways · Terraform

---

## 4. Unified CI/CD Pipeline
A unified GitHub Actions workflow that provisions the network then builds and syncs FE & BE.

**Key Features:**  
- Automated build & publish (Docker to ECR, assets to S3)  
- Terraform event driven infrastructure provisioning  
- End-to-end workflows for API and UI services  

**Technologies Used:**  
GitHub Actions · Terraform · AWS CLI · Docker · Bash  

---

## 5. Multi-Region VPC Global Peering  
A capstone showcasing global connectivity between services in two AWS regions.

**Key Features:**  
- Terraform provisioned VPCs in separate AZ's  
- Multi-region VPC peering  
- Private service-to-service communication over AWS global backbone  

**Technologies Used:**  
AWS VPC · VPC Peering · Terraform  


---

## Contact

Feel free to reach out for any questions or collaboration opportunities:

- **Email:** [foymikek@gmail.com](mailto:foymikek@gmail.com)  
- **LinkedIn:** [linkedin.com/in/michael-foy](https://www.linkedin.com/in/michael-foy/)  

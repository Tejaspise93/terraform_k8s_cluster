# Terraform_k8s_cluster


Production-ready modular AWS EKS cluster using Terraform.

## Prerequisites
- Terraform ~> 1.7
- AWS CLI configured
- kubectl installed

## Structure
```
Terraform_k8s_cluster/
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── data.tf
├── backend.tf
├── provider.tf
├── terraform.tfvars
├── backend-setup/
└── modules/
    ├── vpc/
    ├── security-group/
    ├── iam/
    └── eks/
```

## Setup

## Remote State Setup
Before deploying, you need to create the following AWS resources manually or with your own script:
- S3 bucket with versioning and encryption enabled
- Update `backend.tf` with your bucket name and region

## Deploy
```bash
terraform init
terraform workspace new dev
terraform workspace select dev
terraform plan -out=tfplan
terraform apply tfplan
```

## Configure kubectl
```bash
aws eks update-kubeconfig --region  --name 
kubectl get nodes
```

## Destroy
```bash
terraform destroy
```
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
└── modules/
    ├── vpc/
    ├── security-group/
    ├── iam/
    └── eks/
```

## Remote State Setup
Before deploying, create the following AWS resources manually:
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

## Bastion Host

To access the EKS cluster via the private endpoint, a bastion host is required.

**Requirements:**
- EC2 instance launched in one of the **public subnets** of the EKS VPC
- Same VPC as the EKS cluster
- kubectl and aws cli installed
- IAM credentials configured on the bastion using `aws configure`


> **Note:** The bastion must be in the same VPC as the EKS cluster. A bastion in a different VPC cannot reach the private endpoint unless VPC peering is configured.

### 1. Get access keys
After apply, retrieve the eks-admin IAM user credentials:
```bash
terraform output eks_admin_access_key_id
terraform output eks_admin_secret_access_key
```

### 2. Configure AWS CLI
```bash
aws configure --profile eks-admin
# Enter the access key ID from step 1
# Enter the secret access key from step 1
# Default region: us-east-1
# Default output format: json
```

### 3. Update kubeconfig
```bash
aws eks update-kubeconfig --region <YOUR_REGION> --name <YOUR_CLUSTER_NAME> --profile eks-admin
```

### 4. Verify
```bash
kubectl get nodes
```


## Destroy
```bash
terraform destroy
```
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
terraform workspace new dev  # only on first run
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
or 

```bash
terraform output kubeconfig_command
# copy the command and run the displayed command
```

### 4. Verify
```bash
kubectl get nodes
```


## (X)Destroy
```bash
terraform destroy
```



## Public Endpoint Access (Dev/Learning Setup)

 In the project the EKS **public API endpoint** (`endpoint_public_access = true`) is enabled so the cluster can be reached directly from a personal device without needing a bastion host, VPN, or Session Manager setup. This choice was made for learning and experimentation - it lets you run `kubectl` straight from your laptop and quickly setup without the need for setting up private-network access first.

To avoid exposing the endpoint to the entire internet, access is restricted using `public_access_cidrs`, which must be given at apply time.

> **(X) Production note:** This public-access setup is **not** appropriate for production. For production, set `endpoint_public_access = false` and remove eks_public_access_cidrs variable from root and eks module variable.tf and public_access_cidrs from  vpc_config in eks module main.tf, keep only `endpoint_private_access = true`, and access the cluster via a bastion host, VPN, or AWS Systems Manager Session Manager instead. A publicly reachable API endpoint in production environment and should be not allowed.

### How to apply with public access enabled

```bash
terraform init
terraform workspace new dev  # only on first run
terraform workspace select dev
terraform plan -var='eks_public_access_cidrs=["your.ip.address/32"]' -out=tfplan
terraform apply tfplan
```
### Configure AWS CLI
```bash
terraform output eks_admin_access_key_id
terraform output eks_admin_secret_access_key

aws configure --profile eks-admin
# Enter the access key ID
# Enter the secret access key
# Default region: us-east-1
# Default output format: json
```

### Update kubeconfig
```bash
aws eks update-kubeconfig --region <YOUR_REGION> --name <YOUR_CLUSTER_NAME> --profile eks-admin
```
or 

```bash
terraform output kubeconfig_command
# copy the command and run the displayed command
```

### Verify
```bash
kubectl get nodes
```
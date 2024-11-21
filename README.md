# Shared Infrastructure Repository

This repository contains the shared infrastructure required for deploying applications on an ECS cluster using Fargate. The infrastructure is managed using Terraform and deployed via GitHub Actions.

## Repository Structure
![image](https://github.com/user-attachments/assets/b6767388-ad5c-4e1a-a0ce-9f9b9b9ece15)

- **modules/**: Contains reusable Terraform modules for different infrastructure components.
- **environments/**: Contains environment-specific configurations.
- **.github/**: Contains GitHub Actions workflows.
- **main.tf**: The main Terraform configuration file.
- **variables.tf**: Defines the input variables for Terraform.

## Deployment with GitHub Actions

We use GitHub Actions to automate the deployment of our infrastructure. The workflow is defined in `.github/workflows/deploy.yml`.

### Requirements

- **AWS Credentials**: Store the AWS Access Key and Secret Key of the IAM user in GitHub secrets.
- **Matrix Deployment**: Run the same workflow across multiple environments.
- **Terraform Commands**: Use `terraform init`, `terraform plan`, and `terraform apply`.
- **Concurrency Group**: Ensure that if a build is running, other builds will be in a pending state to avoid conflicts.


  ### References
  Subscribe to my [channel](www.youtube.com/@DevOps4solutions)

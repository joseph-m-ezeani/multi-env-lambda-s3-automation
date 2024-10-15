# Terraform Lambda and S3 Setup

This repository contains code for deploying a Python AWS Lambda function and creating S3 bucket resources using Terraform. The resources are split into account-wide and environment-specific configurations, with the use of Terraform workspaces for state management.

## Repository Structure

The repository is structured as follows:

account/ - for account-wide resources

env/ - for environment-specific resources (e.g., int, sit, stg).

## Terraform Workspaces

Terraform workspaces are used to manage different environments by creating isolated states for each environment.

**Account-wide workspace**:

- Fill in the required values such as access key and secret key.

- Initialize Terraform in the `account/` directory:

```bash
cd account
terraform init
```

**Environment-specific workspaces**:

- Initialize Terraform in the `env/` directory:

```bash
cd env
terraform init
```

- Create workspaces for each environment (e.g., `int`, `sit`, `stg`):

```bash
terraform workspace new int
terraform workspace new sit
terraform workspace new stg
```

### Switch Workspaces

To switch between workspaces, use the following command:

- For account-wide workspace:

```bash
cd account
terraform workspace select np
```

- For environment-specific workspaces:

```bash
cd env
terraform workspace select int
terraform workspace select sit
terraform workspace select stg
```

## Running Terraform for Account-wide Resources

Navigate to the account/ directory:

```bash
cd account
```

Plan and apply the resources:

```bash
terraform plan
terraform apply
```

## Running Terraform for Environment-specific Resources

Navigate to the env/ directory:

```bash
cd env
```

Select the workspace for the desired environment:

For integration (int):

```bash
terraform workspace select int
```

For system integration testing (sit):

```bash
terraform workspace select sit
```

For staging (stg):

```bash
terraform workspace select stg
```

Plan and apply the resources for the selected environment:

```bash
terraform plan
terraform apply
```

## Switching Between Environments

To switch between environments (e.g., from int to sit), follow these steps:

Select the target workspace:

```bash
terraform workspace select sit
```

Plan and apply the changes for the new environment:

```bash
terraform plan
terraform apply
```

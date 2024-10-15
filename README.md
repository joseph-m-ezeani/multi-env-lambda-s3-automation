# Terraform - tf-cwl-retention-logs

Terraform Sample to deploy an automation to apply retention logs in ALL CWL Log Groups based on a specific time.

## Clone Repository

```
git@ssh.gitlab.aws.dev:andrdal/tf-cwl-retention-logs.git
```

## Deploy

01 - Adjust **variables.tf** to define your log retention time, inside **log_retention_period** variable (Default 30 days), Ex:
```
cd tf-cwl-retention-logs/terraform

vi variables.tf

#Change **default** value for your required retention time

Save the file and exit
```

02 - Deploy Terraform Code
```
terraform init
terraform plan
terraform apply --auto-approve
```

## Validation
Check inside Cloudwatch Service, if all Log Groups Retentions were modified.

## Cleanup

```
terraform destroy --auto-approve
```
